<?php

/* configuration */
require_once __DIR__ . '/../../configs/config.php';
require_once __DIR__ . '/../../framework/framework.php';
require_once __DIR__ . '/../../framework/auth.php';
require_once __DIR__ . '/../../repositories/BranchesRepository.php';

cors();

requiresAuth();

$list = $branchesRepository->findEcommerceBranch();

sendJsonResponse(200, array('list' => $list));