<?php

namespace App\Controllers;

use App\Errors\Err;
use Slim\Psr7\Request;
use Slim\Psr7\Response;
use App\Controllers\Controller;

class RistoranteController extends Controller {

    public function index(Request $request, Response $response, array $args) {
        $query = "SELECT BIN_TO_UUID(IdRistorante) AS IdRistorante, Nome, Descrizione, Indirizzo, Posizione, Menu, Proprietario FROM Ristoranti";
        $stmt = $this->db->prepare($query);
        $stmt->execute();

        $result = $stmt->get_result();
        $json = $this->encode_result($result);
        if (!$json) {
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
        $query = "SELECT BIN_TO_UUID(IdRistorante) AS IdRistorante, Nome, Descrizione, Indirizzo, Posizione, Menu, Proprietario FROM Ristoranti WHERE IdRistorante = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        $result = $stmt->get_result();
        if ($result->num_rows == 0) {
            $response->getBody()->write(Err::RISTORANTE_NOT_FOUND());
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
        $nome = $data['Nome'];
        $descrizione = $data['Descrizione'];
        $indirizzo = $data['Indirizzo'];
        $posizione = $data['Posizione'];
        $proprietario = $data['Proprietario'];
        $menu = $data['Menu'];

        $query = "INSERT INTO Ristoranti (Nome, Descrizione, Indirizzo, Posizione, Menu, Proprietario)
            VALUES (?, ?, ?, POINT(?, ?), ?, UUID_TO_BIN(?))";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$nome, $descrizione, $indirizzo, $posizione['lat'], $posizione['long'], $menu, $proprietario]);

        if (!$stmt) {
            $response->getBody()->write(Err::RISTORANTE_CREATION_ERROR());
            return $response->withStatus(500);
        }

        $query = "SELECT BIN_TO_UUID(IdRistorante) AS IdRistorante, Nome, Descrizione, Indirizzo, X(Posizione) AS Latitudine, Y(Posizione) AS Longitudine, Menu, Proprietario FROM Ristoranti WHERE IdRistorante = @last_ristorante_uuid";
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
        $nome = $data['Nome'];
        $descrizione = $data['Descrizione'];
        $indirizzo = $data['Indirizzo'];
        $posizione = $data['Posizione'];
        $proprietario = $data['Proprietario'];
        $menu = $data['Menu'];

        $query = "UPDATE Ristoranti SET Nome = ?, Descrizione = ?, Indirizzo = ?, Posizione = POINT(?, ?), Menu = ?, Proprietario = UUID_TO_BIN(?) WHERE IdRistorante = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$nome, $descrizione, $indirizzo, $posizione['lat'], $posizione['long'], $menu, $proprietario, $id]);

        if (!$stmt) {
            $response->getBody()->write(Err::RISTORANTE_UPDATE_ERROR());
            return $response->withStatus(500);
        }

        $query = "SELECT BIN_TO_UUID(IdRistorante) AS IdRistorante, Nome, Descrizione, Indirizzo, X(Posizione) AS Latitudine, Y(Posizione) AS Longitudine, Menu, Proprietario FROM Ristoranti WHERE IdRistorante = UUID_TO_BIN(?)";
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

        $query = "DELETE FROM Ristoranti WHERE IdRistorante = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        if (!$stmt) {
            $response->getBody()->write(Err::EVENTO_DELETE_ERROR());
            return $response->withStatus(500)->withHeader('Content-Type', 'application/json');
        }
        if ($stmt->affected_rows == 0) {
            $response->getBody()->write(Err::EVENTO_NOT_FOUND());
            return $response->withStatus(404)->withHeader('Content-Type', 'application/json');
        }
        return $response->withStatus(204);
    }
}
