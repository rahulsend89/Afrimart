<?php
$uploaddir = './uploads/';
$file = rand(0,999999)."_".time().basename($_FILES['userfile']['name']);
//$file = basename($_FILES['userfile']['name']);
$uploadfile = $uploaddir . $file;
if (move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile)) {
        echo "{$file}";
}else{
	echo "error";	
}
?>