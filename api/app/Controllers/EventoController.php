<?php

namespace App\Controllers;

use App\Errors\Err;
use Slim\Psr7\Request;
use Slim\Psr7\Response;
use App\Controllers\Controller;

class EventoController extends Controller {

    public function index(Request $request, Response $response, array $args) {
        $query = "SELECT BIN_TO_UUID(IdEvento) AS IdEvento, Titolo, Sottotitolo, Descrizione, Durata, Data, Luogo, Posizione, Tipo, Prezzo, ConPrenotazione, Capienza, PostiOccupati FROM Eventi";
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
        $query = "SELECT BIN_TO_UUID(IdEvento) AS IdEvento, Titolo, Sottotitolo, Descrizione, Durata, Data, Luogo, Posizione, Tipo, Prezzo, ConPrenotazione, Capienza, PostiOccupati FROM Eventi WHERE IdEvento = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        $result = $stmt->get_result();
        if ($result->num_rows == 0) {
            $response->getBody()->write(Err::EVENTO_NOT_FOUND());
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
        $titolo = $data['Titolo'];
        $sottotitolo = $data['Sottotitolo'];
        $descrizione = $data['Descrizione'];
        $durata = $data['Durata'];
        $dataEvento = $data['Data'];
        $luogo = $data['Luogo'];
        $posizione = $data['Posizione'];
        $tipo = $data['Tipo'];
        $prezzo = $data['Prezzo'];
        $conprenotazione = $data['ConPrenotazione'];
        $capienza = $data['Capienza'];
        $query = "INSERT INTO Eventi (Titolo, Sottotitolo, Descrizione, Durata, Data,
        Luogo, Posizione,Tipo, Prezzo, ConPrenotazione, Capienza)
        VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$titolo, $sottotitolo, $descrizione, $durata, $dataEvento, $luogo, $posizione, $tipo, $prezzo, $conprenotazione, $capienza]);

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
    $titolo = $data['Titolo'];
    $sottotitolo = $data['Sottotitolo'];
    $descrizione = $data['Descrizione'];
    $durata = $data['Durata'];
    $dataEvento = $data['Data'];
    $luogo = $data['Luogo'];
    $posizione = $data['Posizione'];
    $tipo = $data['Tipo'];
    $prezzo = $data['Prezzo'];
    $conPrenotazione = $data['ConPrenotazione'];
    $capienza = $data['Capienza'];

    $query = "UPDATE Eventi SET Titolo = ?, Sottotitolo = ?, Descrizione = ?, Durata = ?, Data = ?, Luogo = ?, Posizione = ?, Tipo = ?, Prezzo = ?, ConPrenotazione = ?, Capienza = ? WHERE IdEvento = UUID_TO_BIN(?)";
    $stmt = $this->db->prepare($query);
    $stmt->execute([$titolo, $sottotitolo, $descrizione, $durata, $dataEvento, $luogo, $posizione, $tipo, $prezzo, $conPrenotazione, $capienza, $id]);

    if (!$stmt) {
        $response->getBody()->write(Err::EVENTO_UPDATE_ERROR());
        return $response->withStatus(500);
    }

    $query = "SELECT BIN_TO_UUID(IdEvento) AS IdEvento, Titolo, Sottotitolo, Descrizione, Durata, Data, Luogo, Posizione, Tipo, Prezzo, ConPrenotazione, Capienza FROM Eventi WHERE IdEvento = UUID_TO_BIN(?)";
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

    $query = "DELETE FROM Eventi WHERE IdEvento = UUID_TO_BIN(?)";
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
