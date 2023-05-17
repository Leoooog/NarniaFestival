<?php

namespace App\Errors;

class Err
{

    public static function USER_NOT_FOUND($message = "Utente non trovato")
    {
        return json_encode(new Err(1001, $message));
    }

    public static function MALFORMED_UUID($message = "UUID non valido")
    {
        return json_encode(new Err(1002, $message));
    }

    public static function EMAIL_IN_USE($message = "Email in uso")
    {
        return json_encode(new Err(1003, $message));
    }

    public static function USERNAME_IN_USE($message = "Username in uso")
    {
        return json_encode(new Err(1004, $message));
    }

    public static function USER_CREATION_ERROR($message = "Errore nella creazione dell'utente")
    {
        return json_encode(new Err(1005, $message));
    }
    public static function ERROR($message)
    {
        return json_encode(new Err(1000, $message));
    }
    public static function WRONG_VERIFY_CODE($message = "Codice verifica sbagliato o scaduto")
    {
        return json_encode(new Err(1006, $message));
    }

    public static function EXPIRED_VERIFY_CODE($message = "Codice verifica sbagliato")
    {
        return json_encode(new Err(1007, $message));
    }
    public static function TOKEN_NOT_VALID($message = "Token non valido")
    {
        return json_encode(new Err(1008, $message));
    }
    public static function NOT_AUTHORIZED($message = "Accesso non autorizzato")
    {
        return json_encode(new Err(1009, $message));
    }
    public static function LOGIN_FAILED($message = "Login fallito")
    {
        return json_encode(new Err(1010, $message));
    }
    public static function USER_DELETE_ERROR($message = "Errore nell'eliminazione dell'utente")
    {
        return json_encode(new Err(1011, $message));
    }
    public static function USER_UPDATE_ERROR($message = "Errore nell'aggiornamento dell'utente")
    {
        return json_encode(new Err(1012, $message));
    }

    public $code;
    public $message;

    public function __construct($code, $message)
    {
        $this->code = $code;
        $this->message = $message;
    }
}

?>