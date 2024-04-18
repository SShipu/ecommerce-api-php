# Folder Structure

```
    +project-dir
      1. #--+./migg
    	 ##----+../database.sql --> database table query
    	 ##----+../user-seed.php --> default user(admin) generator

      2. #--+./src --> folder for our doctrine entities

    	 ##----+../api

    	 ###------+../auth
    	 ####--------+../login.php --> checking valid user name password, then token generating, & sends respons.

    	 ###------+../project-items
    	 ####--------+../create.php -->create
    	 ####--------+../update.php -->
    	 ####--------+../list/read.php -->
    	 ####--------+../delete.php -->

    	 ##----+../configs
    	 ###------+../configs.php --> call the bootstrap.php file here, then integrating to other files (for path simplification purpose)

    	 ##----+../framework
    	 ###------+../auth.php -->
    	 ###------+../framework.php -->

    	 ##----+../models
    	 ###------+../item.php --> database table create operation model

    	 ##----+../repositories
    	 ###------+../itemsRepository.php -->

    	 ##----+../validations
    	 ###------+../itemValidation.php --> after submitted by data, the data has sent to a server and perform validation checks in server machine

      3. #--+./vendor --> doctrine library
      4. #--+./bootstrap.php --> to tell Doctrine what kind of a database we are using, and what the relevant connection details are
      5. 3--+./cli-config.php --> Initialize The Database (to invoke files in command-line/ invoke commedn). allow us to use the Doctrine CLI tools
```

