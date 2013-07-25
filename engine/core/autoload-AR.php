<?php
/**
 * @package PapipuEngine
 * @author valmon, z-mode
 * @version 0.2
 * Реализация автоматического подключения классов ядра и модулей,
 * Если у класса есть метод initModule, он вызывается автоматически
 * У модуля метод initModule НЕ вызывается автоматически
 * @param $class Название класса
 * @return null
 */
function __autoload ($class) {
	$file_name = strtolower($class);
	if (file_exists($_SERVER['DOCUMENT_ROOT'].'/engine/core/'.$file_name.'.class.php')) {
		try {
			$file = $_SERVER['DOCUMENT_ROOT'].'/engine/core/'.$file_name.'.class.php';
			include_once ($file);

			if (method_exists($class, 'initModule')) {
				//echo 'class::'.$class.'<br>';
				call_user_func_array(array('Event', 'sendEvent'),array($class,'INIT'));
				call_user_func(array($class, 'initModule'));
				call_user_func_array(array('Event', 'sendEvent'),array($class,'AFTER'));
			}

		} catch (Exception $e) {
			Error::setError('SYS',$e->getMessage());
		}

	} else {
		$path = ActiveRecord\Config::instance()->get_model_directory();
		$root = realpath(isset($path) ? $path : '.');

		if (($namespaces = ActiveRecord\get_namespaces($class)))
		{
			$class_name = array_pop($namespaces);
			$directories = array();

			foreach ($namespaces as $directory)
			$directories[] = $directory;

			$root .= DIRECTORY_SEPARATOR . implode($directories, DIRECTORY_SEPARATOR);
		}

		$file = "$root/$class.php";

		if (file_exists($file))
		include_once $file;
	}
}