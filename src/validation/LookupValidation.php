<?php
function validate($data) {
    $validationErrors = array();
    if (!isset($data->name) || strlen($data->name) < 2) {
        $validationErrors[] = (array('field' => 'name', 'errorCode' => 'length-mismatch'));
    }
    if (count($validationErrors) > 0) {
        throw new BadRequestException($validationErrors);
    }
}
