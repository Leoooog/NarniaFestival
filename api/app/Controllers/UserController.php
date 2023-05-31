<?php

namespace App\Controllers;

use App\Controllers\Controller;
use App\Errors\Err;
use Firebase\JWT\JWT;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class UserController extends Controller {

    public function index(Request $request, Response $response, array $args) {

        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente, Nome, Cognome, Username, Email, Verificato, Ruolo, DataCreazione FROM Utenti";
        $stmt = $this->db->prepare($query);
        $stmt->execute();

        $result = $stmt->get_result();
        $json = $this->encode_result($result);

        $response->getBody()->write($json);
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function show(Request $request, Response $response, array $args) {
        $id = $args['id'];
        $token = $request->getAttribute("token");
        $role = $token->role;
        $userid = $token->sub;
        if ($userid != $id && $role != 'admin') {
            $response->getBody()->write(Err::NOT_AUTHORIZED());
            return $response
                ->withStatus(401)
                ->withHeader('Content-Type', 'application/json');
        }

        if (!preg_match("/^[0-9a-f]{8}-[0-9a-f]{4}-1[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i", $id)) {
            $response->getBody()->write(Err::MALFORMED_UUID());
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }

        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente, Nome, Cognome, Username, Email, Verificato, Ruolo, DataCreazione FROM Utenti WHERE IdUtente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        $result = $stmt->get_result();
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

    public function me(Request $request, Response $response, array $arg) {
        $token = $request->getAttribute("token");
        $userid = $token->sub;
        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente, Nome, Cognome, Username, Email, Verificato, Ruolo, DataCreazione FROM Utenti WHERE IdUtente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$userid]);

        $result = $stmt->get_result();
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

    public function create(Request $request, Response $response, array $args) {
        $data = $request->getParsedBody();
        $email = $data['Email'];

        $query = "SELECT EXISTS (SELECT IdUtente FROM Utenti WHERE Email = ?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$email]);
        $result = $stmt->get_result();
        $result = $result->fetch_column();

        if ($result == 1) {
            $response->getBody()->write(Err::EMAIL_IN_USE());
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }

        $username = $data['Username'];
        $query = "SELECT EXISTS (SELECT IdUtente FROM Utenti WHERE Username = ?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$username]);
        $result = $stmt->get_result();
        $result = $result->fetch_column();

        if ($result == 1) {
            $response->getBody()->write(Err::USERNAME_IN_USE());
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }

        $nome = $data['Nome'];
        $cognome = $data['Cognome'];
        $password_hash = $data['PasswordHash'];

        $codice = mt_rand(100000, 999999);

        $query = "INSERT INTO Utenti (Nome, Cognome, Username, PasswordHash, Email, CodiceVerifica) VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$nome, $cognome, $username, $password_hash, $email, $codice]);

        if (!$stmt) {
            $response->getBody()->write(Err::USER_CREATION_ERROR());
            return $response->withStatus(500);
        }
        $this->sendmail($email, $nome, $codice);

        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente FROM Utenti WHERE IdUtente = @last_utente_uuid";
        $stmt = $this->db->prepare($query);
        $stmt->execute();

        $result = $stmt->get_result();
        $json = $this->encode_result($result);

        $response->getBody()->write($json);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(201);
    }

    private function sendmail($email, $nome, $codice) {
        $headers = array(
            'From' => 'Narnia Festival App <leonardo.geusa.s@iisenzoferrari.it>',
            'Reply-To' => 'leonardo.geusa.s@iisenzoferrari.it',
            'Content-Type' => 'text/html;charset=UTF-8'
        );
        $message = '<!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Verifica Account</title>
            <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                padding: 20px;
                margin: 0;
              }
              .container {
                max-width: 600px;
                margin: 0 auto;
                background-color: #ffffff;
                border-radius: 6px;
                padding: 30px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
              }
              h1 {
                color: #333333;
                font-size: 24px;
                margin-bottom: 20px;
              }
              p {
                color: #555555;
                font-size: 16px;
                line-height: 1.5;
                margin-bottom: 20px;
              }
              .verification-code {
                font-size: 28px;
                font-weight: bold;
                color: #0088cc;
                padding: 10px 20px;
                background-color: #f4f4f4;
                border-radius: 4px;
                margin-bottom: 20px;
              }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>Verifica Account</h1>
                <p>Ciao ' . $nome . ',</p>
                <p>Ti ringraziamo per esserti registrato. Di seguito trovi il codice di verifica per attivare il tuo account:</p>
                <p class="verification-code">' . $codice . '</p>
                <p>Copia il codice di verifica nel campo apposito per completare la verifica dell\'account.</p>
                <p>Se non hai richiesto la registrazione, ignora semplicemente questa email.</p>
                <p>Nota: il codice è valido soltanto per 5 minuti, dopodiché dovrai richiederne un altro</p>
                <p>Grazie,</p>
                <p>Team Narnia Festival</p>
            </div>
        </body>
        </html>
        ';
        mail($email, "Codice di verifica NarniaFestival App", $message, $headers);
    
    }

    public function sendNewCode(Request $request, Response $response, array $args) {
        $id = $args['id'];
        $query = "SELECT Email, Nome FROM Utenti WHERE IdUtente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);
        $result = $stmt->get_result();
        if($result->num_rows == 0) {
            $response->getBody()->write(Err::USER_NOT_FOUND());
            return $response->withStatus(404);
        }
        $row = $result->fetch_assoc();
        $email = $row['Email'];
        $nome = $row['Nome'];
        $codice = mt_rand(100000, 999999);
        $query = "UPDATE Utenti SET CodiceVerifica = ?, DataVerifica = CURRENT_TIMESTAMP WHERE IdUtente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$codice, $id]);
        if (!$stmt) {
            $response->getBody()->write(Err::USER_CREATION_ERROR());
            return $response->withStatus(500);
        }
        $this->sendmail($email, $nome, $codice);
        return $response->withStatus(200);
    }

    public function update(Request $request, Response $response, array $args) {
        $id = $args['id'];
        $data = $request->getParsedBody();
        $nome = $data['Nome'];
        $cognome = $data['Cognome'];
        $email = $data['Email'];
        $username = $data['Username'];

        $token = $request->getAttribute("token");
        $role = $token->role;
        $userid = $token->sub;
        if ($userid != $id && $role != 'admin') {
            $response->getBody()->write(Err::NOT_AUTHORIZED());
            return $response
                ->withStatus(401)
                ->withHeader('Content-Type', 'application/json');
        }

        $query = "UPDATE Utenti SET Nome = ?, Email = ?, Username = ?, Cognome = ? WHERE IdUtente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$nome, $email, $username, $cognome, $id]);
        $result = $stmt->get_result();
        if (!$stmt) {
            $response->getBody()->write(Err::USER_UPDATE_ERROR());
            return $response->withStatus(500);
        }

        if ($stmt->affected_rows == 0) {
            $response->getBody()->write(Err::USER_NOT_FOUND());
            return $response->withStatus(404);
        }

        $query = "SELECT * FROM Utenti WHERE IdUtente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        $user = $stmt->fetch(MYSQLI_ASSOC);

        $payload = json_encode($user);
        $response->getBody()->write($payload);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function verify(Request $request, Response $response, array $args) {
        $data = $request->getParsedBody();
        $code = $data['Codice'];

        $query = "UPDATE Utenti SET Verificato = TRUE WHERE Verificato = FALSE AND CodiceVerifica = ? AND TIMESTAMPDIFF(minute, DataVerifica, NOW()) < 5";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$code]);
        if ($stmt->affected_rows == 0) {
            $response->getBody()->write(Err::WRONG_VERIFY_CODE());
            return $response->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }

        return $response->withStatus(200);
    }

    public function delete(Request $request, Response $response, array $args) {
        $id = $args['id'];

        $query = "DELETE FROM Utenti WHERE IdUtente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        if (!$stmt) {
            $response->getBody()->write(Err::USER_DELETE_ERROR());
            return $response->withStatus(500)->withHeader('Content-Type', 'application/json');
        }

        if ($stmt->affected_rows == 0) {
            $response->getBody()->write(Err::USER_NOT_FOUND());
            return $response->withStatus(404)->withHeader('Content-Type', 'application/json');
        }

        return $response->withStatus(204);
    }

    public function login(Request $request, Response $response, array $args) {
        $data = $request->getParsedBody();
        $username = $data['Username'];
        $password = $data['Password'];

        $query = "SELECT BIN_TO_UUID(IdUtente) AS IdUtente, Ruolo, Verificato FROM Utenti WHERE (Username = ? AND PasswordHash = ?) OR (Email = ? AND PasswordHash = ?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$username, $password, $username, $password]);
        $result = $stmt->get_result();
        if ($result->num_rows == 0) {
            $response->getBody()->write(Err::LOGIN_FAILED());
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }
        $row = $result->fetch_assoc();
        if (!$row['Verificato']) {
            $response->getBody()->write(Err::NOT_VERIFIED());
            return $response->withStatus(401)->withHeader('Content-Type', 'application/json');
        }
        $userid = $row['IdUtente'];
        $ruolo = $this->ruoli[$row['Ruolo']];
        $payload = [
            'sub' =>  "$userid",
            'iat' => time(),
            'exp' => time() + $_ENV['TOKEN_EXPIRE_TIME'],
            'role' => "$ruolo"
        ];

        $token = JWT::encode($payload, $_ENV['SECRET_KEY'], 'HS256');
        $response->getBody()->write($token);
        return $response->withStatus(200)->withHeader('Content-Type', 'application/text');
    }
}
