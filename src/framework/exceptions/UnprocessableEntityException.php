<?php

class UnprocessableEntityException extends Exception {

    public function __construct() {
        parent::__construct('unprocessable-entity', 409, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
