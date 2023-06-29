<?php
use App\Jwt\JwtMiddleware;


// ---------------------- UTENTI ----------------------

$app->get('/utenti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->index($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->post('/utenti/{id}/new_code', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->sendNewCode($request, $response, $args);
});

$app->get('/utenti/me', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->me($request, $response, $args);
})->add(new JwtMiddleware(['iscritto', 'ospite', 'ristorante', 'admin']));

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

$app->put('/utenti/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->update($request, $response, $args);
})->add(new JwtMiddleware(['iscritto', 'ospite', 'ristorante', 'admin']));

$app->post('/utenti/{id}/verifica_codice', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->verify($request, $response, $args);
});

$app->delete('/utenti/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->delete($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

// ---------------------- Login/Logout ----------------------

$app->post('/login', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('UserController');
    return $controller->login($request, $response, $args);
});

$app->post('/logout', function ($request, $response, $args) {
    global $container;
    $invalidator = $container->get('JWTInvalidator');
    return $invalidator->invalidate($request, $response, $args);
})->add(new JwtMiddleware(['iscritto', 'ospite', 'ristorante', 'admin']));

// ---------------------- EVENTI ----------------------

$app->get('/eventi', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('EventoController');
    return $controller->index($request, $response, $args);
});

$app->get('/eventi/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('EventoController');
    return $controller->show($request, $response, $args);
});

$app->post('/eventi', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('EventoController');
    return $controller->create($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->put('/eventi', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('EventoController');
    return $controller->update($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->delete('/eventi', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('EventoController');
    return $controller->delete($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

// ---------------------- PRENOTAZIONI ----------------------

$app->get('/prenotazioni', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('PrenotazioneController');
    return $controller->index($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->get('/utenti/{id}/prenotazioni', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('PrenotazioneController');
    return $controller->showByUser($request, $response, $args);
})->add(new JwtMiddleware(['iscritto', 'ospite', 'ristorante', 'admin']));

$app->post('/prenotazioni', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('PrenotazioneController');
    return $controller->create($request, $response, $args);
})->add(new JwtMiddleware(['iscritto', 'ospite', 'ristorante', 'admin']));

$app->get('/prenotazioni/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('PrenotazioneController');
    return $controller->show($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->put('/prenotazioni/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('PrenotazioneController');
    return $controller->update($request, $response, $args);
})->add(new JwtMiddleware(['admin', 'iscritto', 'ospite', 'ristorante']));

$app->delete('/prenotazioni/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('PrenotazioneController');
    return $controller->delete($request, $response, $args);
})->add(new JwtMiddleware(['admin', 'iscritto', 'ospite', 'ristorante']));

$app->post('/prenotazioni/{id}/validate', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('PrenotazioneController');
    return $controller->validate($request, $response, $args);
})->add(new JwtMiddleware(['admin']));



// ---------------------- RISTORANTI ----------------------

$app->get('/ristoranti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('RistoranteController');
    return $controller->index($request, $response, $args);
});

$app->get('/ristoranti/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('RistoranteController');
    return $controller->show($request, $response, $args);
});

$app->post('/ristoranti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('RistoranteController');
    return $controller->create($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->put('/ristoranti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('RistoranteController');
    return $controller->update($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->put('/ristoranti/{id}/menu', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('RistoranteController');
    return $controller->updateMenu($request, $response, $args);
})->add(new JwtMiddleware(['admin', 'ristorante']));


$app->delete('/ristoranti', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('RistoranteController');
    return $controller->delete($request, $response, $args);
})->add(new JwtMiddleware(['admin']));


// ---------------------- BUONI PASTO ----------------------

$app->get('/buoni_pasto', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('BuonoController');
    return $controller->index($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->get('/utenti/{id}/buoni_pasto', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('BuonoController');
    return $controller->showByUser($request, $response, $args);
})->add(new JwtMiddleware(['iscritto', 'ospite', 'ristorante', 'admin']));

$app->get('/ristoranti/{id}/buoni_pasto', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('BuonoController');
    return $controller->showByRistorante($request, $response, $args);
})->add(new JwtMiddleware(['ristorante', 'admin']));

$app->get('/buoni_pasto/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('BuonoController');
    return $controller->show($request, $response, $args);
})->add(new JwtMiddleware(['admin', 'ristorante', 'iscritto']));

$app->post('/buoni_pasto', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('BuonoController');
    return $controller->create($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->delete('/buoni_pasto/{id}', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('BuonoController');
    return $controller->delete($request, $response, $args);
})->add(new JwtMiddleware(['admin']));

$app->post('/buoni_pasto/{id}/brucia', function ($request, $response, $args) {
    global $container;
    $controller = $container->get('BuonoController');
    return $controller->burn($request, $response, $args);
})->add(new JwtMiddleware(['admin', 'ristorante']));

$app->options('/{routes:.+}', function ($request, $response, $args) {
    return $response;
});
?>
