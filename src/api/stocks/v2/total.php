<?php
use Doctrine\DBAL\DBALException;
/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../repositories/StocksV2Repository.php';
cors();

requiresRoleAnyOf(array('ADMIN'));
$data = getJsonBody();

$stocksV2Repository->adjustTotal($data);
sendEmptyJsonResponse(202);