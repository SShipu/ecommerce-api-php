<?php
use Doctrine\DBAL\DBALException;
/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../repositories/StocksRepository.php';

// require_once(__DIR__. '/../../validation/BranchValidation.php');

cors();
// requiresRoleAnyOf(array('ADMIN'));
$data = getJsonBody();

if (isset($data->id)) {
    $id = $stocksRepository->save($data);
    $res = array('id' => $id, 'errors' => array());
    sendEmptyJsonResponse(202);
} else {
    throw new BadRequestException();
}