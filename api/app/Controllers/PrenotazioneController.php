<?php
namespace App\Controllers;

use Slim\Psr7\Request;
use Slim\Psr7\Response;
use App\Controllers\Controller;
class PrenotazioneController extends Controller
{
    protected $db;


    public function __construct($db)
    {
        $this->db = $db;
    }

    public function index(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per ottenere tutte le prenotazioni
    }

    public function show(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per ottenere una singola prenotazione
    }

    public function create(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per creare una nuova prenotazione
    }

    public function update(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per aggiornare una prenotazione esistente
    }

    public function delete(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per eliminare una prenotazione
    }

}
?>