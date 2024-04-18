<?php

function validate($data) {
    $validationErrors = array();
    if (!isset($data->title) || strlen($data->title) < 4) {
        $validationErrors[] = (array('field' => 'title', 'errorCode' => 'length-mismatch'));
    }
    if (count($validationErrors) > 0) {
        throw new BadRequestException($validationErrors);
    }
}