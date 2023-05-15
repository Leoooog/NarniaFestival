<?php

use DI\Container;
use Slim\Factory\AppFactory;

require __DIR__ . '/../vendor/autoload.php';

require __DIR__ . '/../app/container_initializer.php';

$app = AppFactory::createFromContainer($container);

$app->setBasePath('/api');

$app->add(function ($request, $handler) {
    // JSON ACCEPT
    $contentType = $request->getHeaderLine('Content-Type');
    if (strpos($contentType, 'application/json') !== false) {
        $request = $request->withParsedBody(json_decode((string)$request->getBody(), true));
    }
    
    // CORS ACCEPT
    $response = $handler->handle($request);
    return $response
            ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
});
require __DIR__ . '/../app/routes.php';
$app->run();
?>
