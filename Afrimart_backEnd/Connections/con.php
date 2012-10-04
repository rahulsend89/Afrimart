<?php
# FileName="Connection_php_mysql.htm"
# Type="MYSQL"
# HTTP="true"
$hostname_con = "localhost";
$database_con = "APNS";
$username_con = "root";
$password_con = "";
$con = mysql_pconnect($hostname_con, $username_con, $password_con) or trigger_error(mysql_error(),E_USER_ERROR); 
?>