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

$foodtype = $_GET['f'];

switch ($foodtype) {
    case 0:
        DoQuery("grass", $pdo);
        break;
    case 1:
        DoQuery("hay", $pdo);
        break;
    case 2:
        DoQuery("apple", $pdo);
        break;
    case 3:
        DoQuery("carrot", $pdo);
        break;
    case 4:
        DoQuery("goldGrass", $pdo);
        break;
}
$grassquer = $pdo->query("SELECT grass FROM invent");
$grassfetch = $grassquer->fetch();

$hayquer = $pdo->query("SELECT hay FROM invent");
$hayfetch = $hayquer->fetch();

$applequer = $pdo->query("SELECT apple FROM invent");
$applefetch = $applequer->fetch();

$carrotquer = $pdo->query("SELECT carrot FROM invent");
$carrotfetch = $carrotquer->fetch();

$goldgrassquer = $pdo->query("SELECT goldGrass FROM invent");
$goldgrassfetch = $goldgrassquer->fetch();

$monquer = $pdo->query("SELECT money FROM invent");
$monfetch = $monquer->fetch();

print_response(
    ["grass" => $grassfetch['grass'], 
    "hay" => $hayfetch['hay'], 
    "apple" => $applefetch['apple'], 
    "carrot" => $carrotfetch['carrot'], 
    "goldGrass" => $goldgrassfetch['goldGrass'], 
    "money" => $monfetch['money']], 
    "success"
);

function DoQuery($val, $pdo)
{
    $amount = $_GET['c'];
    $currentamount = $pdo->query("SELECT $val FROM invent");
    $fetch = $currentamount->fetch();
    TryBuy($pdo, $fetch, $val, $amount);
}

function TryBuy($pdo, $fetch, $val, $amount)
{
    $goldquer = $pdo->query("SELECT money FROM invent");
    $goldfetch = $goldquer->fetch();
    $foodtype = $_GET['f'];

    switch ($foodtype) {
        case 0:
            if ($goldfetch['money'] >= 10 * $amount) {
                $total = intval($fetch[$val]) + intval($amount);
                $pdo->query("UPDATE invent SET $val = " . $total);
                TakeMoney(10 * $amount, $goldfetch, $pdo);
            } else {
                print_response([], "oops");
                die;
            }
            break;
        case 1:
            if ($goldfetch['money'] >= 100 * $amount) {
                $total = intval($fetch[$val]) + intval($amount);
                $pdo->query("UPDATE invent SET $val = " . $total);
                TakeMoney(100 * $amount, $goldfetch, $pdo);
            } else {
                print_response([], "oops");
                die;
            }
            break;
        case 2:
            if ($goldfetch['money'] >= 1100 * $amount) {
                $total = intval($fetch[$val]) + intval($amount);
                $pdo->query("UPDATE invent SET $val = " . $total);
                TakeMoney(1100 * $amount, $goldfetch, $pdo);
            } else {
                print_response([], "oops");
                die;
            }
            break;
        case 3:
            if ($goldfetch['money'] >= 12000 * $amount) {
                $total = intval($fetch[$val]) + intval($amount);
                $pdo->query("UPDATE invent SET $val = " . $total);
                TakeMoney(12000 * $amount, $goldfetch, $pdo);
            } else {
                print_response([], "oops");
                die;
            }
            break;
        case 4:
            if ($goldfetch['money'] >= 130000 * $amount) {
                $total = intval($fetch[$val]) + intval($amount);
                $pdo->query("UPDATE invent SET $val = " . $total);
                TakeMoney(130000 * $amount, $goldfetch, $pdo);
            } else {
                print_response([], "oops");
                die;
            }
            break;
    }
}

function TakeMoney($value, $gold, $pdo)
{
    $gold['money'] -= $value;
    $pdo->query("UPDATE invent SET money = " . $gold['money']);
}

function print_response($dictionary = [], $error = "none")
{
    $string = "";

    # Converts the dictionary into a JSON string
    $string = "{\"error\" : \"$error\",
					\"response\" : " . json_encode($dictionary) . "}";

    # Print string so godot can read it
    echo $string;
}
