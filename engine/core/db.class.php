<?php
/**
 * @package PapipuEngine
 * @author valmon, z-mode
 * @version 0.2
 * Класс для работы с базой данных
 */
class DB {

    /**
     * Идентификатор подключения
     * @var PDO
     */
    protected static $_connection;

    /**
     * Метод вызывается сразу после загрузки класса
     * @return null
     */
    public static function initModule () {
        //self::connectBase ();
    }

   
}