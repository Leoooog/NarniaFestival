<?php

use App\Errors\Err;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Log\LoggerInterface;
use Slim\Exception\HttpMethodNotAllowedException;
use Slim\Exception\HttpNotFoundException;
use Slim\Factory\AppFactory;
use Slim\Psr7\Response;

require __DIR__ . '/../vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__.'/..');
$dotenv->load();

require __DIR__ . '/../app/container_initializer.php';

$app = AppFactory::createFromContainer($container);

$app->setBasePath('/api');

$app->addRoutingMiddleware();


$customErrorHandler = function (
    ServerRequestInterface $request,
    Throwable $exception,
    bool $displayErrorDetails,
    bool $logErrors,
    bool $logErrorDetails,
    ?LoggerInterface $logger = null
) {
    $response = new Response();
    if($exception instanceof HttpNotFoundException) {
        
        $response->getBody()->write(Err::ERROR("Risorsa non trovata"));
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(404);
    }else if($exception instanceof HttpMethodNotAllowedException) {
        $response->getBody()->write(Err::ERROR("Metodo non accettato"));
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(405);
    }
    $response->getBody()->write(Err::ERROR($exception->getMessage()));
    return $response->withHeader('Content-Type', 'application/json')
    ->withStatus(500);
};


$errorMiddleware = $app->addErrorMiddleware(true, true, true);
$errorMiddleware->setDefaultErrorHandler($customErrorHandler);

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
