<?php 

namespace App\Controllers;
class Controller {
    public function encode_result($result) {
        $rows = array();

        // Ottiene ogni riga come un array associativo
        while ($row = $result->fetch_assoc()) {
            // Converte ogni campo in UTF-8 utilizzando iconv()
            foreach ($row as $key => $value) {
                $row[$key] = iconv('latin1', 'utf-8', $value);
            }
            $rows[] = $row;
        }
        if(count($rows) == 0) return FALSE;
        // Converte l'array in formato JSON
        $json = json_encode($rows);
        return $json;
    }
}