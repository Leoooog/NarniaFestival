<?php

namespace App\Controllers;

use Firebase\JWT\Key;
use mysqli;

class Controller {
    protected $key;
    protected $db;
    protected $ruoli;
    public function __construct(mysqli $db) {
        $this->db = $db;
        $this->key = new Key($_ENV['SECRET_KEY'], 'HS256');
        $this->ruoli = [
            1 => 'admin',
            2 => 'iscritto',
            3 => 'ospite',
            4 => 'ristorante'
        ];
    }


    public function encode_result($result) {
        $rows = array();

        while ($row = $result->fetch_assoc()) {

            foreach ($row as $key => $value) {
                $row[$key] = iconv('latin1', 'utf-8', $value);
            }
            $rows[] = $row;
        }
        if (count($rows) == 0) {
            return FALSE;
        }
        // Converte l'array in formato JSON
        $json = json_encode($rows);
        return $json;
    }
}
