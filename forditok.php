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
		array_push($nyelvek, new Nyelv($nyelv));
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
			echo $hiba . '<br />';
		}
	?>

		<form action="forditok.php" method="get">
			<select name="nyelv">
				<?php
					if (!isset($_GET['nyelv'])) {
						echo "<option disabled selected>Válasz nyelvet</option>";
						foreach ($nyelvek as $nyelv) {
							echo "<option value=\"$nyelv->id\">$nyelv->nyelv</option>";
						}
					} else {
						echo "<option disabled>Válasz nyelvet</option>";
						foreach ($nyelvek as $nyelv) {
							if ($nyelv->id == $_GET['nyelv']) {
								echo "<option value=\"$nyelv->id\" selected>$nyelv->nyelv</option>";
							} else {
								echo "<option value=\"$nyelv->id\">$nyelv->nyelv</option>";
							}
						}
					}
				?>
			</select>

			<select name="min">
				<?php
					if (!isset($_GET['min'])) {
						echo "<option disabled selected>Minimum oldal</option>";
						for ($i=1; $i < 50; $i++) {
							echo "<option value=\"$i\">$i</option>";
						}
					} else {
						echo "<option disabled>Minimum oldal</option>";
						for ($i=1; $i < 50; $i++) {
							if ($i == $_GET['min']){
								echo "<option value=\"$i\" selected>$i</option>";
							} else {
								echo "<option value=\"$i\">$i</option>";
							}
						}
					}
				?>
			</select>

			<select name="max">
				<?php
					if (!isset($_GET['max'])) {
						echo "<option disabled selected>Maximum oldal</option>";
						for ($i=1; $i < 50; $i++) {
							echo "<option value=\"$i\">$i</option>";
						}
					} else {
						echo "<option disabled>Maximum oldal</option>";
						for ($i=1; $i < 50; $i++) {
							if ($i == $_GET['max']){
								echo "<option value=\"$i\" selected>$i</option>";
							} else {
								echo "<option value=\"$i\">$i</option>";
							}
						}
					}
				?>
			</select>
			<input type="submit" value="Szűkités">
		</form>
		<a href="forditok.php"><button>Mindet</button></a>
		<?php
			if (isset($_GET['nyelv']) && isset($_GET['min']) && isset($_GET['max'])){
				$nyelv = $_GET['nyelv'];
				$min = $_GET['min'];
				$max = $_GET['max'];
				echo "<a href=\"mentes.php?nyelv=$nyelv&min=$min&max=$max\"><button>Mentés</button></a>";
			} else {
				echo "<a href=\"mentes.php\"><button>Mentés</button></a>";
			}
		?>
		<?php

			if (isset($_GET['nyelv']) && isset($_GET['min']) && isset($_GET['max']) && count($forditok) < 1){
					echo '<br/>Sajnálom nincs találat a megadott paraméterekre!';
				} else {
					?>
		<table>

			<thead>
				<tr>
					<th data-field="name">Név</th>
					<th data-field="lang">Nyelv</th>
					<th data-field="cost">Fordítási díj</th>
					<th data-field="pageperday">Napi fordított oldalszám</th>
					<th data-field="phone">Telefonszám</th>
				</tr>
			</thead>

			<tbody>
			<?php
				
				foreach ($forditok as $fordito) {
					echo "<tr>
					<td data-field=\"name\">$fordito->nev</td>
					<td data-field=\"lang\">$fordito->nyelv</td>
					<td data-field=\"cost\">$fordito->forditas_dij</td>
					<td data-field=\"pageperday\">$fordito->napi_oldalszam</td>
					<td data-field=\"phone\">$fordito->telefonszam</td>
					</tr>";
				}
			}
			?>
			</tbody>
				
		</table>

	</body>

</html>