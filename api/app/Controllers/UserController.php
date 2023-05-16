<?php

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use \mysqli;

require __DIR__ . '/Controller.php';
class UserController extends \App\Controllers\Controller
{
    protected $db;

    public function __construct(mysqli $db)
    {
        $this->db = $db;
    }

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
        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente, Nome, Cognome, Username, Email, Verificato, Ruolo FROM Utenti WHERE IdUtente = UUID_TO_BIN('$id') ";
        $result = $this->db->query($query);

        $json = $this->encode_result($result);

        if (!$json) {
            $response->getBody()->write(json_encode(['message' => 'Utente non trovato']));
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
            $response->getBody()->write(json_encode(['message' => 'Email in uso']));
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }
        $username = $data['Username'];
        $query = "SELECT EXISTS (SELECT IdUtente FROM Utenti WHERE Username = '$username')";
        $result = $this->db->query($query);
        if ($result->fetch_all()[0][0] == 1) {
            $response->getBody()->write(json_encode(['message' => 'Username in uso']));
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }
        $nome = $data['Nome'];
        $cognome = $data['Cognome'];
        $password_hash = $data['PasswordHash'];

        $codice = 0;
        //email di verifica

        $query = "INSERT INTO Utenti (Nome, Cognome, Username, PasswordHash, Email, CodiceVerifica) VALUES ('$nome', '$cognome', '$username', '$password_hash', '$email', $codice)";
        $result = $this->db->query($query);

        if (!$result) {
            $response->getBody()->write(json_encode(['message' => 'Errore durante la creazione dell\'utente']));
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
        $nome = $data['nome'];
        $email = $data['email'];
        $password = $data['password'];

        $query = "UPDATE Utenti SET nome = '$nome', email = '$email', password = '$password' WHERE id = $id";
        $result = $this->db->query($query);

        if (!$result) {
            $response->getBody()->write(json_encode(['message' => 'Errore durante l\'aggiornamento dell\'utente']));
            return $response->withStatus(500);
        }

        $query = "SELECT * FROM Utenti WHERE id = $id";
        $result = $this->db->query($query);
        $user = $result->fetch_assoc();

        $payload = json_encode($user);
        $response->getBody()->write($payload);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function delete(Request $request, Response $response, array $args)
    {
        $id = $args['id'];

        $query = "DELETE FROM Utenti WHERE id = $id";
        $result = $this->db->query($query);

        if (!$result) {
            $response->getBody()->write(json_encode(['message' => 'Errore durante l\'eliminazione dell\'utente']));
            return $response->withStatus(500);
        }

        return $response->withStatus(204);
    }
}
?>