<?php require_once('Connections/con.php'); ?>
<?php
if (!function_exists("GetSQLValueString")) {
function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
{
  if (PHP_VERSION < 6) {
    $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
  }

  $theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);

  switch ($theType) {
    case "text":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;    
    case "long":
    case "int":
      $theValue = ($theValue != "") ? intval($theValue) : "NULL";
      break;
    case "double":
      $theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
      break;
    case "date":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;
    case "defined":
      $theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
      break;
  }
  return $theValue;
}
}

$editFormAction = $_SERVER['PHP_SELF'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . htmlentities($_SERVER['QUERY_STRING']);
}

$uploaddir = './uploads/';
$file = rand(0,999999)."_".time().basename($_FILES['userfile']['name']);
//$file = basename($_FILES['userfile']['name']);
$uploadfile = $uploaddir . $file;
if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
        echo "{$file}";
}else{
	echo "error";	
}
  $insertSQL = sprintf("INSERT INTO Afrimart_data (image, `comment`, region, pincode, name, phone) VALUES (%s, %s, %s, %s, %s, %s)",
                       GetSQLValueString($file, "text"),
                       GetSQLValueString($_POST['comment'], "text"),
                       GetSQLValueString($_POST['region'], "text"),
                       GetSQLValueString($_POST['pincode'], "int"),
                       GetSQLValueString($_POST['name'], "text"),
                       GetSQLValueString($_POST['phone'], "text"));

  mysql_select_db($database_con, $con);
  $Result1 = mysql_query($insertSQL, $con) or die(mysql_error());
  
mysql_select_db($database_con, $con);
$query_Recordset1 = "SELECT * FROM Afrimart_data";
$Recordset1 = mysql_query($query_Recordset1, $con) or die(mysql_error());
$row_Recordset1 = mysql_fetch_assoc($Recordset1);
$totalRows_Recordset1 = mysql_num_rows($Recordset1);

mysql_free_result($Recordset1);
?>