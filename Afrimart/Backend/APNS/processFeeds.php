<?php

require_once("../config.php");
require_once("../classes/DataService.php");


//get the list of feeds
$feeds = DataService::singleton()->getFeeds();

//process each feed
foreach($feeds as $feed){

	$messages = processFeed($feed);
	
}

function processFeed($feed){
	
	
	echo "\n<br/>Checking feed: [{$feed->FeedName}] [{$feed->FeedUrl}]";
	
	
	
	//load the xml.
	$feedContents = file_get_contents($feed->FeedUrl);
	$feedXml = simplexml_load_string($feedContents);
	
	//check if its an RSS feed.
	if (!$feedXml->channel->item) { 
       	echo "Is does not appear to be RSS. Atom is not supported for the moment.";
        return false; 
    } 
	
	//check for new messages
	$newItems = array();
	foreach($feedXml->channel->item as $item){
	
		//var_dump($item);
	
		//check if message is new
		$timestamp = strtotime($item->pubDate);
		$itemDate = date('Y-m-d H:i:s', $timestamp);
		
		//echo "<br/>itemDate: {$itemDate} ++ DateLastUpdated: {$feed->DateLastUpdated}";
		
		if($itemDate <= $feed->DateLastUpdated){
			echo "\n<br/>Item is older, skipping. Item Date: [{$itemDate}] < Date Last Updated:[{$feed->DateLastUpdated}] [{$item->title}] ";
			continue;
		}
		
		//update the dateLastUpdated for the feed
		DataService::singleton()->updateFeedDateLastUpdated($feed->FeedId, $itemDate);
		
		//Add title to list
		$message = (string)$feed->FeedName .": " .(string)$item->title;
		array_push($newItems, $message);
		
		//We can only push one item, so this will be it.
		break;
		
	}
	
	//update the dateLastChecked for the feed
	DataService::singleton()->updateFeedDateLastChecked($feed->FeedId);
	
	//if nothing found continue
	if(count($newItems) == 0){
		return;
	}
	
	echo "<textarea cols=50 rows=10>";
	var_dump($newItems);
	echo "</textarea>";
	
	
	//get list of Devices associated to feed.
	$devices = DataService::singleton()->getFeedDevices($feed->FeedId);
	
	//var_dump($devices);
	
	//create a new message on the queue for each of them
	foreach ($devices as $device) {
	    echo "in devices";
	    
	   	//if we are in test mode, only submit to test devices
	   	if($_GET['onlyTestDevices'] == 1 && $device->IsTestDevice == 0){
	   		continue;
	   	}
	   	
	   	//submit the messages to the queue
		foreach($newItems as $item){
			echo "\n<br/>Message submitted to queue for DeviceId: [{$device->DeviceId}] DeviceNotes: [{$device->DeviceNotes}]";
	    	DataService::singleton()->addMessage($device->CertificateId, $device->DeviceId, $item);
		}	
		
	}
	
	

}



?>