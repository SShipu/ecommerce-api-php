<?php
function validate($data) {
    $validationErrors = array();
    if (!isset($data->userName) || strlen($data->userName) < 5) {
        $validationErrors[] = (array('field' => 'userName', 'errorCode' => 'length-mismatch'));
    }
    if (count($validationErrors) > 0) {
        throw new PreconditionFailedException($validationErrors);
        die();
    }
}