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
	private static $_year = 2013;
	
	public static function initController($action) {

	}

	/*
	 * Главная страница сайта
	 */
	 
	public static function indexAction($id) {
		Session::set("filial", Router::getRouteParam('id'));
		self::$page['content'] = "";
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
		self::showXSLT('pages/abiturients/StudyForms');
	}

	public static function getEducPlansAjaxAction() {
		$params = new stdClass();
		$params -> branch = Session::get("filial") ? Session::get("filial") : "1";
		$params -> year = self::$_year;
		$params -> level = $_POST['level'];
		$params -> budget = $_POST['budget'];
		$params -> studyform = $_POST['studyform'];

		$response = self::connectWsdl("educplan?wsdl") -> getEducPlans($params);
		if (!empty($response -> return)) {
			for ($i = 0; $i < count($response -> return); $i++) {
				$res = count($response -> return) == 1 ? $response -> return : $response -> return[$i];
				$array[$i] = array(
				"id" => $response -> return[$i] -> id, 
				"specialityName" => $response -> return[$i] -> specialityName,
				"budgetplaces"=> !empty($response -> return[$i] -> budgetplaces) ? $response -> return[$i] -> budgetplaces : null);
			}
			self::$page['content'] = array();
			self::$page['content']['EducPlans'] = $array;
		} else {
			self::$page['content']['error'] = "нет данных";
		}
		self::showXSLT('pages/abiturients/EducPlans');
	}

	public static function getStagesAjaxAction() {
		$params = new stdClass();
		$params -> branch = Session::get("filial") ? Session::get("filial") : "1";
		$params -> year = self::$_year;
		$params -> level = $_POST['level'];

		$response = self::connectWsdl("entrants?wsdl") -> getStages($params) ? self::connectWsdl("entrants?wsdl") -> getStages($params) : null;

		if (!empty($response -> return)) {
			for ($i = 0; $i < count($response -> return); $i++) {
				$res = count($response -> return) == 1 ? $response -> return : $response -> return[$i];
				$array[$i] = array("id" => $res -> id, 
				"stageName" => $res -> stageName, 
				"beginDate" => $res -> beginDate, 
				"entrantsDate" => !empty($res -> entrantsDate) ? date("d.m.Y", strtotime($res->entrantsDate)) : null, 
				"recommendedDate" => !empty($res -> recommendedDate) ? $res -> recommendedDate : null, 
				"orderDate" => !empty($res -> orderDate) ? $res -> orderDate : null, 
				"level" => $res -> level, 
				"branch" => $res -> branch);

			}
			self::$page['content'] = array();
			self::$page['content']['getStages'] = $array;
		} else {
			self::$page['content']['error'] = "нет данных";
		}
		self::showXSLT('pages/abiturients/getStages');
	}

	public static function getEntrantsInfoAjaxAction() {
		$params = new stdClass();
		$params -> planid = $_POST['plan'];
		$params -> stageid = $_POST['stage'];
		$params -> phase = $_POST['phase'];
		$params -> budget = $_POST['budget'];

		$response = self::connectWsdl("entrants?wsdl") -> getEntrantsInfo($params) ? self::connectWsdl("entrants?wsdl") -> getEntrantsInfo($params) : null;
		$array2 = array();
		if (!empty($response -> return)) {
			for ($i = 0; $i < count($response -> return); $i++) {
				$res = count($response -> return) == 1 ? $response -> return : $response -> return[$i];
				unset($array2);
				if(isset($res->extExamScore) && !empty($res->extExamScore)){
					
					for ($ii = 0; $ii < count($res->extExamScore); $ii++) {
						$res2 = count($res->extExamScore) == 1 ? $res->extExamScore : $res->extExamScore[$ii];
						$array2[$ii] = array(
							"disciplineName" => $res2->disciplineName,
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
					"status" => !empty($res -> status) ? $res -> status : null
				);

			}
			self::$page['content']['getAbbiture'] = $array;
		} else {
			self::$page['content']['error'] = "нет данных";
		}
		self::$page['content']['budgetplaces'] = !empty($_POST['budgetplaces']) ? $_POST['budgetplaces'] : null;		
		self::showXSLT('pages/abiturients/getAbbiture');
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
	public static function getPrepods($Request) {
		//Получаем массив факультетов
		$response = self::connectWsdl() -> getTeachersByDept($Request);
		for ($i = 0; $i < count($response -> return); $i++) {
			$array[$i] = array("familyName" => $response -> return[$i] -> familyName, "firstName" => $response -> return[$i] -> firstName, "id" => $response -> return[$i] -> id, "secondName" => $response -> return[$i] -> secondName, "position" => $response -> return[$i] -> position);
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
		self::$page['content']['teacher_disc'] = self::getDisciplin(self::setTeacherId($id));
		self::$page['content']['teacher_pub'] = $pub_array = self::getPublication(self::setTeacherId($id));
		self::$page['content']['years_array'] = self::setYearsArray($pub_array);
		self::$page['content']['teacher_foto'] = "https://89.232.109.231/Education/public/TeacherPhoto?par_personid=$id";
		self::showXSLT('pages/teachers/view');
	}

	public static function getPrepodsByLetter($Request) {
		$response = self::connectWsdl() -> getTeachersByFIO($Request);
		if (isset($response -> return)) {
			if (count($response -> return) == 1) {
				$array[] = array("familyName" => $response -> return -> familyName, "firstName" => $response -> return -> firstName, "id" => $response -> return -> id, "secondName" => $response -> return -> secondName, "position" => $response -> return -> position, "department" => $response -> return -> department);
			} else {
				for ($i = 0; $i < count($response -> return); $i++) {
					$array[$i] = array("familyName" => $response -> return[$i] -> familyName, "firstName" => $response -> return[$i] -> firstName, "id" => $response -> return[$i] -> id, "secondName" => $response -> return[$i] -> secondName, "position" => $response -> return[$i] -> position, "department" => $response -> return[$i] -> department);
				}
			}
			return $array;
		} else
			return false;

	}

	public static function getPrepodsInfo($Request) {
		$response = self::connectWsdl() -> getTeacherInfo($Request);
		$array = array("familyName" => $response -> return -> familyName, "firstName" => $response -> return -> firstName, "id" => $response -> return -> id, "secondName" => $response -> return -> secondName, "position" => $response -> return -> position, "acadegree" => !empty($response -> return -> acadegree_short) ? $response -> return -> acadegree_short : null, "science_short" => !empty($response -> return -> science_short) ? $response -> return -> science_short : null, "department" => $response -> return -> department, );
		return $array;
	}

	public static function getDisciplin($Request) {
		$response = self::connectWsdl() -> getTeacherDisc($Request);
		for ($i = 0; $i < count($response -> return -> disciplines); $i++) {
			if (isset($response -> return -> disciplines) && count($response -> return -> disciplines) > 1) {
				$array[$i] = array("disciplines" => (isset($response -> return -> disciplines[$i] -> name)) ? $response -> return -> disciplines[$i] -> name : null);
			} else {
				$array = array("disciplines" => (isset($response -> return -> disciplines -> name)) ? strtolower($response -> return -> disciplines -> name) : null);
			}
		}
		return $array;
	}

	public static function getPublication($Request) {
		$array = array();
		$response = self::connectWsdl() -> getTeacherPub($Request);
		if (isset($response -> return -> publications) && count($response -> return -> publications) > 1) {
			for ($i = 0; $i < count($response -> return -> publications); $i++) {
				$array[$i] = array("author" => $response -> return -> publications[$i] -> author, "lang" => $response -> return -> publications[$i] -> lang, "pages" => (isset($response -> return -> publications[$i] -> pages)) ? ($response -> return -> publications[$i] -> pages) : null, "proceedings_name" => (isset($response -> return -> publications[$i] -> proceedings_name)) ? $response -> return -> publications[$i] -> proceedings_name : null, "proceedings_name" => $response -> return -> publications[$i] -> title, "type" => $response -> return -> publications[$i] -> type, "vak" => $response -> return -> publications[$i] -> vak, "year" => $response -> return -> publications[$i] -> year, "pubid" => $response -> return -> publications[$i] -> pubid);
			}
			return $array;
		} else
			return false;
	}

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

		$client = new SoapClient("https://89.232.109.231/Education/services/" . $service, array('encoding' => 'utf-8', "trace" => 1, "exceptions" => 0));
		$client -> __setSoapHeaders($Headers);
		return $client;
	}

}
