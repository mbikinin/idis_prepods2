<?php

/**
 * @package PapipuEngine
 * @author maks
 * @version 1
 * Главная страница, по умолчанию действие Index
 */
class abiturients_Page extends View {
	/*
	 * Инициализация контроллера
	 */
	private static $_year = 2015;
	
	public static function initController($action) {

	}

	/*
	 * Главная страница сайта
	 */
	 
	public static function indexAction($id) {
		Session::set("filial", Router::getRouteParam('id'));
		self::$page['content'] = "";
		self::$page['content']['filial'] = Router::getRouteParam('id');
		self::showXSLT('pages/abiturients/index');
	}

	public static function getFilials() {
		$response = self::connectWsdl("department?wsdl") -> getBranches();
		for ($i = 0; $i < count($response -> return); $i++) {
			$array[$i] = array("id" => $response -> return[$i] -> id, "city" => $response -> return[$i] -> city);
		}

		return $array;
	}

	public static function getStudyFormsAjaxAction() {

		$params = new stdClass();
		$params -> branch = Session::get("filial") ? Session::get("filial") : "1";
		$params -> year = self::$_year;
		$params -> level = $_POST['level'];
		$params -> budget = $_POST['budget'];
		$params -> free = $_POST['free'];

		$response = self::connectWsdl("studyform?wsdl") -> getStudyForms($params) ? self::connectWsdl("studyform?wsdl") -> getStudyForms($params) : null;

		if (!empty($response -> return)) {
			for ($i = 0; $i < count($response -> return); $i++) {
				$res = count($response -> return) == 1 ? $response -> return : $response -> return[$i];
				$array[$i] = array("id" => $res -> id, "name" => $res -> name);
			}
			self::$page['content'] = array();
			self::$page['content']['StudyForms'] = $array;
		} else {
			self::$page['content']['error'] = "нет данных";
		}
		self::$page['content']['count_budget'] = 
		self::showXSLT('pages/abiturients/StudyForms');
	}

	public static function getEducPlansAjaxAction() {
		$params = new stdClass();
		$params -> branch = Session::get("filial") ? Session::get("filial") : "1";
		$params -> year = self::$_year;
		$params -> level = $_POST['level'];
		$params -> budget = $_POST['budget'];
		$params -> studyform = $_POST['studyform'];
		$params -> free = $_POST['free'];
		
		$response = self::connectWsdl("educplan?wsdl") -> getEducPlans($params);

		if(isset($response -> return) && count($response -> return) == 1){
			$array[] = array(
				"id" => $response -> return -> id, 
				"skillId" => $response -> return -> skillId, 
				"budget" => $_POST['budget'],
				"specialityName" => $response -> return -> specialityName,
				"budgetplaces"=> !empty($response -> return -> budgetplaces) ? $response -> return -> budgetplaces : null,
				"kvotaplaces"=> !empty($response -> return -> kvotaplaces) ? $response -> return -> kvotaplaces : null,
				"freeplaces"=> !empty($response -> return -> freeplaces) ? $response -> return -> freeplaces : null,
				"dateNow" => date('d/m/Y',  time()));
		}
		else if (!empty($response -> return) && count($response -> return) > 1) {
			for ($i = 0; $i < count($response -> return); $i++) {
				$res = $response -> return[$i];
				$array[$i] = array(
				"id" => $res -> id, 
				"skillId" => $res -> skillId, 
				"budget" => $_POST['budget'],
				"specialityName" => $res -> specialityName,
				"budgetplaces"=> !empty($res -> budgetplaces) ? $res -> budgetplaces : null,
				"kvotaplaces"=> !empty($res -> kvotaplaces) ? $res -> kvotaplaces : null,
				"freeplaces"=> !empty($res -> freeplaces) ? $res -> freeplaces : null,
				"dateNow" => date('d/m/Y',  time()));
			}
		} else {
			self::$page['content']['error'] = "нет данных";
		}
 		self::$page['content'] = array();
                self::$page['content']['EducPlans'] = $array;
		self::showXSLT('pages/abiturients/EducPlans');

}
	public static function getStagesAjaxAction() {
		$params = new stdClass();
		$params -> branch = Session::get("filial") ? Session::get("filial") : "1";
		$params -> year = self::$_year;
		$params -> level = $_POST['level'];
		$response = self::connectWsdl("entrants?wsdl") -> getStages($params) ? self::connectWsdl("entrants?wsdl") -> getStages($params) : null;
		$array1 = array();
		
		if (!empty($response -> return)) {
			for ($i = 0; $i < count($response -> return); $i++) {
				$res = count($response -> return) == 1 ? $response -> return : $response -> return[$i];
				unset($array1);
				if(isset($res->phase->entry) && !empty($res->phase->entry)){					
					for ($ii = 0; $ii < count($res->phase->entry); $ii++) {
						$res2 = count($res->phase->entry) == 1 ? $res->phase->entry : $res->phase->entry[$ii];
						$array1[$ii] = array(
							"phasekey" => $res2->key,
							"phasevalue" => $res2->value,
							"level" => $params -> level
						);
						
						
					}
				}
				
				$array[$i] = array("id" => $res -> id, 
				"stageName" => $res -> stageName,
				"phases" => $array1,
				"reccertaincitizensdate" => !empty($res -> reccertaincitizensdate) ? date("d/m/Y", strtotime($res->reccertaincitizensdate)) : null,
				"krimrecommendeddate" => !empty($res -> krimrecommendeddate) ? date("Н-m-d", strtotime($res->krimrecommendeddate)) : null,
				"beginDate" => date("d/m/Y", strtotime($res->beginDate)), 
				"endDate" => !empty($res -> endDate) ? date("d/m/Y", strtotime($res->endDate)) : null, 
				"orderDate" => !empty($res -> orderDate) ? date("d/m/Y", strtotime($res->orderDate)) : null, 
				"recommendedDate" => !empty($res -> recommendedDate) ? $res -> recommendedDate : null, 
				"orderDate" => !empty($res -> orderDate) ? $res -> orderDate : null, 
				"level" => $res -> level, 
				"branch" => $res -> branch);

			}
			self::$page['content'] = array();
			self::$page['content']['getStages'] = $array;
			self::$page['content']['level'] = $_POST['level'];
		} else {
			self::$page['content']['error'] = "нет данных";
		}
		self::showXSLT('pages/abiturients/getStages');
	}

