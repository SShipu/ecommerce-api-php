<?php
function validate($data) {
    $validationErrors = array();
    if (!isset($data->value) || strlen($data->value) < 1) {
        $validationErrors[] = (array('field' => 'value', 'errorCode' => 'length-mismatch'));
    }
    if (count($validationErrors) > 0) {
        throw new BadRequestException($validationErrors);
    }
}
