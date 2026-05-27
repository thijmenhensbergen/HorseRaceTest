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

$querycolor = $pdo->query("SELECT color FROM horse_info");
$fetchcolor = $querycolor->fetch();

$queryspeed = $pdo->query("SELECT speed FROM horse_info");
$fetchspeed = $queryspeed->fetch();

$queryiq = $pdo->query("SELECT iq FROM horse_info");
$fetchiq = $queryiq->fetch();

print_response([
    "color" => $fetchcolor['color'],
    "speed" => $fetchspeed['speed'],
    "iq" => $fetchiq['iq'],
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
