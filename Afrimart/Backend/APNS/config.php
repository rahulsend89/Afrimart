<?php
//set_time_limit(10);

//SQL Connection Parameters
define('DBHOST', 'localhost');
define('DBNAME', 'APNS');
define('DBUSERNAME', 'root');
define('DBPASSWORD', '');

//Certificate folder
$certificateFolder = 'certificates';

//Push and Feedback servers
//These urls are stored in mySQL in the CertificateTypes table.

//Date settings. Apple uses UTC dates for Feedback info
date_default_timezone_set('UTC');
?>