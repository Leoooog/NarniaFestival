<?php
namespace App;
use App\Errors\Err;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Slim\Psr7\Response as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;

class JwtMiddleware
{

    private $allowedRoles;
    private $secretkey;
    public function __construct($allowedRoles)
    {
        $this->allowedRoles = $allowedRoles;
        $this->secretkey = new Key("42f6974fd06f2d41bb4e135f5ca3cce2e7543c7925047c523275239f6a6c2737d751c6b09185d80062b8f3768e2f8e94fd84a15ce29ddad50bfe1af59ecb8f39", 'HS256');
    }
    public function __invoke(Request $request, RequestHandler $handler)
    {
        $token = str_replace("Bearer ", "", $request->getHeaderLine("Authorization"));

        try {
            // Decodifica e verifica il token JWT utilizzando la chiave segreta
            $decodedToken = JWT::decode($token, $this->secretkey);
if(!JWTInvalidator::isValid($token)) {
$response = new Response();
            $response->getBody()->write(Err::TOKEN_NOT_VALID());
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
}
            // Aggiungi il token decodificato alla richiesta
            $request = $request->withAttribute('token', $decodedToken);

            $role = $decodedToken->role;
            if (!in_array($role, $this->allowedRoles)) {
                $response = new Response();
                $response->getBody()->write(Err::NOT_AUTHORIZED());
                return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
            }
        } catch (\Exception $e) {
            $response = new Response();
            $response->getBody()->write(Err::TOKEN_NOT_VALID());
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }

        // Token valido, procedi con la richiesta
        return $handler->handle($request);
    }
}

?>