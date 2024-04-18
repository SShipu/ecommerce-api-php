<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ProductsRepository.php';
require_once __DIR__ . '/../../repositories/SKUsRepository.php';
require_once __DIR__ . '/../../repositories/SearchIndicesRepository.php';
require_once __DIR__ . '/../../validation/ProductValidation.php';
require_once __DIR__ . '/../../helpers/StringHelper.php';
cors();

requiresRoleAnyOf(array('ADMIN'));

$data = getJsonBody();
validate($data);

$id = $productsRepository->save($data);
$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);