<?php

/**
 * @package PapipuEngine
 * @author valmon, z-mode
 * @version 0.2
 * Главная страница, по умолчанию действие Index
 */
class teachers_Page extends View {
    /*
     * Инициализация контроллера
     */

    public static function initController($action) {
    }

    /*
     * Главная страница сайта
     */
    public static function indexAction($id) {
    	$id = !empty($id) ? $id : $id;
 		self::$page['content']['teachers'] = self::getPrepods(self::setRequest($id));
 		self::showXSLT('pages/teachers/index');
    }
	public static function getPrepods($Request){
		//Получаем массив факультетов
		$response = self::connectWsdl()->getTeachersByDept($Request);
		for($i=0; $i<count($response->return); $i++){
		$array[$i] = 
			array(
			"familyName"=>$response->return[$i]->familyName,
			"firstName"=>$response->return[$i]->firstName,
			"id" =>$response->return[$i]->id,
			"secondName"=>$response->return[$i]->secondName,
			"position"=>$response->return[$i]->position
			);
		}
		return $array;
	}
    /**
     * 
     * Enter description here ...
     * @param unknown_type $id - teacher id
     */
	public static function viewAction($id) {
    	$id = !empty($id) ? $id : $id;
 		self::$page['content']['teacher_info'] = self::getPrepodsInfo(self::setTeacherId($id));
 		Debug::dump(self::$page['content']['teacher_info']);
 		self::$page['content']['teacher_disc'] = self::getDisciplin(self::setTeacherId($id));
 		Debug::dump(self::$page['content']['teacher_disc']);
 		self::$page['content']['teacher_pub'] = self::getPublication(self::setTeacherId($id));
 		self::$page['content']['teacher_foto'] = "https://89.232.109.231/Education//public/TeacherPhoto?par_personid=$id";
 		Debug::dump(self::$page['content']['teacher_foto']);
 		self::showXSLT('pages/teachers/view');
    }
	public static function getPrepodsInfo($Request){
		$response = self::connectWsdl()->getTeacherInfo($Request);
		$array = 
			array(
			"familyName"=>$response->return->familyName,
			"firstName"=>$response->return->firstName,
			"id" =>$response->return->id,
			"secondName"=>$response->return->secondName,
			"position"=>$response->return->position,
			"acadegree"=>$response->return->acadegree_short,
			"science_short"=>$response->return->science_short,
			"department"=>$response->return->department,
			
			);
		return $array;
	}
	public static function getDisciplin($Request){
		setlocale(LC_ALL, 'ru_RU.CP1251');
		$response = self::connectWsdl()->getTeacherDisc($Request);
		for($i=0; $i<count($response->return->disciplines); $i++){
			if(isset($response->return->disciplines) && count($response->return->disciplines) >1){
				$array[$i] = 
					array(
					"disciplines"=>(isset($response->return->disciplines[$i]->name)) ?
					mb_strtolower(mb_strtoupper($response->return->disciplines[$i]->name)) : null
					);
			}
			else {
				$array = 
					array(
					"disciplines"=>(isset($response->return->disciplines->name)) ?
					strtolower($response->return->disciplines->name) : null
					);
			}
		}
		return $array;
	}
	public static function getPublication($Request){
		$array = array();
		$response = self::connectWsdl()->getTeacherPub($Request);
		if(isset($response->return->publications) && count($response->return->publications) >1){
			for($i=0; $i<count($response->return->publications); $i++){
			$array[$i] =
				array(
				"author"=>$response->return->publications[$i]->author,
				"lang"=>$response->return->publications[$i]->lang,
				"pages" => (isset($response->return->publications[$i]->pages)) ?
				($response->return->publications[$i]->pages) :null,
				"proceedings_name"=>(isset($response->return->publications[$i]->proceedings_name))?
				$response->return->publications[$i]->proceedings_name : null,
				"proceedings_name"=>$response->return->publications[$i]->title,
				"type"=>$response->return->publications[$i]->type,
				"vak"=>$response->return->publications[$i]->vak,
				"year"=>$response->return->publications[$i]->year,
				"pubid"=>$response->return->publications[$i]->pubid			
				);
			}
		return $array;
		}
		else return false;
	}	
	
	 public static function setRequest($id){
		$Request = new stdClass();
		$Request->department=$id;
		return $Request;		
	}
 	public static function setTeacherId($id){
		$Request = new stdClass();
		$Request->teacherid=$id;
		return $Request;		
	}
	private static function connectWsdl(){
		$Headers=new SoapHeader('http://idis.ieml.ru/ws/person', 
								'UserCredentials',
	                            array('@samigullin','mklP54sd'));
	                            
		$client = new SoapClient("https://89.232.109.231/Education/services/person?wsdl", 
		array('encoding'=>'utf-8', "trace"=> 1, "exceptions" => 0));
		$client->__setSoapHeaders($Headers);
		return $client;
	}
    
}