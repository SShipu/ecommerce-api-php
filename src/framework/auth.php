<?php
require_once __DIR__ . '/../repositories/UsersRepository.php';
require_once __DIR__ . '/../repositories/UserTokensRepository.php';

if (isset($_SERVER['HTTP_X_AUTH_TOKEN'])) {
    $currentUser = $userTokensRepository->getAuthentication($_SERVER['HTTP_X_AUTH_TOKEN'], $usersRepository);
}