# Dependency

    1. Doctrine
    2. php image upload imagemagick install (https://www.linuxcapable.com/how-to-install-php-imagemagick-imagick-on-ubuntu-20-04/)

# How it works

---

# Setup and Install Doctrine

[Doctrine Documentation site](https://blog.programster.org/getting-started-with-doctrine-orm)

[Doctrine Documentation official site](https://www.doctrine-project.org/projects/doctrine-orm/en/2.8/tutorials/getting-started.html#getting-started-with-doctrine)

## 1. Create a structure for our project

_command-line_

`$ mkdir -p my-project/src`

`$ mkdir -p my-project/migg`

`$ touch my-project/bootstrap.php`

`$ touch my-project/config/cli-config.php`

etc...

## 2. Install Doctrine

_command-line_

`$ cd my-project`

`$ composer require doctrine/orm`

`$ composer install`

## 3. Using an autoloader package for automatically loading classes by name

_command-line_

`$ composer require irap/autoloader`

## 4. Configure Doctrine for a Database Connection.

### #bootstrap.php

```php
<?php

	use Doctrine\ORM\Tools\Setup;
	use Doctrine\ORM\EntityManager;

	// include the composer autoloader for autoloading packages

	require_once(__DIR__ . '/vendor/autoload.php');

	// set up an autoloader for loading classes that aren't in /vendor
	// $classDirs is an array of all folders to load from
	$classDirs = array(
		__DIR__,
		__DIR__ . '/src/models',
	);

	new \iRAP\Autoloader\Autoloader($classDirs);

	function getEntityManager() : \Doctrine\ORM\EntityManager
	{
		$entityManager = null;

		if ($entityManager === null)
		{
			$paths = array(__DIR__ . '/src/models');
			$config = \Doctrine\ORM\Tools\Setup::createAnnotationMetadataConfiguration($paths);
			/* performance issues */
			$config->setAutoGenerateProxyClasses(true);

			# set up configuration parameters for doctrine.
			# Make sure you have installed the php7.0-sqlite package.
			$connectionParams = array(
				'driver'   => 'pdo_mysql', //sql type
				'host'     => 'localhost',
				'port'     =>  3306, // sql port
				'dbname'   => 'headmistry_db', //databsae name
				'user'     => 'root', //user name
				'password' => '1503' // user password
			);

			$entityManager = \Doctrine\ORM\EntityManager::create($connectionParams, $config);
		}

		return $entityManager;
	}

	$em = getEntityManager();
?>
```

### #Create Database;

```sql
create database datbase_name;
```

_Now change 'dbname' to database name_

` 'dbname' => 'databaseName_db', //databsae name`

### #Create Our First Model/Entity (user)

Create a file in "src/models" path folder, name user.php

_like:_

```php
<?php
	// src/User.php

	// use Doctrine\Common\Collections\ArrayCollection;

	/**
	* @Entity (repositoryClass="UsersRepository")
	* @Table(name="users", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "user_name" }) } )
	**/ // this is call Annotation (AnnotationMetadataConfiguration()

	class User implements JsonSerializable{

		/** @Id @Column(type="integer") @GeneratedValue **/
		protected $id;

		/** @Column(type="string", name="user_name") **/
		protected $userName;

		/** @Column(type="string", name="full_name") **/
		protected $fullName;

		/** @Column(type="string") **/
		protected $email;

		/** @Column(type="string") **/
		protected $password;

		/** @Column(type="string", name="user_role") **/
		protected $userRole;

		public function getId()
		{
			return $this->id;
		}
		public function setId($id)
		{
			$this->id = $id;
		}

		public function getUserName()
		{
			return $this->userName;
		}
		public function setUserName($userName)
		{
			$this->userName = $userName;
		}

		public function getFullName()
		{
			return $this->fullName;
		}
		public function setFullName($fullName)
		{
			$this->fullName = $fullName;
		}

		public function getEmail()
		{
			return $this->email;
		}
		public function setEmail($email)
		{
			$this->email = $email;
		}

		public function getPassword()
		{
			return $this->password;
		}
		public function setPassword($password)
		{
			$this->password = $password;
		}

		public function getUserRole()
		{
			return $this->userRole;
		}
		public function setUserRole($userRole)
		{
			$this->userRole = $userRole;
		}

		public function jsonSerialize() {
			return array(
				'id' => $this->id,
				'userName' => $this->userName,
				'fullName' => $this->fullName,
				'email' => $this->email,
				'password' => $this->password,
				'userRole' => $this->userRole
			);
		}
	}
?>
```

# Setup Config file

## 5. Initialize The Database

### #Setup CLI Config

```php
<?php
	require_once(__DIR__ . '/bootstrap.php');

	// $entityManager = getEntityManager();
	return \Doctrine\ORM\Tools\Console\ConsoleRunner::createHelperSet($em);
?>
```

### #setup src/configs/config.php

```php
<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// echo __DIR__;
require_once(__DIR__ . '/../../bootstrap.php');
?>
```

### #Use the CLI!

_command-line_

`$ vendor/bin/doctrine orm:schema-tool:create`

```
~note: should get the following output:

ATTENTION: This operation should not be executed in a production environment.

Creating database schema...
Database schema created successfully!
```

As you modify your entities' metadata during the development process, you'll need to update your database schema to stay in sync with the metadata.

You can easily recreate the database using the following commands:

`$ vendor/bin/doctrine orm:schema-tool:drop --force`

`$ vendor/bin/doctrine orm:schema-tool:create`

Or you can use the update functionality:

`$ vendor/bin/doctrine orm:schema-tool:update --force`

# API common flow

+project/src

#--+./api

    	 ##----+auth
    	 ###------+login.php

    	 ##----+project-items
    	 ###------+create.php --> create items & save it to database
    		EX:

```php
<?php

	/* configuration */
	require_once(__DIR__. '../../../configs/config.php');
	require_once(__DIR__. '../../../framework/framework.php');
	require_once(__DIR__. '../../../framework/auth.php');
	require_once(__DIR__ . '../../../repositories/CategoriesRepository.php');
	require_once(__DIR__ . '../../../validations/CategoryValidation.php');


	requiresRoleAnyOf(array('SALES', 'MANAGER', 'ADMIN'));

	$data = getJsonBody();
	validate($data);

	$cat = new Category();
	$cat->setName($data->name);
	$cat->setMeaning($data->meaning);
	$cat->setConcept($data->concept);

	if (isset($data->parentId))
		$cat->setParentId($data->parentId);
	else
		$cat->setParentId(-1);

	$cat->setCount(0);


	try {
		$id = $categoriesRepository->save($cat);
		$res = array( 'id' => $id, 'errors' => array());
		sendJsonResponse(201, $res);

	} catch(Exception $ex) {

		$errorCode = $ex->getPrevious()->getCode();
		if ($errorCode == 23000)
			sendEmptyJsonResponse(409);
		else
			sendEmptyJsonResponse(500);

	}
?>
```

    	 ###------+update.php --> update items & save it to database
    		EX:

```php
<?php

	/* configuration */
	require_once(__DIR__. '../../../configs/config.php');
	require_once(__DIR__. '../../../framework/framework.php');
	require_once(__DIR__ . '../../../repositories/CategoriesRepository.php');
	require_once(__DIR__ . '../../../validations/CategoryValidation.php');


	$data = getJsonBody();
	validate($data);


	if (isset($data->id)) {
		$cat = $categoriesRepository->findOneBy(array('id' => $data->id));
		if ($cat != null) {
			$cat->setName($data->name);
			$cat->setMeaning($data->meaning);
			$cat->setConcept($data->concept);

			if (isset($data->parentId))
				$cat->setParentId($data->parentId);
			else
				$cat->setParentId(-1);

			try {
				$em->flush();
				// $categoriesRepository->save($cat);
				sendEmptyJsonResponse(202);

			} catch(Exception $ex) {

				$errorCode = $ex->getPrevious()->getCode();
				if ($errorCode == 23000)
					sendEmptyJsonResponse(409);
				else
					sendEmptyJsonResponse(500);

			}
		} else {
			sendEmptyJsonResponse(404);
		}
	} else {
		sendEmptyJsonResponse(412);
	}
?>
```

    	 ###------+list.php --> Read items & show it from database
    		EX:

```php
<?php

	/* configuration */
	require_once(__DIR__. '../../../configs/config.php');
	require_once(__DIR__. '../../../framework/framework.php');
	require_once(__DIR__ . '../../../repositories/CategoriesRepository.php');



	$parentId = -1;

	if (isset($_GET['parentId']))
		$parentId = $_GET['parentId'];


	$list = $categoriesRepository->findAllByParentId($parentId);

	sendJsonResponse(200, array('list' => $list, 'nextPageToken' => ''));
?>
```

    	 ###------+delete.php --> Delete items from database
    		EX:

```php
<?php

	/* configuration */
	require_once(__DIR__. '../../../configs/config.php');
	require_once(__DIR__. '../../../framework/framework.php');
	require_once(__DIR__ . '../../../repositories/CategoriesRepository.php');


	if (isset($_REQUEST['id'])) {
		$count = $categoriesRepository->delete($_REQUEST['id']);
		if ($count > 0)
			sendEmptyJsonResponse(202);
		else
			sendEmptyJsonResponse(404);
	} else {
		sendEmptyJsonResponse(412);
	}
?>
```

# Frameworks purpose

+projects/src

#--+./framework

##----+auth.php --> checking valid auth token

EX:

```php
<?php
require_once(**DIR** . '/../repositories/UsersRepository.php');
require_once(**DIR** . '/../repositories/UserTokensRepository.php');

	if (isset($_SERVER['HTTP_X_AUTH_TOKEN'])) {
		$currentUser = $userTokensRepository->getAuthentication($_SERVER['HTTP_X_AUTH_TOKEN'], $usersRepository);
	}
?>
```

    	 ##----+framework.php --. taking json input ($data), sendings typesof JSON respons, other reuseable funcitons...
    	 	EX:

```php
<?php

		function getJsonBody() {
			$json = file_get_contents('php://input', true);
			$data = json_decode($json);
			return $data;
		}

		function sendEmptyJsonResponse($code) {
			http_response_code($code);
			header('Content-Type: application/json');
			echo json_encode(array());
		}

		function sendJsonResponse($code, $body) {
			http_response_code($code);
			header('Content-Type: application/json');
			echo json_encode($body);
		}

		function isAuthenticated() {
			global $currentUser;
			return $currentUser != null;
		}

		function requiresAuth() {
			if (!isAuthenticated()) {
				sendEmptyJsonResponse(401);
				die();
			}
		}

		function requiresRole($role) {
			if (!isAuthenticated()) {
				sendEmptyJsonResponse(401);
				die();
			}
			global $currentUser;
			if ($currentUser->getUserRole() != $role) {
				sendEmptyJsonResponse(403);
				die();
			}

		}

		function requiresRoleAnyOf($roles) {
			if (!isAuthenticated()) {
				sendEmptyJsonResponse(401);
				die();
			}
			global $currentUser;

			$roleFound = false;

			foreach ($roles as $role) {
				if ($currentUser->getUserRole() == $role) {
					$roleFound = true;
					break;
				}
			}
			if (!$roleFound) {
				sendEmptyJsonResponse(403);
				die();
			}

		}
?>
```

# Model

+projects/src

#--+./model

##----+./item.php --> creating entitry for database, which creates table column model in database automatically, so taht we do not need create it manually.

EX: _category.php_

```php
<?php

	// src/Category.php
	/**
	* @Entity (repositoryClass="CategoriesRepository")
	* @Table(name="categories", uniqueConstraints={ @UniqueConstraint(name="unique_name", columns={ "name" }) } )
	**/
	class Category implements JsonSerializable
	{
		/**
		* @Id
		* @Column(type="integer")
		* @GeneratedValue
		*/
		protected $id;

		/**
		* @Column(type="integer", name="parent_id")
		*/
		protected $parentId;

		/**
		* @Column(type="string")
		*/
		protected $name;

		/** @Column(type="integer") **/
		protected $count;

		/**
		* @Column(type="string")
		*/
		protected $meaning;

		/**
		* @Column(type="string")
		*/
		protected $concept;

		public function getId()
		{
			return $this->id;
		}

		public function getParentId()
		{
			return $this->parentId;
		}
		public function setParentId($parentId)
		{
			$this->parentId = $parentId;
		}

		public function getName()
		{
			return $this->name;
		}

		public function setName($name)
		{
			$this->name = $name;
		}

		public function getCount()
		{
			return $this->count;
		}

		public function setCount($count)
		{
			$this->count = $count;
		}

		public function getMeaning()
		{
			return $this->meaning;
		}

		public function setMeaning($meaning)
		{
			$this->meaning = $meaning;
		}

		public function getConcept()
		{
			return $this->concept;
		}

		public function setConcept($concept)
		{
			$this->concept = $concept;
		}

		public function expose() {
			return get_object_vars($this);
		}

		public function jsonSerialize() {
			return array(
				'id' => $this->id,
				'parentId' => $this->parentId,
				'name' => $this->name,
				'count' => $this->count,
				'meaning' => $this->meaning,
				'concept' => $this->concept
			);
		}
	}
?>
```

# Repository

+projects/src

#--+./repositories

##----+./itemsRepository.php --> It's a data layer, all the databse operation go here
EX: _categoriesRepository.php_

```php
<?php

	use Doctrine\ORM\EntityRepository;
	use Doctrine\ORM\Query\ResultSetMapping;

	class CategoriesRepository extends EntityRepository
	{
		function save($cat) {
			$em1 = getEntityManager();
			$em1->persist($cat);
			$em1->flush();
			return $cat->getId();
		}

		function findAllByParentId($parentId) {
			$dql = "SELECT c FROM Category c WHERE c.parentId = $parentId ORDER BY c.name ASC";

			$query = getEntityManager()->createQuery($dql);
			$query->setMaxResults(120);
			return $query->getResult();
		}

		function incrementCounts($catIds) {

			foreach($catIds as $id) {

				$sql = "UPDATE categories SET count = count + 1 WHERE id = $id";
				$stmt = getEntityManager()->getConnection()->prepare($sql);
				$stmt->executeQuery();
			}
		}

		function delete($id) {
			$dql = "DELETE Category c WHERE c.id = $id";
			$query = getEntityManager()->createQuery($dql);
			return $query->execute();
		}

	}

	$categoriesRepository = $em->getRepository('Category');
?>
```

# Others

## Proxy command

_To generate Doctrine proxy class_

`$ vendor/bin/doctrine orm:generate-proxies`

# Local Domain

## Create localhost Domain

`$ cd /etc/apache2/sites-available/`

`$ ls`

`$ sudo cp 000-default.conf sitename.localhost.conf`

`$ sudo nano sitename.localhost.conf`

`$ sudo a2ensite sitename.localhost.conf`

`$ sudo service apache2 restart`

# User Seed

_To Create default Admin user_

```php
<?php


/* configuration */
require_once(__DIR__. '/../src/configs/config.php');
require_once(__DIR__. '/../src/framework/framework.php');
require_once(__DIR__ . '/../src/repositories/UsersRepository.php');

$options = [
    'cost' => 12,
];
$passwordHash = password_hash("@dm!n-p@$$", PASSWORD_BCRYPT, $options);

$user = new User();
$user->setEmail('admin@headmistry.com');
$user->setFullName('Azad');
$user->setPassword($passwordHash);
$user->setUserName('admin');
$user->setUserRole('ADMIN');

try {
    $id = $usersRepository->save($user);
    $res = array( 'id' => $id, 'errors' => array());
    sendJsonResponse(201, $res);

} catch(Exception $ex) {

    $errorCode = $ex->getPrevious()->getCode();
    if ($errorCode == 23000)
        sendEmptyJsonResponse(409);
    else
        sendEmptyJsonResponse(500);

}

?>
```

# SQL

_To set foreign key_

```sql
SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;
```

_0 mean unset, 1 means set_
