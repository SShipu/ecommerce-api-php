<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/ProductBundlesRepository.php';
// require_once __DIR__ . '/../../../repositories/SKUsRepository.php';
// require_once __DIR__ . '/../../../repositories/SearchIndicesRepository.php';
require_once __DIR__ . '/../../../validation/ProductBundleValidation.php';
// require_once __DIR__ . '/../../../helpers/StringHelper.php';
cors();

requiresRoleAnyOf(array('ADMIN', 'SHOWROOM-MANAGER'));

$data = getJsonBody();
validate($data);

$id = $productBundlesRepository->save($data);
$res = array('id' => $id, 'errors' => array());
sendJsonResponse(201, $res);