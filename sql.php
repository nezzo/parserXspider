<?php
define('DB_HOST', 'localhost');
define('DB_NAME', 'dotplant2');
define('DB_USER', 'root');
define('DB_PASS', '1111111');
define('DB_CHAR', 'utf8');

class DB
{
    protected static $instance = null;

    public function __construct() {}
    public function __clone() {}

    public static function instance()
    {
        if (self::$instance === null)
        {
            $opt  = array(
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => TRUE,
            );
            $dsn = 'mysql:host='.DB_HOST.';dbname='.DB_NAME.';charset='.DB_CHAR;
            self::$instance = new PDO($dsn, DB_USER, DB_PASS, $opt);
        }
        return self::$instance;
    }
    
    public static function __callStatic($method, $args)
    {
        return call_user_func_array(array(self::instance(), $method), $args);
    }

    //функция нужно для вызова SELECT  или UPDATE что бы в коде не писать, а просто вызвать этот метод и передать сюда параметры
    public static function run($sql, $args = [])
    {
        $stmt = self::instance()->prepare($sql);
        $stmt->execute($args);
        return $stmt;
    }
}

