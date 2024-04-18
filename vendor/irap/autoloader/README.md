
This is a package for PHP which simplifies the setup of autoloading. This requires your class names to exactly reflect your file names. E.g. the class called `MyClass` should be in a file called `MyClass.php`. You should use unique class names. This package even supports classes with *namespaces*.

## Example Usage

```
<?php
require_once(__DIR__ . '/vendor/autoload.php'); # this autoloads all vendor packages

$classFolders = array(
    __DIR__ . '/controllers',
    __DIR__ . '/libs',
    __DIR__ . '/views/*',
    __DIR__ . '/middleware',
    __DIR__ . '/models/',
);

// Optional attribute for strict autoloading (case sensitive), defaults to false
iRAP\Autoloader\Autoloader::$strict = true;

$autoloader = new iRAP\Autoloader\Autoloader($classFolders);
```

That's it! Now all of your classes will automatically load. You don't need to use any `include` or `require` statements.

*There shouldn't be a problem if a directory ends with a `/` or not. If a directory ends with `/*`, this means that the directory is supposed to do a recursive search for directories inside the directory. Attribute `strict` is strict autoloading to match filenames to class names. Keeping it false will allow class `Application` to autoload from `application.php` or class `UserController` from `usercontroller.php`*