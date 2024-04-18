<?php

class ConflictException extends Exception {

    public function __construct() {
        parent::__construct('conflict', 409, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
