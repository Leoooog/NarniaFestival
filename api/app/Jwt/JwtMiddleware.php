<?php
namespace App\Jwt;


use App\Errors\Err as Errore;
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
        $this->secretkey = new Key($_ENV['SECRET_KEY'], 'HS256');
    }
    public function __invoke(Request $request, RequestHandler $handler)
    {
        $token = str_replace("Bearer ", "", $request->getHeaderLine("Authorization"));

        try {
            global $container;
            $decodedToken = JWT::decode($token, $this->secretkey);
            if (!$container->get('JWTInvalidator')->isValid($token)) {
                $response = new Response();
                $response->getBody()->write(Errore::TOKEN_NOT_VALID());
                echo "a";
                return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
            }
            
            $request = $request->withAttribute('encoded_token', $token);
            $request = $request->withAttribute('token', $decodedToken);

            $role = $decodedToken->role;
            if (!in_array($role, $this->allowedRoles)) {
                $response = new Response();
                $response->getBody()->write(Errore::NOT_AUTHORIZED());
                return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
            }
        } catch (\Exception $e) {
            $response = new Response();
            $response->getBody()->write(Errore::TOKEN_NOT_VALID());
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }

        return $handler->handle($request);
    }
}

?>