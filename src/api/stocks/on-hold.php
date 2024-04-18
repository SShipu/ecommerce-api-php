<?php
use Doctrine\DBAL\DBALException;
/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/StocksRepository.php';

cors();
// requiresRoleAnyOf(array('ADMIN'));
$data = getJsonBody();

$stocksRepository->markStockAsOnHold($data);
sendEmptyJsonResponse(202);