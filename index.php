<?php

setlocale(LC_CTYPE, "ru_RU.UTF-8");
header('Content-Type: text/html; charset=utf-8');

if (stristr($_SERVER['HTTP_USER_AGENT'], 'MSIE 6.0')) {
	header('Location: /ie/index6_ru.html', true, 303);
} elseif (stristr($_SERVER['HTTP_USER_AGENT'], 'MSIE 7.0')) {
	header('Location: /ie/index7_ru.html', true, 303);
}
include_once ('engine/core/engine.class.php');
$_SERVER['DOCUMENT_ROOT'] = $_SERVER['DOCUMENT_ROOT'];
/* -- Подключение патерна ActiveRecords -- */
// include_once ('engine/core/ActiveRecord.class.php');
/* -- Запуск ядра -- */
Engine::initModule();