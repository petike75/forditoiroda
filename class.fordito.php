<?php
	
	class Fordito {

		public $id;
		public $nev;
		public $nyelv;
		public $forditas_dij;
		public $napi_oldalszam;
		public $telefonszam;

		public function __construct($row) {
			$this->id = $row['fordito_id'];
			$this->nev = $row['nev'];
			$this->nyelv = $row['nyelv'];
			$this->forditas_dij = $row['forditasi_dij'];
			$this->napi_oldalszam = $row['napi_oldalszam'];
			$this->telefonszam = $row['telefon'];
		}

	}

?>