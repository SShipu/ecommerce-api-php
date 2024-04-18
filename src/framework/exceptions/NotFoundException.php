<?php

class NotFoundException extends Exception {

    public function __construct() {
        parent::__construct('not-found', 404, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
