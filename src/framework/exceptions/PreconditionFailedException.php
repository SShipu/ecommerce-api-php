<?php

class PreconditionFailedException extends Exception {

    private $errorBody = null;

    public function __construct($errorBody = null) {
        parent::__construct('precondition-failed', 412, null);
        $this->errorBody = $errorBody;
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

    public function getErrorBody() {
        return $this->errorBody;
    }

}