	public static function getEntrantsInfoAjaxAction() {
		$params = new stdClass();
		$params -> free = $_POST["freeParam"];		
		$params -> planid = $_POST["plan"];
		$params -> stageid = $_POST['stage'];
		$params -> phase = $_POST['phase'];
		$params -> budget = $_POST['budget'];
		

		$response = self::connectWsdl("entrants?wsdl") -> getEntrantsInfo($params) ? self::connectWsdl("entrants?wsdl") -> getEntrantsInfo($params) : null;
		$array2 = array();
		$schoolDisc = array();
		if ( !empty($response -> return) ) {
			for ($i = 0; $i < count($response -> return); $i++) {
				$res = count($response -> return) == 1 ? $response -> return : $response -> return[$i];
				unset($array2);
				unset($schoolDisc);
				if(isset($res->extExamScore) && !empty($res->extExamScore)){
					for ($ii = 0; $ii < count($res->extExamScore); $ii++) {
						$res2 = count($res->extExamScore) == 1 ? $res->extExamScore : $res->extExamScore[$ii];
						
						$array2[$ii] = array(
							"disciplineName" => $res2->disciplineName,
							"score" => $res2->score
						);	
					}
				}
				if(isset($res->schoolDiscScore) && !empty($res->schoolDiscScore)){
					for ($ii = 0; $ii < count($res->schoolDiscScore); $ii++) {
						$res2 = count($res->schoolDiscScore) == 1 ? $res->schoolDiscScore : $res->schoolDiscScore[$ii];

						$schoolDisc[$ii] = array(
							"disciplineName" => $res2->disciplineName,
							"score" => $res2->score,
							"entranceDisciplineId" => $res2->entranceDisciplineId,
							"score" => $res2->score
						);
					}
				}

				$array[$i] = array(
					"familyname" => $res -> familyname, 
					"firstname" => $res -> firstname, 
					"secondname" => $res -> secondname, 
					"resultScore" => $res -> resultScore, 
					"docOriginal" => !empty($res -> docOriginal) ? $res -> docOriginal : null,
					"getDiscipline" => !empty($array2) ? $array2 : array(),
					"getDisciplineAll" => !empty($array2) ? $array2 : array(),
					"getDisciplineKvote" => !empty($array2) ? $array2 : array(),
					"status" => !empty($res -> status) ? $res -> status : null,
					"kvota" => !empty($res -> kvota) ? $res -> kvota : null,
					"priority" => !empty($res->priority) ? $res->priority : null,
					"achivScore" => isset($res->achivScore) ? $res->achivScore : null,
					"averagescore"=> isset($res->averagescore) ? $res->averagescore : null,
					"schoolDiscScore" => !empty($schoolDisc) ? $schoolDisc : array()
				);

				if(!empty($res -> kvota) && $res -> kvota == 1){
					$array3[$i] = array(
						"familyname" => $res -> familyname, 
						"firstname" => $res -> firstname, 
						"secondname" => $res -> secondname, 
						"resultScore" => $res -> resultScore, 
						"docOriginal" => !empty($res -> docOriginal) ? $res -> docOriginal : null,
						"getDiscipline" => !empty($array2) ? $array2 : array(),
						"getDisciplineAll" => !empty($array2) ? $array2 : array(),
						"getDisciplineKvote" => !empty($array2) ? $array2 : array(),
						"status" => !empty($res -> status) ? $res -> status : null,
						"kvota" => !empty($res -> kvota) ? $res -> kvota : null,
						"priority" => !empty($res->priority) ? $res->priority : null,
						"achivScore" => isset($res->achivScore) ? $res->achivScore : null
					);
				}
				if($res -> kvota == 0){				
					$array4[$i] = array(
						"familyname" => $res -> familyname, 
						"firstname" => $res -> firstname, 
						"secondname" => $res -> secondname, 
						"resultScore" => $res -> resultScore, 
						"docOriginal" => !empty($res -> docOriginal) ? $res -> docOriginal : null,
						"getDiscipline" => !empty($array2) ? $array2 : array(),
						"getDisciplineAll" => !empty($array2) ? $array2 : array(),
						"getDisciplineKvote" => !empty($array2) ? $array2 : array(),
						"status" => !empty($res -> status) ? $res -> status : null,
						"kvota" => !empty($res -> kvota) ? $res -> kvota : null,
						"priority" => !empty($res->priority) ? $res->priority : null,
						"achivScore" => isset($res->achivScore) ? $res->achivScore : null
					);
				}

			}
			self::$page['content']['getAbbitureAll'] = self::$page['content']['getAbbitureStatus'] = self::$page['content']['getAbbitureColledg'] = $array;
			self::$page['content']['getAbbitureKvote'] = isset($array3) && count($array3) > 0 ? $array3 : null;
			self::$page['content']['getAbbitureNoKvote'] = isset($array4) && count($array4) > 0 ? $array4 : null;
			
		}
		else {
			self::$page['content']['error'] = "нет данных";
		}

		self::$page['content']['phase'] = $_POST['phase'];
		self::$page['content']['budget'] = $_POST['budget'];
		self::$page['content']['free'] = $_POST['freeParam'];
		self::$page['content']['inst'] = $_POST['inst'];
		self::$page['content']['budgetplaces'] = !empty($_POST['budgetplaces']) ? $_POST['budgetplaces'] : null;		
		self::showXSLT('pages/abiturients/getAbbiture');
	}

