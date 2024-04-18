<?php
/**
 * This singleton class automatically includes classes based on the name of the class
 * It alleviates the need of having a require_once() statement every time you want to
 * include a certain class
 *
 * WARNING: Autoloading is not available if using PHP in CLI INTERACTIVE mode, however using on CLI
 * scripts is fine.
 */

namespace iRAP\Autoloader;

class Autoloader
{
    public static $strict = false;
    private $m_classDirs = array();
    private $m_conversionFunction = null;

    /**
     * The constructor for this class. It is private because this is a singleton that should only
     * be instatiated once by itself.
     * @param Array $classDirs - array of all the folder paths to look in for classes.
     * @param Closure $conversionFunction - (optional) provide An annonymous function to convert
     *                                      a given class name to the filename that it can be loaded
     *                                      from. If not provided then the Zend standard naming
     *                                      convention is assumed.
     * @return void
     */
    public function __construct($classDirs, Closure $conversionFunction = null)
    {
        $this->m_classDirs = $classDirs; # specify your model/utility/library folders here
        # If a conversion function has not been specified, then use our own default.
        if ($conversionFunction === null) {
            $conversionFunction = function ($className) {
                return Autoloader::convertClassNameToFileName($className);
            };

            $this->m_conversionFunction = $conversionFunction;
        } else {
            $this->m_conversionFunction = $conversionFunction;
        }

        // Specify extensions that may be loaded
        spl_autoload_extensions('.php, .class.php');
        spl_autoload_register(array($this, 'loaderCallback'));
    }

    /**
     * Callback function that is passed to the spl_autoload_register. This function is run whenever
     * php is trying to find a class to load. This needs to be public for the spl_auto_loader
     * but is not meant to be called from the outside by the programmers.
     *
     * @param className - the name of the class that we are trying to automatically load.
     *
     * @return result - boolean indicator whether we successfully included the file or not.
     * @throws exception if we found two possible places where the class can be loaded.
     */
    public function loaderCallback($className)
    {
        if (class_exists($className, false)) {
            $result = true;
        } else {
            $result = false;

            $filename = call_user_func($this->m_conversionFunction, $className);

            // position of slash in the class, to denote namespace presence
            $lastBackslashPositionIfNamespacePresent = strrpos($filename, '\\') ?: -1;
            $lastBackslashPositionIfNamespacePresent++; // to get the actual position, that's why -1 on the line before
            $filenameWithoutNamespace = substr($filename,
                $lastBackslashPositionIfNamespacePresent);

            foreach ($this->m_classDirs as $potentialFolder) {
                // Check for recursive directory
                if ($this->endsWith($potentialFolder, '*')) {

                    $folderToRecur = substr($potentialFolder, 0, -1);
                    $it = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($folderToRecur));
                    $it->rewind();

                    while ($it->valid()) {

                        $absoluteFilePath = $it->key();

                        if (!$it->isDot()) {

                            if ((self::$strict && $this->endsWith($absoluteFilePath,
                                $filenameWithoutNamespace)) || (!self::$strict && $this->endsWith(strtolower($absoluteFilePath),
                                strtolower($filenameWithoutNamespace)))) {

                                if ($this->tryAutoload($absoluteFilePath, $className)) {
                                    $result = true;
                                    break;
                                }
                            }
                        }

                        $it->next();
                    }

                    if ($result) {
                        break;
                    }
                } else {
                    $folderWithEndSlash = \realpath($potentialFolder) . '/';
                    $absoluteFilePath = $folderWithEndSlash . $filenameWithoutNamespace;

                    foreach (\glob($folderWithEndSlash . '*.php') as $file) {
                        if ((self::$strict && $file === $absoluteFilePath) || (!self::$strict && \strtolower($file)
                            === \strtolower($absoluteFilePath))) {
                            if ($this->tryAutoload($absoluteFilePath, $className)) {
                                $result = true;
                                break;
                            }
                        }
                    }

                    if ($result) {
                        break;
                    }
                }
            }
        }

        return $result;
    }

    /**
     * Given a class name, this function will convert it to the relevant filename
     * This function could be improved to handle abstract classes later which do not follow the
     * normal rule specified by zend. E.g. my_classAbstract.class.php compared to my_class.php
     *
     * @param className - the specified class that we are going to convert to a filename.
     *
     * @return filename - the name of the file that the class should be defined in.
     */
    public static function convertClassNameToFileName($className)
    {
        $filename = $className . '.php';
        return $filename;
    }

    /**
     * Check if a string ends with a character or a string
     * @param string $string String to be checked
     * @param string $checkString The check character or string
     * @return bool
     */
    private function endsWith(string $string, string $checkString): bool
    {
        return substr($string, 0 - strlen($checkString)) === $checkString;
    }

    /**
     * Try to autoload a class from a file path
     * @param string $filePath Path of the file
     * @param string $className Class name
     * @return bool
     */
    private function tryAutoload(string $filePath, string $className): bool
    {
        require_once $filePath;

        if (class_exists($className, false)) {
            $return = true;
        } else {
            $return = false;
        }

        return $return;
    }
}