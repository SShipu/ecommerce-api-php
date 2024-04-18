<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/ShipmentsRepository.php';
cors();
requiresRoleAnyOf(array('ADMIN', 'SHOWROOM_MANAGER', 'SHOWROOM_SALES'));

if (isset($_GET['id'])) {
    $shipment = $shipmentsRepository->findByShipmentId($_GET['id']);
    if ($shipment == null)
        throw new NotFoundException();


    if (hasRole('ADMIN')) {
          sendJsonResponse(200, $shipment);
      } else if (hasRole('SHOWROOM_MANAGER', 'SHOWROOM_SALES')) {
          $branchId = $currentUser->getBranches()[0]->getId();
          if ($branchId == $shipment->getDestinationBranch()->getId()) {
              sendJsonResponse(200, $shipment);
          } else {
              throw new ResourceLockedException();
          }
      }
}
else {
    throw new BadRequestException();
}
