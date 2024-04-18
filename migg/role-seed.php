<?php


/* configuration */
require_once(__DIR__. '/../src/configs/config.php');
require_once(__DIR__. '/../src/framework/framework.php');
require_once(__DIR__ . '/../src/repositories/RolesRepository.php');

// $options = [
//     'cost' => 12,
// ];
// $passwordHash = password_hash("@dm!n-p@$$", PASSWORD_BCRYPT, $options);

// $user->setEmail('admin@headmistry.com');
$roles = array("ADMIN", "SHOWROOM_MANAGER", "DISTRIBUTION_MANAGER", "SHOWROOM_SALES", "USER");
foreach ($roles as $value) {
    $role = new Role();
    $role->setRole($value);
    try {
        $id = $rolesRepository->save($role);
        $res = array( 'id' => $id, 'errors' => array());
        sendJsonResponse(201, $res);

    } catch(Exception $ex) {

        $errorCode = $ex->getPrevious()->getCode();
        if ($errorCode == 23000)
            sendEmptyJsonResponse(409);
        else
            sendEmptyJsonResponse(500);

    }
}
// $user->setPassword($passwordHash);
// $user->setUserName('admin');
// $user->setUserRole('ADMIN');



?>
