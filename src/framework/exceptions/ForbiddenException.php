<?php

class ForbiddenException extends Exception {

    public function __construct() {
        parent::__construct('forbidden', 403, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
