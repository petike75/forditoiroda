<?php
	
	class Nyelv {
		
		public $id;
		public $nyelv;

		function __construct($row){
			$this->id = $row['nyelv_id'];
			$this->nyelv = $row['megnevezes'];
		}
	}

?>