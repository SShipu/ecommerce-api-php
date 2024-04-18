<?php
use Exception;
/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/ItemAttributesRepository.php';
require_once __DIR__ . '/../../validation/ItemAttributeValidation.php';

cors();

requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();
validate($data);

$id = $itemAttributesRepository->save($data);
$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);