<?php

class ExpectationFailedException extends Exception {

    private $errorBody = null;

    public function __construct($errorBody = null) {
        parent::__construct('expectation-failed3', 417, null);
        $this->errorBody = $errorBody;
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

    public function getErrorBody() {
        return $this->errorBody;
    }

}
