<?php

class NotAllowedException extends Exception {

    public function __construct() {
        parent::__construct('not-allowed', 405, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
