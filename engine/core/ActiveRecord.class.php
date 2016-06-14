<?php
if (!defined('PHP_VERSION_ID') || PHP_VERSION_ID < 50300)
die('PHP ActiveRecord requires PHP 5.3 or higher');

define('PHP_ACTIVERECORD_VERSION_ID','1.0');
$path_to_ar_lib = $_SERVER['DOCUMENT_ROOT'].'/engine/libs/ActiveRecord/';
require $path_to_ar_lib.'Singleton.php';
require $path_to_ar_lib.'Config.php';
require $path_to_ar_lib.'Utils.php';
require $path_to_ar_lib.'DateTime.php';
require $path_to_ar_lib.'Model.php';
require $path_to_ar_lib.'Table.php';
require $path_to_ar_lib.'ConnectionManager.php';
require $path_to_ar_lib.'Connection.php';
require $path_to_ar_lib.'SQLBuilder.php';
require $path_to_ar_lib.'Reflections.php';
require $path_to_ar_lib.'Inflector.php';
require $path_to_ar_lib.'CallBack.php';
require $path_to_ar_lib.'Exceptions.php';

//ActiveRecord\Config::initialize(function($cfg)
//{
//    $cfg->set_model_directory($_SERVER['DOCUMENT_ROOT']. '/models');
//    $cfg->set_connections(array('development' => 'mysql://root:150878@127.0.0.1/dk'));
//
//	// you can change the default connection with the below
//    //$cfg->set_default_connection('production');
//});
?>
