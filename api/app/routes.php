<?php
use App\JwtMiddleware;
include_once __DIR__.'/JwtMiddleware.php';
$app->get('/utenti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->index($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->get('/utenti/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->show($request, $response, $args);
})->add(new JwtMiddleware(['iscritto', 'ospite', 'ristorante', 'admin']));

$app->post('/utenti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->create($request, $response, $args);
});

$app->put('/utenti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->update($request, $response, $args);
})->add(new JwtMiddleware(['iscritto', 'ospite', 'ristorante', 'admin']));

$app->post('/utenti/verifica_codice', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->verify($request, $response, $args);
});

$app->delete('/utenti/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->delete($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->post('/login', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->login($request, $response, $args);
})
?>