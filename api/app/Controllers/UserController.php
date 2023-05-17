<?php

namespace App\Controllers;

use App\Controllers\Controller;
use App\Errors\Err;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use \mysqli;

require __DIR__ . '/Controller.php';
class UserController extends Controller
{

    public function index(Request $request, Response $response, array $args)
    {

        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente, Nome, Cognome, Username, Email, Verificato, Ruolo FROM Utenti";
        $result = $this->db->query($query);

        $json = $this->encode_result($result);

        $response->getBody()->write($json);
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function show(Request $request, Response $response, array $args)
    {
        $id = $args['id'];
        $token = $request->getAttribute("token");
        $role = $token->role;
        if ($role != 'admin') {
            $userid = $token->sub;
            if ($userid != $id) {
                $response->getBody()->write(Err::NOT_AUTHORIZED());
                return $response
                    ->withStatus(401)
                    ->withHeader('Content-Type', 'application/json');
            }
        }

        if (preg_match("/^[0-9a-f]{8}-[0-9a-f]{4}-1[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i", $id) !== 1) {
            $response->getBody()->write(Err::MALFORMED_UUID());
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }

        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente, Nome, Cognome, Username, Email, Verificato, Ruolo, DataCreazione FROM Utenti WHERE IdUtente = UUID_TO_BIN('$id') ";
        $result = $this->db->query($query);

        $json = $this->encode_result($result);

        if (!$json) {
            $response->getBody()->write(Err::USER_NOT_FOUND());
            return $response
                ->withStatus(404)
                ->withHeader('Content-Type', 'application/json');
        }


        $response->getBody()->write($json);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function create(Request $request, Response $response, array $args)
    {
        $data = $request->getParsedBody();
        $email = $data['Email'];
        $query = "SELECT EXISTS (SELECT IdUtente FROM Utenti WHERE Email = '$email')";
        $result = $this->db->query($query);
        if ($result->fetch_all()[0][0] == 1) {
            $response->getBody()->write(Err::EMAIL_IN_USE());
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }
        $username = $data['Username'];
        $query = "SELECT EXISTS (SELECT IdUtente FROM Utenti WHERE Username = '$username')";
        $result = $this->db->query($query);
        if ($result->fetch_all()[0][0] == 1) {
            $response->getBody()->write(Err::USERNAME_IN_USE());
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }
        $nome = $data['Nome'];
        $cognome = $data['Cognome'];
        $password_hash = $data['PasswordHash'];

        $codice = mt_rand(100000, 999999);
        $headers = array(
            'From' => 'Narnia Festival App <leonardo.geusa.s@iisenzoferrari.it>',
            'Reply-To' => 'leonardo.geusa.s@iisenzoferrari.it'
        );
        mail($email, "Codice di verifica NarniaFestival App", "Il tuo codice di verifica: $codice", $headers);
        $query = "INSERT INTO Utenti (Nome, Cognome, Username, PasswordHash, Email, CodiceVerifica) VALUES ('$nome', '$cognome', '$username', '$password_hash', '$email', $codice)";
        $result = $this->db->query($query);

        if (!$result) {
            $response->getBody()->write(Err::USER_CREATION_ERROR());
            return $response->withStatus(500);
        }

        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente FROM Utenti WHERE Email = '$email'";
        $result = $this->db->query($query);
        $json = $this->encode_result($result);

        $response->getBody()->write($json);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(201);
    }

    public function update(Request $request, Response $response, array $args)
    {
        $id = $args['id'];
        $data = $request->getParsedBody();
        $nome = $data['Nome'];
        $cognome = $data['Cognome'];
        $email = $data['Email'];
        $username = $data['Username'];
        $password = $data['PasswordHash'];

        $query = "UPDATE Utenti SET Nome = '$nome', Email = '$email', PasswordHash = '$password', Username = '$username', Cognome = '$cognome' WHERE IdUtente = UUID_TO_BIN('$id')";
        $result = $this->db->query($query);

        if (!$result) {
            $response->getBody()->write(Err::USER_UPDATE_ERROR());
            return $response->withStatus(500);
        }

        $query = "SELECT * FROM Utenti WHERE IdUtente = UUID_TO_BIN('$id')";
        $result = $this->db->query($query);
        $user = $result->fetch_assoc();

        $payload = json_encode($user);
        $response->getBody()->write($payload);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function verify(Request $request, Response $response, array $args)
    {
        $data = $request->getParsedBody();
        $code = $data['Codice'];
        $query = "UPDATE Utenti SET Verificato = TRUE WHERE Verificato = FALSE AND CodiceVerifica = $code AND TIMESTAMPDIFF(minute, NOW(), DataVerifica) < 30;";
        $this->db->query($query);
        //todo: controlla se funziona
        if (mysqli_affected_rows($this->db) != 1) {
            $response->getBody()->write(Err::WRONG_VERIFY_CODE());
            return $response->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }

        return $response->withStatus(200);
    }

    public function delete(Request $request, Response $response, array $args)
    {
        $id = $args['id'];

        $query = "DELETE FROM Utenti WHERE IdUtente = UUID_TO_BIN('$id')";
        $result = $this->db->query($query);

        if (!$result) {
            $response->getBody()->write(Err::USER_DELETE_ERROR());
            return $response->withStatus(500);
        }

        return $response->withStatus(204);
    }

    public function login(Request $request, Response $response, array $args)
    {
        $data = $request->getParsedBody();
        $username = $data['Username'];
        $password = $data['Password'];

        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente, Ruolo FROM Utenti WHERE (Username = '$username' AND PasswordHash = '$password') OR (Email = '$username' AND PasswordHash = '$password')";
        $result = $this->db->query($query);

        if (mysqli_num_rows($result) == 0) {
            $response->getBody()->write(Err::LOGIN_FAILED());
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }
        $row = $result->fetch_assoc();
        $userid = $row['IdUtente'];
        $ruolo = $this->ruoli[$row['Ruolo']];
        $payload = [
            'sub' =>  "$userid",
            'iat' => time(),
            'exp' => time() + 3600,
            'role' => "$ruolo" // Ruolo dell'utente
        ];
        
        $token = JWT::encode($payload, $this->key->getKeyMaterial(), $this->key->getAlgorithm());
        $response->getBody()->write($token);
        return $response->withStatus(200)->withHeader('Content-Type', 'application/text');
    }
}
?>