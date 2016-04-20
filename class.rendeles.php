<?php

	class Rendeles {

		public $megrendeles_id;
		public $rendeles_datum;
		public $megrendelo_nev;
		public $forditas_nyelve;
		public $fordito_nev;
		public $oldalszam;
		public $forditas_dij;
		public $iranyar;

		public function __construct($row){
			$this->megrendeles_id = $row['megrendeles_id'];
			$this->rendeles_datum = $row['rendeles_datum'];
			$this->megrendelo_nev = $row['megrendelo_nev'];
			$this->forditas_nyelve = $row['forditas_nyelve'];
			$this->fordito_nev = $row['fordito_nev'];
			$this->oldalszam = $row['oldalszam'];
			$this->forditas_dij = number_format($row['forditas_dij'], 0, '.', ',');
			$this->iranyar = number_format($row['iranyar'], 0, '.', ',');
		}

	}

?>