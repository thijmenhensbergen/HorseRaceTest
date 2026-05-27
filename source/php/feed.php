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


$querylvl = $pdo->query("SELECT lvl FROM horse_info");
$fetchlvl = $querylvl->fetch();

$queryxp = $pdo->query("SELECT xp FROM horse_info");
$fetchxp = $queryxp->fetch();

$queryspeed = $pdo->query("SELECT speed FROM horse_info");
$fetchspeed = $queryspeed->fetch();

$queryiq = $pdo->query("SELECT iq FROM horse_info");
$fetchiq = $queryiq->fetch();

$xp = $fetchxp['xp'];
$xpneeded = $fetchlvl['lvl'] * 100;
$lvl = $fetchlvl['lvl'];
$feededxp = $_GET['c'];
$speed = $fetchspeed['speed'];
$iq = $fetchiq['iq'];

$xp += $feededxp;
while ($xp >=  $xpneeded) {
    $lvl++;
    $xp -= $xpneeded;
    $speed += rand(1, 3);
    $iq += rand(1, 3);
}
$type = $_GET['f'];
$querremove = $pdo->query("SELECT $type FROM invent");
$result = $querremove->fetch();
if ($result[$type] >= 1) {
    $result[$type] -= 1;
    // Remove 1 food from database.
    $pdo->query("UPDATE invent SET $type = " . $result[$type]);
    // Update Database
    $queryupdate = $pdo->query("UPDATE horse_info SET lvl = $lvl, xp = $xp, speed = $speed, iq = $iq;");
    print_response([], "successful");
    die;
}
print_response([], "no_food_left");

function print_response($dictionary = [], $error = "none")
{
    $string = "";

    # Converts the dictionary into a JSON string
    $string = "{\"error\" : \"$error\",
					\"response\" : " . json_encode($dictionary) . "}";

    # Print string so godot can read it
    echo $string;
}
