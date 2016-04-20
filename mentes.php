<?php

	include("core.php");

	$hibak = array();

	/* Fordítók lekérdezése */
	$forditok = array();
	if (isset($_GET['nyelv']) && isset($_GET['min']) && isset($_GET['max'])){
		if ($_GET['min'] <= 0 || $_GET['max'] <= 0){
			array_push($hibak, "A minimum és maximum értéknek pozítív nullánál nagyobb számnak kell lennie!");
		}
		if ($_GET['min'] > $_GET['max']){
			array_push($hibak, "A minimum érték nagyobb a maximumnál, ezért a prgoram megcserélte!");
			$temp = $_GET['min'];
			$_GET['min'] = $_GET['max'];
			$_GET['max'] = $temp;
		}
		$query = $MYSQL->prepare("CALL forditokSzuken(:nyelv_id, :min, :max);");
		$query->execute([
			"nyelv_id" => $_GET['nyelv'],
			"min" => $_GET['min'],
			"max" => $_GET['max'],
		]);
	} else {
		$query = $MYSQL->prepare("CALL forditok();");
		$query->execute();
	}
	$rows = $query->fetchAll();
	$query->closeCursor();
	foreach ($rows as $fordito) {
		array_push($forditok, new Fordito($fordito));
	}

	/* Nyelvek lekérdezése */
	$query = $MYSQL->prepare("SELECT * FROM `nyelv`");
	$query->execute();
	$rows = $query->fetchAll();
	$query->closeCursor();

	$nyelvek = array();
	foreach ($rows as $nyelv) {
		$nyelvek[$nyelv['nyelv_id']] = $nyelv['megnevezes'];
	}

	if (count($hibak) < 1) {

		// Create new PHPExcel object
		$objPHPExcel = new PHPExcel();

		// Set properties
		$objPHPExcel->getProperties()->setCreator("Czibula Peter");
		$objPHPExcel->getProperties()->setLastModifiedBy("Czibula Peter");
		$objPHPExcel->getProperties()->setTitle("Office 2007 XLSX Test Document");
		$objPHPExcel->getProperties()->setSubject("Office 2007 XLSX Test Document");
		$objPHPExcel->getProperties()->setDescription("Javitas informaciok");

		// Add some data
		$objPHPExcel->setActiveSheetIndex(0);
		$objPHPExcel->getActiveSheet()->SetCellValue('A1', 'Név');
		$objPHPExcel->getActiveSheet()->SetCellValue('B1', 'Nyelv');
		$objPHPExcel->getActiveSheet()->SetCellValue('C1', 'Fordítási díj');
		$objPHPExcel->getActiveSheet()->SetCellValue('D1', 'Napi fordított oldalak');
		$objPHPExcel->getActiveSheet()->SetCellValue('E1', 'Telefonszám');

		$i = 2;
		foreach ($forditok as $fordito) {
			$objPHPExcel->getActiveSheet()->SetCellValue('A' . $i, $fordito->nev);
			$objPHPExcel->getActiveSheet()->SetCellValue('B' . $i, $fordito->nyelv);
			$objPHPExcel->getActiveSheet()->SetCellValue('C' . $i, $fordito->forditas_dij);
			$objPHPExcel->getActiveSheet()->SetCellValue('D' . $i, $fordito->napi_oldalszam);
			$objPHPExcel->getActiveSheet()->SetCellValue('E' . $i, $fordito->telefonszam);
			$i++;
		}


		// Rename sheet
		$objPHPExcel->getActiveSheet()->setTitle("Forditasok");

		// Header
		$ido = date("Y-m-d_H.i.s"); 
		header("Content-Type: application/vnd.ms-excel");
		$time = date("Y-m-d H:i:s");
		if (isset($_GET['nyelv']) && isset($_GET['min']) && isset($_GET['max'])){
			header("Content-Disposition: attachment;filename='forditok_(".$nyelvek[$_GET['nyelv']]."_".$_GET['min']."-".$_GET['max']."oldal_".count($forditok).")_".$ido.".xls'");
		} else {
			header("Content-Disposition: attachment;filename='forditok_osszes_oldal_".count($forditok)."_".$ido.".xls'");
		}
		header("Cache-Control: max-age=0");

		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
		$objWriter->save('php://output');

	} else {

		echo 'Sajnálom nem sikerült a fájl létrehozása! Hibák:';
		foreach ($hibak as $hiba) {
			echo $hiba . '<br/>';
		}

	}

?>