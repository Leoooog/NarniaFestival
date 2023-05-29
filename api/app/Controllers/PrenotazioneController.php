<?php

namespace App\Controllers;

use App\Errors\Err;
use Slim\Psr7\Request;
use Slim\Psr7\Response;
use App\Controllers\Controller;

class PrenotazioneController extends Controller {

    public function index(Request $request, Response $response, array $args) {
        $query = "SELECT BIN_TO_UUID(IdPrenotazione) AS IdPrenotazione, DataPrenotazione, BIN_TO_UUID(Utente) AS Utente, BIN_TO_UUID(Evento) AS Evento, Posti, Validata FROM Prenotazioni";
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
        $query = "SELECT BIN_TO_UUID(IdPrenotazione) AS IdPrenotazione, DataPrenotazione, BIN_TO_UUID(Utente) AS Utente, BIN_TO_UUID(Evento) AS Evento, Posti, Validata FROM Prenotazioni WHERE IdPrenotazione = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

        $result = $stmt->get_result();
        if ($result->num_rows == 0) {
            $response->getBody()->write(Err::PRENOTAZIONE_NOT_FOUND());
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
        $utente = $data['Utente'];
        $evento = $data['Evento'];
        $posti = $data['Posti'];

        if ($posti > 6) {
            $response->getBody()->write(Err::ERROR("Troppi posti richiesti. Massimo: 6"));
            return $response
                ->withHeader('Content-Type', 'application/json')
                ->withStatus(403);
        }
        
        $eventoQuery = "SELECT Capienza, PostiOccupati FROM Eventi WHERE IdEvento = UUID_TO_BIN(?)";
        $eventoStmt = $this->db->prepare($eventoQuery);
        $eventoStmt->execute([$evento]);
        $eventoResult = $eventoStmt->get_result();

        if ($eventoResult->num_rows == 0) {
            $response->getBody()->write(Err::EVENTO_NOT_FOUND());
            return $response
                ->withHeader('Content-Type', 'application/json')
                ->withStatus(404);
        }

        $eventoRow = $eventoResult->fetch_assoc();
        $capienza = $eventoRow['Capienza'];
        $postiOccupati = $eventoRow['PostiOccupati'];
        if ($capienza == NULL) {
            $response->getBody()->write(Err::EVENTO_NON_PRENOTABILE());
            return $response
                ->withHeader('Content-Type', 'application/json')
                ->withStatus(403);
        }
        echo $capienza;
        echo $postiOccupati;

        if ($postiOccupati + $posti > $capienza) {
            $response->getBody()->write(Err::POSTI_ESAURITI());
            return $response
                ->withHeader('Content-Type', 'application/json')
                ->withStatus(403);
        }

        $postiOccupati += $posti;
        $updateQuery = "UPDATE Eventi SET PostiOccupati = ? WHERE IdEvento = UUID_TO_BIN(?)";
        $updateStmt = $this->db->prepare($updateQuery);
        $updateStmt->execute([$postiOccupati, $evento]);


        $insertQuery = "INSERT INTO Prenotazioni (Utente, Evento, Posti)
                        VALUES (UUID_TO_BIN(?), UUID_TO_BIN(?), ?)";
        $insertStmt = $this->db->prepare($insertQuery);
        $insertStmt->execute([$utente, $evento, $posti]);

        if (!$insertStmt) {
            $response->getBody()->write(Err::PRENOTAZIONE_CREATION_ERROR());
            return $response->withStatus(500);
        }

        $prenotazioneQuery = "SELECT BIN_TO_UUID(IdPrenotazione) AS IdPrenotazione, DataPrenotazione, BIN_TO_UUID(Utente) AS Utente, BIN_TO_UUID(Evento) AS Evento, Posti, Validata
                              FROM Prenotazioni
                              WHERE IdPrenotazione = @last_prenotazione_uuid";
        $prenotazioneStmt = $this->db->prepare($prenotazioneQuery);
        $prenotazioneStmt->execute();
        $prenotazioneResult = $prenotazioneStmt->get_result();
        $json = $this->encode_result($prenotazioneResult);

        $response->getBody()->write($json);

        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(201);
    }


    public function showByUser(Request $request, Response $response, array $args) {
        $id = $args['id'];
        $token = $request->getAttribute("token");
        $userId = $token->sub;
        $role = $token->role;

        if ($userId !== $id && $role !== "admin") {
            $response->getBody()->write(Err::NOT_AUTHORIZED());
            return $response
                ->withHeader('Content-Type', 'application/json')
                ->withStatus(401);
        }

        $query = "SELECT BIN_TO_UUID(IdPrenotazione) AS IdPrenotazione, DataPrenotazione, BIN_TO_UUID(Utente) AS Utente, BIN_TO_UUID(Evento) AS Evento, Posti, Validata FROM Prenotazioni WHERE Utente = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$id]);

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

    public function update(Request $request, Response $response, array $args) {
        $id = $args['id'];
        $data = $request->getParsedBody();
        $utente = $data['Utente'];
        $evento = $data['Evento'];
        $posti = $data['Posti'];

        $query = "UPDATE Prenotazioni SET Utente = UUID_TO_BIN(?), Evento = UUID_TO_BIN(?), Posti = ? WHERE IdPrenotazione = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$utente, $evento, $posti, $id]);

        if (!$stmt) {
            $response->getBody()->write(Err::PRENOTAZIONE_UPDATE_ERROR());
            return $response->withStatus(500);
        }

        $query = "SELECT BIN_TO_UUID(IdPrenotazione) AS IdPrenotazione, DataPrenotazione, BIN_TO_UUID(Utente) AS Utente, BIN_TO_UUID(Evento) AS Evento, Posti, Validata FROM Prenotazioni WHERE IdPrenotazione = UUID_TO_BIN(?)";
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

        $query = "DELETE FROM Prenotazioni WHERE IdPrenotazione = UUID_TO_BIN(?)";
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

    public function validate(Request $request, Response $response, array $args) {
        $prenotazione = $args['id'];

        $query = "UPDATE Prenotazioni SET Validata = 1 WHERE IdPrenotazione = UUID_TO_BIN(?)";
        $stmt = $this->db->prepare($query);
        $stmt->execute([$prenotazione]);

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
