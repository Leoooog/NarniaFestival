<?php
use Slim\App;


$app->get('/utenti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->index($request, $response, $args);
});

$app->get('/utenti/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->show($request, $response, $args);
});

$app->post('/utenti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->create($request, $response, $args);
});