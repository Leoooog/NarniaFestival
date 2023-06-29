<?php
$filePath = '/home/leonardo/Desktop/NarniaFestival/db/menu.png';

// Leggi il contenuto del file come dati binari
$data = file_get_contents($filePath);

print($data);
// Connetti al database
$conn = new mysqli('localhost', 'Leo', 'geusaserver2020', 'narnia_db');

// Verifica la connessione al database
if ($conn->connect_error) {
    die("Connessione al database fallita: " . $conn->connect_error);
}

// Prepara la query di inserimento
$query = 'INSERT INTO Ristoranti(Nome, Descrizione, Indirizzo, Posizione, Menu, Proprietario) VALUES (?, ?, ?, POINT(?, ?), ?, UUID_TO_BIN(?))';
$stmt = $conn->prepare($query);

// Verifica se la preparazione della query ha avuto successo
if (!$stmt) {
    die("Preparazione della query fallita: " . $conn->error);
}

// Associa i valori come parametri
$param1 = 'Ristorante di Chiara';
$param2 = 'Un ristorante accogliente che offre cucina tradizionale italiana';
$param3 = 'Via Roma 1';
$param4 = 45.12345;
$param5 = 9.5678;
$param6 = $data;
$param7 = 'ae3970c7-15f4-11ee-93ac-e55d23999317';

$stmt->execute([$param1, $param2, $param3, $param4, $param5, $param6, $param7]);


// Chiudi lo statement e la connessione
$stmt->close();
$conn->close();
?>


