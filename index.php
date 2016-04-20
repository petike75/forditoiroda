<?php

	include("core.php");

	$query = $MYSQL->prepare("SELECT count(megrendeles_id) AS szam FROM `megrendeles`");
	$query->execute();
	$row = $query->fetch();
	$query->closeCursor();
	$rendelesekCount = $row['szam'];

	$hibak = array();

	$leptetes = 0;
	if (isset($_GET['leptetes'])){
		$leptetes = $_GET['leptetes'];
		if (($leptetes < 0) || ($leptetes % 5 != 0)) {
			array_push($hibak, "Csak pozitív egész öttel osztható számokkal léptethetsz!");
		}
	}

	$page = 0;
	if(isset($_GET['page'])){
		$temp = $_GET['page'];
		if ($temp < 1){
			array_push($hibak, "Túl alacsony oldalszám!");
		} else if ($rendelesekCount / $leptetes < $page) {
			array_push($hibak, "Túl magas oldalszám!");
		} else {
			$page = $temp - 1;
		}
	}

	$rendelesek = array();
	if (isset($_GET['leptetes']) && isset($_GET['page'])){
		$query = $MYSQL->prepare("CALL megrendelesekSzuken(:itemek, :oldal);");
		$query->execute([
			":itemek" => $_GET['leptetes'],
			":oldal" => $_GET['page']
		]);
	} else {
		$query = $MYSQL->prepare("CALL megrendelesek();");
		$query->execute();
	}
	$rows = $query->fetchAll();
	$query->closeCursor();

	// Rendelések tömbe mentése
	foreach ($rows as $rendeles) {
		array_push($rendelesek, new Rendeles($rendeles));
	}

?>

<!DOCTYPE html>
<html>

	<head>
	
		<title></title>
		<meta charset="utf8" />
		
	</head>

	<body>

		<?php
			include("navbar.php");
			foreach ($hibak as $hiba) {
				echo $hiba . "<br>";
			}

		?>

		<div class="container">

			<form action="index.php" method="get">
				<select name="leptetes">
					<option value="" disabled selected>Elemek oldalanként</option>
					<?php
						for($i = 0; $i < $rendelesekCount / 5; $i++){
							if (isset($_GET['leptetes']) && (($i + 1) * 5) == $_GET['leptetes']){
								echo '<option value="'. (($i + 1) * 5).'" selected>' . (($i + 1) * 5). '</option>';
							} else {
								echo '<option value="'. (($i + 1) * 5).'">' . (($i + 1) * 5). '</option>';
							}
						}
					?>
				</select>

				<select name="page">
					<option value="" disabled selected>Válasz oldalszámot</option>
					<?php
						for($i = 0; $i < $rendelesekCount; $i++){
							if (isset($_GET['page']) && ($i + 1) == $_GET['page']){
								echo '<option value="' . ($i + 1). '" selected>' . ($i + 1). '</option>';
							} else {
								echo '<option value="' . ($i + 1). '">' . ($i + 1). '</option>';
							}
						}
					?>
				</select>

				<input type="submit" value="Ugrás">

			</form>
			<a href="index.php"><button>Mindet</button></a>

			 <table>
				<thead><tr>
					<th data-field="id">#</th>
					<th data-field="date">Rendelés dátuma</th>
					<th data-field="name">Megrendelő neve</th>
					<th data-field="lang">Fordítás nyelve</th>
					<th data-field="translater">Fordító neve</th>
					<th data-field="page">Oldalszám</th>
					<th data-field="dij">Díj</th>
					<th data-field="cost">Fordításért fizetett összeg</th>
				</tr></thead>

				<tbody>
				<?php

					//for($i = $page; $i < ($leptetes > 0 ? $page + $leptetes : $rendelesekCount); $i++){
						//$rendeles = $rendelesek[$i];
					foreach($rendelesek as $rendeles){
						echo "<tr><td data-field=\"\">$rendeles->megrendeles_id</td>
		<td data-field=\"\">$rendeles->rendeles_datum</td>
		<td data-field=\"\">$rendeles->megrendelo_nev</td>
		<td data-field=\"\">$rendeles->forditas_nyelve</td>
		<td data-field=\"\">$rendeles->fordito_nev</td>
		<td data-field=\"\">$rendeles->oldalszam</td>
		<td data-field=\"\">$rendeles->forditas_dij</td>
		<td data-field=\"\">$rendeles->iranyar</td></tr>";
					}
				?></tbody>
				
			</table>

		</div>
		
	</body>

</html>
<!--
SELECT rendeles.megrendeles_id AS megrendeles_id, rendeles.datum AS rendeles_datum, megrendelo.nev AS megrendelo_nev, nyelv.megnevezes AS forditas_nyelve, fordito.nev AS fordito_nev, rendeles.oldalszam AS oldalszam, fordito.forditasi_dij AS forditas_dij FROM `megrendeles` AS rendeles
LEFT JOIN `fordito` AS fordito ON rendeles.fordito_id = fordito.fordito_id
LEFT JOIN `megrendelo` AS megrendelo ON rendeles.megrendelo_id = megrendelo.megrendelo_id
LEFT JOIN `nyelv` AS nyelv ON fordito.nyelv_id = nyelv.nyelv_id
-->