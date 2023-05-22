<?php

namespace App\Controllers;

use App\Controllers\Controller;
use App\Errors\Err;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class BuonoController extends Controller {
    public function index(Request $request, Response $response, array $args) {
        $query = "SELECT IdBuono, Valido, Tipo, Utente FROM BuoniPasto";
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

        $query = "SELECT IdBuono, Valido, Tipo, Utente FROM BuoniPasto WHERE IdBuono = ?";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        $result = $stmt->fetch(MYSQLI_ASSOC);

        if (!$result) {
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

        $query = "INSERT INTO BuoniPasto (Tipo, Utente) VALUES (?, ?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$tipo, $utente]);

        if (!$stmt) {
            $response->getBody()->write(Err::BUONO_CREATION_ERROR());
            return $response->withStatus(500);
        }

        $query = "SELECT IdBuono, Valido, Tipo, Utente FROM BuoniPasto WHERE IdBuono = @last_uuid";
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

        $query = "UPDATE BuoniPasto SET Valido = ?, Tipo = ?, Utente = ? WHERE IdBuono = ?";
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
            return $response->withStatus(500);
        }

        return $response->withStatus(204);
    }
    public function showByUser(Request $request, Response $response, array $args) {
        $userId = $args['id'];

        $query = "SELECT IdBuono, Valido, Tipo, Utente FROM BuoniPasto WHERE Utente = ?";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$userId]);

        $result = $stmt->get_result();
        $json = $this->encode_result($result);

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

        if ($result === 0) {
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
