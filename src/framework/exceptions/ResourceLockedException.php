<?php

class ResourceLockedException extends Exception {

    public function __construct() {
        parent::__construct('resource-locked', 423, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
