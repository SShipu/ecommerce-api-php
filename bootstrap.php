<?php

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Tools\Setup;

// include the composer autoloader for autoloading packages

require_once __DIR__ . '/vendor/autoload.php';

// set up an autoloader for loading classes that aren't in /vendor
// $classDirs is an array of all folders to load from
$classDirs = array(
    __DIR__,
    __DIR__ . '/src/models',
);

new \iRAP\Autoloader\Autoloader($classDirs);

function getEntityManager(): \Doctrine\ORM\EntityManager
{
    $entityManager = null;

    if ($entityManager === null) {
        $paths = array(__DIR__ . '/src/models');
        $config = \Doctrine\ORM\Tools\Setup::createAnnotationMetadataConfiguration($paths);
        /* performance issues */
        $config->setAutoGenerateProxyClasses(true);

        # set up configuration parameters for doctrine.
        # Make sure you have installed the php7.0-sqlite package.
        $connectionParams = array(
            'driver' => 'pdo_mysql', //sql type
            'host' => 'localhost',
            'port' => 3306, // sql port
            'dbname' => 'hmt_db', //databsae name
            'user' => 'root', //user name
            'password' => '1503', // user password
            'options' => array(1002 => 'SET sql_mode=(SELECT REPLACE(@@sql_mode, "ONLY_FULL_GROUP_BY", ""))')
        );

        $entityManager = \Doctrine\ORM\EntityManager::create($connectionParams, $config);
    }

    return $entityManager;
}

$em = getEntityManager();