	public static function getEntrantsInfoListAjaxAction() {
		self::$page['content']['phase'] = $_POST['phase'];
		self::showXSLT('pages/abiturients/getAbbitureList');
	}

	public static function xsort(&$nodes, $child_name, $order = SORT_ASC) {
		$sort_proxy = array();

		foreach ($nodes as $k => $node) {
			$sort_proxy[$k] = (string)$node -> $child_name;
		}

		array_multisort($sort_proxy, $order, $nodes);
	}

	//Education/services/entrants/getEntrantsInfo?planid=5245&stageid=41&phase=0&budget=0
	///Education/services/entrants/getStageEntrants?planid=6136&stageid=41&phase=2&budget=1


	public static function setYearsArray($array) {
		$i = 0;
		$return = array();
		if (!empty($array))
			foreach ($array as $val) {
				$return[$i++] = $val['year'];
			}
		return array_unique($return);

	}

	public static function setRequest($id) {
		$Request = new stdClass();
		$Request -> department = $id;
		return $Request;
	}

	public static function setTeacherId($id) {
		$Request = new stdClass();
		$Request -> teacherid = $id;
		return $Request;
	}

	public static function setLetter($id) {

		$Request = new stdClass();

		$Request -> familyname = "$id";
		return $Request;
	}

	private static function connectWsdl($service) {
		$Headers = new SoapHeader('http://idis.ieml.ru/ws/person', 'UserCredentials', array('@samigullin', 'mklP54sd'));

		$client = new SoapClient("https://idis.ieml.ru/Education/services/" . $service, array('encoding' => 'utf-8', "exceptions" => 0));
		$client -> __setSoapHeaders($Headers);
		return $client;
	}

}
