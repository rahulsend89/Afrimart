<?php

require_once("../config.php");
require_once("../classes/DataService.php");

if(!isset($_REQUEST['certificateId']) || $_REQUEST['certificateId'] == ''){
	exit("\nParameter not set");
}

//Get the certificate object
$certificate = DataService::singleton()->GetCertificate($_REQUEST['certificateId']);
//var_dump($certificate);

//get the subscriptions
$subscriptionsArray = DataService::singleton()->getAppSubscriptions($certificate->AppId);
//var_dump($subscriptionsArray);


echo json_encode($subscriptionsArray); 

?>