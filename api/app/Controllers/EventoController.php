<?php

namespace App\Controllers;

use Slim\Psr7\Request;
use Slim\Psr7\Response;
use App\Controllers\Controller;

class EventoController extends Controller
{
    protected $db;

    public function __construct($db)
    {
        $this->db = $db;
    }

    public function index(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per ottenere tutti gli eventi
    }

    public function show(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per ottenere un singolo evento
    }

    public function create(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per creare un nuovo evento
    }

    public function update(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per aggiornare un evento esistente
    }

    public function delete(Request $request, Response $response, $args)
    {
        // Implementazione dell'endpoint per eliminare un evento
    }
} ?>