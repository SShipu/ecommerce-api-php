<?php

function validate($data) {
    $validationErrors = array();
    if (!isset($data->branchName) || strlen($data->branchName) < 5) {
        $validationErrors[] = (array('field' => 'branchName', 'errorCode' => 'length-mismatch'));
    }
    if (count($validationErrors) > 0) {
        throw new BadRequestException($validationErrors);
    }
}
