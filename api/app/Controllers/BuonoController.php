<?php
namespace App\Controllers;

use Slim\Psr7\Request;
use Slim\Psr7\Response;
use App\Controllers\Controller;

class BuonoController extends Controller
{

    public function index(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per ottenere tutti i buoni
    }

    public function show(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per ottenere un singolo buono
    }

    public function create(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per creare un nuovo buono
    }

    public function update(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per aggiornare un buono esistente
    }

    public function delete(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per eliminare un buono
    }

}
?>