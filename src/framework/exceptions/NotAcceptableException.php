<?php

class NotAcceptableException extends Exception {

    public function __construct() {
        parent::__construct('not-acceptable', 406, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
