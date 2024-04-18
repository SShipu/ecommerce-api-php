<?php

/* configuration */
require_once __DIR__ . '/../../../../configs/config.php';
require_once __DIR__ . '/../../../../framework/framework.php';
require_once __DIR__ . '/../../../../framework/auth.php';
require_once __DIR__ . '/../../../../repositories/MfgOrdersV2Repository.php';
// require_once __DIR__ . '/../../../../repositories/MfgOrderSetsRepository.php';


cors();

requiresRoleAnyOf(array('ADMIN'));
$data = getJsonBody();

$id = $mfgOrdersV2Repository->save($data, $currentUser->getId());
$res = array('id' => $id, 'errors' => array());
sendJsonResponse(202, $res);