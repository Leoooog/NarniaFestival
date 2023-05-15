<?php

use DI\Container;
use Slim\Factory\AppFactory;

require __DIR__ . '/../vendor/autoload.php';

require __DIR__ . '/../app/container_initializer.php';

$app = AppFactory::createFromContainer($container);

$app->setBasePath('/api');

$app->add(function ($request, $handler) {
    $contentType = $request->getHeaderLine('Content-Type');
    if (strpos($contentType, 'application/json') !== false) {
        $request = $request->withParsedBody(json_decode((string)$request->getBody(), true));
    }
    return $handler->handle($request);
});

require __DIR__ . '/../app/routes.php';

$app->run();
?>
