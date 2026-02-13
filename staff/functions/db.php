<?php
//creating the database to use
//$con = mysqli_connect("localhost","hynitr_cbt","8}^RhQ3([l3.","hynitr_cbt");
//$con = mysqli_connect("localhost","fountai3_user","securemelikekilode","fountai3_cbt");
$con = mysqli_connect("localhost","root","","hynitr_cbt");

function row_count($result) {
	global $con;


	return mysqli_num_rows($result); 
}


function escape($string) {
	global $con;


	return mysqli_real_escape_string($con, $string);
}


function query($query) {
		global $con;

		return mysqli_query($con, $query);
}


function confirm($result) {
		global $con;
	if(!$result) {

		die("QUERY FAILED" . mysqli_error($con));
	}
}



function fetch_array($result) {

global $con;

return mysqli_fetch_array($result);

}

?>
