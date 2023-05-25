<?php

namespace App\Controllers;

use App\Controllers\Controller;
use App\Errors\Err;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class BuonoController extends Controller {
    public function index(Request $request, Response $response, array $args) {
        $query = "SELECT BIN_TO_UUID(IdBuono) AS IdBuono, Valido, Tipo, BIN_TO_UUID(Utente) AS Utente FROM BuoniPasto";
        $stmt = $this->db->prepare($query);
        $stmt->execute();

        $result = $stmt->get_result();
        $json = $this->encode_result($result);
        if(!$json) {
            $json = "[]";
        }

        $response->getBody()->write($json);
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function show(Request $request, Response $response, array $args) {
        $id = $args['id'];
        if (!preg_match("/^[0-9a-f]{8}-[0-9a-f]{4}-1[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i", $id)) {
            $response->getBody()->write(Err::MALFORMED_UUID());
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }
        $query = "SELECT BIN_TO_UUID(IdBuono) AS IdBuono, Valido, Tipo, BIN_TO_UUID(Utente) AS Utente FROM BuoniPasto WHERE IdBuono = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        $result = $stmt->get_result();
        if ($result->num_rows == 0) {
            $response->getBody()->write(Err::BUONO_NOT_FOUND());
            return $response
                ->withStatus(404)
                ->withHeader('Content-Type', 'application/json');
        }

        $json = $this->encode_result($result);

        $response->getBody()->write($json);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function create(Request $request, Response $response, array $args) {
        $data = $request->getParsedBody();
        $tipo = $data['Tipo'];
        $utente = $data['Utente'];
        if (!preg_match("/^[0-9a-f]{8}-[0-9a-f]{4}-1[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i", $utente)) {
            $response->getBody()->write(Err::MALFORMED_UUID());
            return $response
                ->withStatus(403)
                ->withHeader('Content-Type', 'application/json');
        }
        $query = "INSERT INTO BuoniPasto (Tipo, Utente) VALUES (?, UUID_TO_BIN(?))";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$tipo, $utente]);

        if (!$stmt) {
            $response->getBody()->write(Err::BUONO_CREATION_ERROR());
            return $response->withStatus(500);
        }

        $query = "SELECT BIN_TO_UUID(IdBuono) AS IdBuono, Valido, Tipo, BIN_TO_UUID(Utente) AS Utente FROM BuoniPasto WHERE IdBuono = @last_uuid";
        $stmt = $this->db->prepare($query);
        $stmt->execute();

        $result = $stmt->get_result();
        $json = $this->encode_result($result);

        $response->getBody()->write($json);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(201);
    }

    public function update(Request $request, Response $response, array $args) {
        $id = $args['id'];
        $data = $request->getParsedBody();
        $valido = $data['Valido'];
        $tipo = $data['Tipo'];
        $utente = $data['Utente'];

        $query = "UPDATE BuoniPasto SET Valido = ?, Tipo = ?, Utente = UUID_TO_BIN(?) WHERE IdBuono = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$valido, $tipo, $utente, $id]);

        if (!$stmt) {
            $response->getBody()->write(Err::BUONO_UPDATE_ERROR());
            return $response->withStatus(500);
        }

        $query = "SELECT IdBuono, Valido, Tipo, Utente FROM BuoniPasto WHERE IdBuono = ?";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        $result = $stmt->get_result();
        $json = $this->encode_result($result);

        $response->getBody()->write($json);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function delete(Request $request, Response $response, array $args) {
        $id = $args['id'];

        $query = "DELETE FROM BuoniPasto WHERE IdBuono = ?";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        if (!$stmt) {
            $response->getBody()->write(Err::BUONO_DELETE_ERROR());
            return $response->withStatus(500)->withHeader('Content-Type', 'application/json');
        }
        if($stmt->affected_rows == 0) {
            $response->getBody()->write(Err::BUONO_NOT_FOUND());
            return $response->withStatus(404)->withHeader('Content-Type', 'application/json');
        }
        return $response->withStatus(204);
    }
    public function showByUser(Request $request, Response $response, array $args) {
        $userId = $args['id'];

        $query = "SELECT BIN_TO_UUID(IdBuono) AS IdBuono, Valido, Tipo, BIN_TO_UUID(Utente) AS Utente FROM BuoniPasto WHERE Utente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$userId]);

        $result = $stmt->get_result();
        $json = $this->encode_result($result);
        if(!$json) {
            $json = "[]";
        }

        $response->getBody()->write($json);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    }

    public function burn(Request $request, Response $response, array $args) {
        $buonoId = $args['id'];

        $query = "UPDATE BuoniPasto SET Valido = 0 WHERE IdBuono = ?";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$buonoId]);
        $result = $stmt->get_result();

        if ($stmt->affected_rows == 0) {
            return $response
                ->withHeader('Content-Type', 'application/json')
                ->withStatus(404)
                ->getBody()
                ->write(Err::BUONO_NOT_FOUND());
        }

        return $response
            ->withStatus(200);
    }
}
