<?php
namespace App\Controllers;

use Slim\Psr7\Request;
use Slim\Psr7\Response;
use App\Controllers\Controller;

class StrutturaController extends Controller
{

    public function index(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per ottenere tutte le strutture
    }

    public function show(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per ottenere una singola struttura
    }

    public function create(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per creare una nuova struttura
    }

    public function update(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per aggiornare una struttura esistente
    }

    public function delete(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per eliminare una struttura
    }
}
?>