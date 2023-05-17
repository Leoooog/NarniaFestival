<?php
use App\Controllers\BuonoController;
use App\Controllers\EventoController;
use App\Controllers\PrenotazioneController;
use App\Controllers\StrutturaController;
use DI\Container;
use App\Controllers\UserController;
use App\Jwt\JwtInvalidator;
$container = new Container();

$container->set('db', function ($container) {
    $dbhost = $_ENV['DB_HOST'];
    $dbuser = $_ENV['DB_USERNAME'];
    $dbpass =  $_ENV['DB_PASSWORD'];
    $dbname = $_ENV['DB_NAME'];

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
    return new UserController($mysqli);
});

$container->set('BuonoController', function ($container) {
    $mysqli = $container->get('db');
    return new BuonoController($mysqli);
});
$container->set('EventoController', function ($container) {
    $mysqli = $container->get('db');
    return new EventoController($mysqli);
});

$container->set('PrenotazioneController', function ($container) {
    $mysqli = $container->get('db');
    return new PrenotazioneController($mysqli);
});

$container->set('StrutturaController', function ($container) {
    $mysqli = $container->get('db');
    return new StrutturaController($mysqli);
});


$container->set('JWTInvalidator', function ($container) {
    $mysqli = $container->get('db');
    return new JwtInvalidator($mysqli);
});
?>