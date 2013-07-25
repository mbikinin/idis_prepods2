<?php
/**
 * @package PapipuEngine
 * @author valmon, z-mode
 * @version 0.2
 * Класс для работы с e-mail
 */
class Mail {

    /**
     * Инициализация модуля
     * @return null
     */
    public static function initModule () {
        require_once (Config::getValue('path','libs').'phpmailer/class.phpmailer.php');
    }

    /**
     * Отправка стандартными средствами через mail()
     * return mail();
     */
    public static function newMailStandart ($message,$to,$subject) {
        // To send HTML mail, the Content-type header must be set
        $headers  = 'MIME-Version: 1.0' . "\r\n";
        $headers .= 'Content-type: text/html; charset=UTF-8' . "\r\n";

        // Additional headers
        $headers .= 'To: '.$to. "\r\n";
        $headers .= 'Subject: '.$subject. "\r\n";
        $headers .= 'From: '.Config::getValue("site", "name").' <noreply@tosol.su>' . "\r\n";
        mail(null, null, $message, $headers);
    }
  

}