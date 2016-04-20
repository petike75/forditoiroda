<?php

	class Megrendelo {

		public $id;
		public $nev;

		public function __construct($row) {
			$this->id = $row['megrendelo_id'];
			$this->nev = $row['nev'];
		}

	}

?>