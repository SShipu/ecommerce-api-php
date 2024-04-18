<?php

class FailedDependencyException extends Exception {

    public function __construct() {
        parent::__construct('failed-dependency', 424, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
