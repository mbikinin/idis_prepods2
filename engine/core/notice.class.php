<?php
/**
 * @package PapipuEngine
 * @author cot88, z-mode
 * @version 0.1
 * Оповещение пользователей
 */
class Notice {

	/**
	 * Таблица БД с шаблонами
	 * @var <type>
	 */

	private static $_tpl_table;

	/**
	 *
	 * Массив с данным для передачи на шаблон
	 * @var Array
	 */
	private static $_data = Array();

		/**
		 * Инициализация модуля
		 * @return null
		 */
		public static function initModule () {
			self::$_tpl_table = 'mail_tpl';
		}
	
		/**
		 * Отправляет оповещение
		 * @param int $user_id айди пользователя
		 * @param string $mail_tpl_id айди шаблона
		 * @param bool $by_sms только по смс
		 * @param text $ad_data дополнительный массив с данными
		 * @return array
		 */
		public static function send ($user_id,$tpl_id,$by_sms = false,$ad_data = array()) {
			$mailContent['offers'] = DB::fetchAll("SELECT img,title,uri FROM `events` WHERE `is_public` = '1' ORDER by `id` DESC LIMIT 0,3");
			$dict['dict_respect'] = DB::getValue('user_info', 'sex',"user_id = '$user_id'") == 1 ? 'Уважаемый' : 'Уважаемая'; 
			self::$_data = User::getById($user_id) + $ad_data + $dict;
			$tpl = self::getTpl($tpl_id,$by_sms);
			$mtext = self::compileTpl($tpl, self::$_data);
			if(!$mtext) return false;
			$mailContent['body'] = $mtext;
			$emtext =  View::getXSLT($mailContent, 'layouts/mail'); 			
			$subject = self::getSubject($tpl_id,$by_sms);
			Mail::newMailStandart($emtext, self::$_data['user_mail'], $subject);
			MD_user::sendMessage($user_id, $subject, $mtext);
			if ($by_sms) {
				$phone = DB::getValue('user_phone', 'phone_number',"user_id = '$user_id' AND active = '1' ");
				Sms::sendSms($phone, $mtext);
			}
			$type = $by_sms == false ? 'sms' : 'mail' ;
			self::log($user_id, $mtext,$type,$subject);
		}
	
	
		private static function getTpl ($tpl_id,$by_sms) {
			$where = "code = '$tpl_id'";
			$where .= $by_sms == true ? " AND type = 'sms'" : " AND type = 'mail'";
			if (!DB::getCount(self::$_tpl_table,$where)) return false;
			return DB::getValue(self::$_tpl_table, 'tpl',$where);
		}
		
		private static function getSubject ($tpl_id,$by_sms) {
			$where = "code = '$tpl_id'";
			$where .= $by_sms == true ? " AND type = 'sms'" : " AND type = 'mail'";
			if (!DB::getCount(self::$_tpl_table,$where)) return false;
			return DB::getValue(self::$_tpl_table, 'subject',$where);
		}
	
		/**
		 *
		 * компилирует шаблон
		 * @param string $tpl
		 * @param array $data
		 */
		private static function compileTpl ($tpl,$data) {
			if(!isset($data) or !is_array($data)) return false;
			$compile_data = array();
			foreach($data as $k=>$v) $compile_data['%'.$k.'%'] = $v;
			$tpl = strtr($tpl, $compile_data);
			return $tpl;
		}
		
		/**
		 * 
		 * Отправка письма по е-мейлу
		 * @param string $email
		 * @param string $tpl_id
		 */
		
		public static function sendByEmail($email,$tpl_id,$data=array()) {
		
			$tpl = self::getTpl($tpl_id,false);
			$mtext = self::compileTpl($tpl, $data);
			
			if(!$mtext) return false;
			
			
			$mailContent['body'] = $mtext;
			$mailContent['offers'] = DB::fetchAll("SELECT img,title,uri FROM `events` WHERE `is_public` = '1' ORDER by `id` DESC LIMIT 0,3");
			$emtext =  View::getXSLT($mailContent, 'layouts/mail');
			
			$subject = self::getSubject($tpl_id,false);
			Mail::newMailStandart($emtext, $email, $subject);
			
			self::log('0', $emtext,'mail',$subject);
		}
		
		
		/**
		 * 
		 * Логи
		 * @param int $user_id
		 * @param string $text
		 * @param string $subject
		 * @param enum(sms,mail) $type
		 */
		private static function log ($user_id,$text,$type,$subject=null) {
			$data = array (
				'user_id' => $user_id,
				'text' => $text,
				'subject' => $subject,
				'type' => $type,
				'date' => 'NOW()'
			);
			
			DB::insert('log_notice', $data,false);
		}





}