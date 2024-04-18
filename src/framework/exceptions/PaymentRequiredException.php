<?php

class PaymentRequiredException extends Exception {

    public function __construct() {
        parent::__construct('payment-required', 402, null);
    }

    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }

}
