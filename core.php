<?php
	
	foreach (glob("class.*.php") as $filename) {
	    include $filename;
	}

	//include("class.rendeles.php");

	/* PHP EXCEL */
	include("plugins/PHPExcel.php");
	include("plugins/PHPExcel/Writer/Excel2007.php");

	$MYSQL = new PDO('mysql:host=localhost;dbname=forditoiroda;port=3306', 'root', '');
	$MYSQL->exec("SET names utf8");


?>