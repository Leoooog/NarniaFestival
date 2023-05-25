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
	public static function NOT_VERIFIED($message = "L'utente non è verificato") {
        return json_encode(new Err(1017, $message));
    }
    public static function EVENTO_DELETE_ERROR($message = "Errore nell'eliminazione dell'evento") {
        return json_encode(new Err(1018, $message));
    }
    public static function EVENTO_UPDATE_ERROR($message = "Errore nell'aggiornamento dell'evento") {
        return json_encode(new Err(1019, $message));
    }
    public static function EVENTO_NOT_FOUND($message = "Buono pasto non trovato") {
        return json_encode(new Err(1020, $message));
    }
    public static function EVENTO_CREATION_ERROR($message = "Errore nella creazione dell'evento") {
        return json_encode(new Err(1021, $message));
    }

    public $Codice;
    public $Messaggio;

    public function __construct($code, $message) {
        $this->Codice = $code;
        $this->Messaggio = $message;
    }
}
