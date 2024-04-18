<?php

class UnauthorizedException extends Exception {

    public function __construct() {
        parent::__construct('unauthorized', 401, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
