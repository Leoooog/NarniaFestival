<?php
use DI\Container;
require __DIR__ . '/../app/Controllers/UserController.php';


$container = new Container();

$container->set('db', function ($container) {
    $dbhost = 'localhost';
    $dbuser = 'Leo';
    $dbpass = 'geusaserver2020';
    $dbname = 'narnia_db';

    $mysqli = new mysqli($dbhost, $dbuser, $dbpass, $dbname);

    $mysqli->set_charset('latin1');

    if ($mysqli->connect_error) {
        die('Errore di connessione (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
    }

    return $mysqli;
});

$container->set('UserController', function ($container) {
    $mysqli = $container->get('db');
    return new \App\Controllers\UserController($mysqli);
});
?>