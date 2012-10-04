<?php
require_once('config.php');
require_once('classes/DataService.php');
require_once('classes/Apns.php');

echo "<br/>Started processing Feedback";

//get the certificates
$certificates = DataService::singleton()->getCertificates();

foreach ($certificates as $certificate) {

	//only process apps that have a certificate associated to it.
	if($certificate->KeyCertFile == ''){
	
		echo "<br/>Certfile not set for App: [{$certificate->CertificateName}]";
		continue;
	}
	//var_dump($certificate);
    //connect to feedback server
    $certificatePath = $certificateFolder . '/' . $certificate->KeyCertFile;
    
    $server = DataService::singleton()->getCertificateServer($certificate->CertificateId, 2);
    $apns = new apns($server->ServerUrl, $certificatePath, $certificate->Passphrase);

    //get tokens
    $feedbackTokens = $apns->getFeedbackTokens();

    //close connection
    unset($apns);

    //print the number of tokens to check for
    $countTotal = count($feedbackTokens);
    echo "<br/>There are [{$countTotal}] tokens notified by feedback";

    //loop trough the tokens
    foreach ($feedbackTokens as $feedbackToken) {

        //only DeActivate devices that where updated before they where removed. Otherwise the user could of installed the app again.
        DataService::singleton()->setDeviceInactive($feedbackToken['devtoken'], $app->AppId, $feedbackToken['timestamp']);
    }
}
echo "<br/>Completed processing Feedback";
?>