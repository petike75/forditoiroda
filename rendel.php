<?php

	include("core.php");

	$hibak = array();

	// Fordítók
	$forditok = array();
	$query = $MYSQL->prepare("CALL forditok();");
	$query->execute();
	$rows = $query->fetchAll();
	$query->closeCursor();
	foreach ($rows as $fordito) {
		array_push($forditok, new Fordito($fordito));
	}

	// Megrendelők
	$megrendelok = array();
	$query = $MYSQL->prepare("SELECT `megrendelo_id`, `nev` FROM `megrendelo`");
	$query->execute();
	$rows = $query->fetchAll();
	$query->closeCursor();
	foreach ($rows as $megrendelo) {
		array_push($megrendelok, new Megrendelo($megrendelo));
	}

	if (isset($_GET['fordito']) && isset($_GET['megrendelo']) && isset($_GET['oldal'])){
		$query = $MYSQL->prepare("INSERT INTO `megrendeles` (`fordito_id`, `megrendelo_id`, `datum`, `oldalszam`) VALUES (:fordito_id, :megrendelo_id, :datum, :oldalszam)");
		$query->execute([
			":fordito_id" => $_GET['fordito'],
			":megrendelo_id" => $_GET['megrendelo'],
			":datum" => date("Y-m-d"),
			":oldalszam" => $_GET['oldal']
		]);
		$query->closeCursor();
		if ($query){
			header("Location: rendel.php?siker=true");
			exit();
		} else {
			header("Location: rendel.php?siker=false");
			exit();
		}
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
			if (isset($_GET['siker'])) {
				if ($_GET['siker'] == "true") {
					echo '<br/>Sikeres adatrögzités!';
				} else {
					echo '<br/>Sikertelen adatrögzités!';
				}
			}
		?>

		<form action="rendel.php" method="get">
			<table border="1" cellpadding="1" cellspacing="1" style="width:500px">
				<tbody>
					<tr>
						<td style="text-align: right;">Fordító:</td>
						<td>
						<select name="fordito">
							<?php
								echo "<option disabled selected>Fordító</option>";
								foreach ($forditok as $fordito) {
									echo "<option value=\"$fordito->id\">$fordito->nev ($fordito->nyelv)</option>";
								}
							?>
						</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">Megrendelő:</td>
						<td>
						<select name="megrendelo">
							<?php
								echo "<option disabled selected>Megrendelő</option>";
								foreach ($megrendelok as $megrendelo) {
									echo "<option value=\"$megrendelo->id\">$megrendelo->nev</option>";
								}
							?>
						</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">Oldalszám:</td>
						<td>
						<select name="oldal">
							<?php
								echo "<option disabled selected>Fordítani kívánt oldalak</option>";
								for ($i=1; $i < 50; $i++) { 
									echo "<option value=\"$i\">$i</option>";
								}
							?>
						</select>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value="Rendelés">
						</td>
					</tr>
				</tbody>
			</table>
		</form>


	</body>

</html>