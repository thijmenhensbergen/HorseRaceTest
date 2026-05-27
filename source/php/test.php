<?php

$host = '127.0.0.1';
$db = 'horse_racing';
$user = 'bit_academy';
$pass = 'bit_academy';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
];

$pdo = new PDO($dsn, $user, $pass, $options);




$queryname = $pdo->query("SELECT name FROM horse_info");
$fetchname = $queryname->fetch();

$querycolor = $pdo->query("SELECT color FROM horse_info");
$fetchcolor = $querycolor->fetch();

$querylvl = $pdo->query("SELECT lvl FROM horse_info");
$fetchlvl = $querylvl->fetch();

$queryxp = $pdo->query("SELECT xp FROM horse_info");
$fetchxp = $queryxp->fetch();

$queryspeed = $pdo->query("SELECT speed FROM horse_info");
$fetchspeed = $queryspeed->fetch();

$queryiq = $pdo->query("SELECT iq FROM horse_info");
$fetchiq = $queryiq->fetch();

$querygrass = $pdo->query("SELECT grass FROM invent");
$fetchgrass = $querygrass->fetch();

$queryhay = $pdo->query("SELECT hay FROM invent");
$fetchhay = $queryhay->fetch();

$queryapple = $pdo->query("SELECT apple FROM invent");
$fetchapple = $queryapple->fetch();

$querycarrot = $pdo->query("SELECT carrot FROM invent");
$fetchcarrot = $querycarrot->fetch();

$querygoldGrass = $pdo->query("SELECT goldGrass FROM invent");
$fetchgoldGrass = $querygoldGrass->fetch();

print_response([
    "name" => $fetchname['name'],
    "color" => $fetchcolor['color'],
    "lvl" => $fetchlvl['lvl'],
    "xp" => $fetchxp['xp'],
    "speed" => $fetchspeed['speed'],
    'iq' => $fetchiq['iq'],
    'grass' => $fetchgrass['grass'],
    'hay' => $fetchhay['hay'],
    'apple' => $fetchapple['apple'],
    'carrot' => $fetchcarrot['carrot'],
    'goldGrass' => $fetchgoldGrass['goldGrass']
], "godot_test");

function print_response($dictionary = [], $error = "none")
{
    $string = "";

    # Converts the dictionary into a JSON string
    $string = "{\"error\" : \"$error\",
					\"response\" : " . json_encode($dictionary) . "}";

    # Print string so godot can read it
    echo $string;
}
