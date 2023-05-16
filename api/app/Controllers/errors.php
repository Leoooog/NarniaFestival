<?php
class Error {
    
    
    public function EMAIL_IN_USE($message = "Email in uso") {
        return new Error(1001, $message);
    }
    
    
    private $code;
    private $message;
    
    public function __construct($code, $message) {
        $this->code = $code;
        $this->message = message;
    }
    
    public function getCode() {
        return $this->code;
    }
    
    public function getMessage() {
        return $this->message;
    }
}

?>