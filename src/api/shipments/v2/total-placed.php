<?php
use Doctrine\DBAL\DBALException;

/* configuration */
require_once __DIR__ . '/../../../configs/config.php';
require_once __DIR__ . '/../../../framework/auth.php';
require_once __DIR__ . '/../../../framework/framework.php';
require_once __DIR__ . '/../../../repositories/ShipmentsV2Repository.php';

cors();
requiresAuth();

$sourceId = -1;
$destinationId = -1;

if (hasRole('ADMIN')) {
    if (isset($_GET['sourceId']))
        $sourceId = ($_GET['sourceId']);
    
    if (isset($_GET['destinationId']))
        $destinationId = ($_GET['destinationId']);
        
} else if (hasRole('DISTRIBUTION_MANAGER')) {
    $sourceId = $currentUser->getBranches()[0]->getId();
} else {
    $destinationId = $currentUser->getBranches()[0]->getId();
}

$result = $shipmentsV2Repository->totalPlaced($sourceId, $destinationId);

sendJsonResponse(200, $result);