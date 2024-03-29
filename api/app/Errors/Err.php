<?php

namespace App\Errors;

class Err {

    public static function USER_NOT_FOUND($message = "Utente non trovato") {
        return json_encode(new Err(1001, $message));
    }
    public static function MALFORMED_UUID($message = "UUID non valido") {
        return json_encode(new Err(1002, $message));
    }
    public static function EMAIL_IN_USE($message = "Email in uso") {
        return json_encode(new Err(1003, $message));
    }
    public static function USERNAME_IN_USE($message = "Username in uso") {
        return json_encode(new Err(1004, $message));
    }
    public static function USER_CREATION_ERROR($message = "Errore nella creazione dell'utente") {
        return json_encode(new Err(1005, $message));
    }
    public static function ERROR($message) {
        return json_encode(new Err(1000, $message));
    }
    public static function WRONG_VERIFY_CODE($message = "Codice verifica sbagliato o scaduto o l'utente è già verificato") {
        return json_encode(new Err(1006, $message));
    }
    public static function EXPIRED_VERIFY_CODE($message = "Codice verifica sbagliato") {
        return json_encode(new Err(1007, $message));
    }
    public static function USER_ALREADY_VERIFIED($message = "L'utente è già stato verificato") {
        return json_encode(new Err(1032, $message));
    }
    
    public static function TOKEN_NOT_VALID($message = "Token non valido") {
        return json_encode(new Err(1008, $message));
    }
    public static function NOT_AUTHORIZED($message = "Accesso non autorizzato") {
        return json_encode(new Err(1009, $message));
    }
    public static function LOGIN_FAILED($message = "Login fallito") {
        return json_encode(new Err(1010, $message));
    }
    public static function USER_DELETE_ERROR($message = "Errore nell'eliminazione dell'utente") {
        return json_encode(new Err(1011, $message));
    }
    public static function USER_UPDATE_ERROR($message = "Errore nell'aggiornamento dell'utente") {
        return json_encode(new Err(1012, $message));
    }
    public static function BUONO_DELETE_ERROR($message = "Errore nell'eliminazione del buono pasto") {
        return json_encode(new Err(1013, $message));
    }
    public static function BUONO_UPDATE_ERROR($message = "Errore nell'aggiornamento del buono pasto") {
        return json_encode(new Err(1014, $message));
    }
    public static function BUONO_NOT_FOUND($message = "Buono pasto non trovato") {
        return json_encode(new Err(1015, $message));
    }
    public static function BUONO_CREATION_ERROR($message = "Errore nella creazione del buono pasto") {
        return json_encode(new Err(1016, $message));
    }
    public static function NOT_VERIFIED($idUtente, $message = "L'utente non è verificato") {
        $utente = array();
        $utente['IdUtente'] = $idUtente;
        $m = (object) array_merge((array)new Err(1017, $message), (array)$utente);
        return json_encode($m);
    }
    public static function EVENTO_DELETE_ERROR($message = "Errore nell'eliminazione dell'evento") {
        return json_encode(new Err(1018, $message));
    }
    public static function EVENTO_UPDATE_ERROR($message = "Errore nell'aggiornamento dell'evento") {
        return json_encode(new Err(1019, $message));
    }
    public static function EVENTO_NOT_FOUND($message = "Evento non trovato") {
        return json_encode(new Err(1020, $message));
    }
    public static function EVENTO_CREATION_ERROR($message = "Errore nella creazione dell'evento") {
        return json_encode(new Err(1021, $message));
    }
    public static function PRENOTAZIONE_DELETE_ERROR($message = "Errore nell'eliminazione della prenotazione") {
        return json_encode(new Err(1022, $message));
    }
    public static function PRENOTAZIONE_UPDATE_ERROR($message = "Errore nell'aggiornamento della prenotazione") {
        return json_encode(new Err(1023, $message));
    }
    public static function PRENOTAZIONE_NOT_FOUND($message = "Prenotazione non trovata") {
        return json_encode(new Err(1024, $message));
    }
    public static function PRENOTAZIONE_CREATION_ERROR($message = "Errore nella creazione della prenotazione") {
        return json_encode(new Err(1025, $message));
    }
    public static function RISTORANTE_DELETE_ERROR($message = "Errore nell'eliminazione del ristorante") {
        return json_encode(new Err(1026, $message));
    }
    public static function RISTORANTE_UPDATE_ERROR($message = "Errore nell'aggiornamento del ristorante") {
        return json_encode(new Err(1027, $message));
    }
    public static function RISTORANTE_NOT_FOUND($message = "Ristorante non trovato") {
        return json_encode(new Err(1028, $message));
    }
    public static function RISTORANTE_CREATION_ERROR($message = "Errore nella creazione del ristorante") {
        return json_encode(new Err(1029, $message));
    }
    public static function EVENTO_NON_PRENOTABILE($message = "L'evento non è prenotabile") {
        return json_encode(new Err(1030, $message));
    }
    public static function POSTI_ESAURITI($message = "Posti esauriti per l'evento specificato") {
        return json_encode(new Err(1031, $message));
    }


    public $Codice;
    public $Messaggio;

    public function __construct($code, $message) {
        $this->Codice = $code;
        $this->Messaggio = $message;
    }
}
