<?php

class GoneException extends Exception {

    public function __construct() {
        parent::__construct('gone', 410, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
