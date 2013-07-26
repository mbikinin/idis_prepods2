<?php

/**
 * @package PapipuEngine
 * @author maks
 * @version 1

 * Главная страница, по умолчанию действие Index
 */
class index_Page extends View {
    /*
     * Инициализация контроллера
     */

    public static function initController($action) {
    }

    /*
     * Главная страница сайта
     */
    public static function indexAction($id) {
    	self::$page['content'] = "";
		//self::$page['content']['facultets'] = self::getFaculties(self::setRequest(1));
        self::showXSLT('pages/index/index');
    }
 	public static function getFaculties($Request){  
		$Headers=new SoapHeader('http://idis.ieml.ru/ws/department', 
								'UserCredentials',
	                            array('@samigullin','mklP54sd'));
	                            
		$client = new SoapClient("https://89.232.109.231/Education/services/department?wsdl", 
		array('encoding'=>'utf-8', "trace"=> 1, "exceptions" => 0));
		$client->__setSoapHeaders($Headers);
		//Получаем массив факультетов
		$response = $client->getFaculties($Request);
		
		for($i=0; $i<count($response->return); $i++){
		$fackultetsArray[$i] =
					array(
					"branch"=>$response->return[$i]->branch,
					"fullName"=>$response->return[$i]->fullName,
					"id" =>$response->return[$i]->id,
					"parentId"=>$response->return[$i]->parentId,
					"shortName"=>$response->return[$i]->shortName,
					"yearBegin"=>$response->return[$i]->yearBegin,
					"chairs"=>self::getChairs( self::setFacultet($response->return[$i]->id) )
					);
		}
		return $fackultetsArray;
	}
	 public static function getChairs($Request){  
	                            
		$client = new SoapClient("https://89.232.109.231/Education/services/department?wsdl", 
		array('encoding'=>'utf-8', "trace"=> 1, "exceptions" => 0));
		//Получаем массив факультетов
		$chairs = $client->getChairs($Request);
		if(isset($chairs->return) && count($chairs->return) >1){
			for ($i=0; $i<count($chairs->return); $i++) {
			$chairsArray[$i] =
						array(
						"fullName"=>$chairs->return[$i]->fullName,
						"id" =>$chairs->return[$i]->id,
						"parentId"=>$chairs->return[$i]->parentId,
						"shortName"=>$chairs->return[$i]->shortName,
						);
			}
			return $chairsArray;
		}
		else {
		$chairsArray =
						array(
						"fullName"=>(isset($chairs->return->fullName)) ? 
						$chairs->return->fullName : null,
						"id" =>(isset($chairs->return->id)) ?
						$chairs->return->id : null,
						"parentId"=>(isset($chairs->return->parentId)) ?
						$chairs->return->parentId : null,
						"shortName"=>(isset($chairs->return->shortName)) ? 
						$chairs->return->shortName : null,
						);
						
			return $chairsArray;
			}
			
		
		
	}
	 public static function setRequest($branch){
		$Request = new stdClass();
		$Request->branch=$branch;
		return $Request;		
	}
	 public static function setFacultet($facultet){
		$Request = new stdClass();
		$Request->faculty=$facultet;
		return $Request;		
	}
    
}