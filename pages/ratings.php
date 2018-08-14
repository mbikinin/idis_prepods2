<?php

/**
 * @package PapipuEngine
 * @author maks
 * @version 1
 * Главная страница, по умолчанию действие Index
 */
class ratings_Page extends View
{
    /*
     * Инициализация контроллера
     */
    public static function initController($action)
    {
        $id = !empty($_GET['id']) ? trim($_GET['id']) : null;
        Session::set("branch", $id);
    }

    /*
     * Главная страница сайта
     */

    public static function indexAction($id)
    {
        self::$page['content'] = "";
	    self::$page['content']['branch'] = Session::get("branch");
        self::$page['content']['filials'] = self::getFilials();
        self::showXSLT('pages/ratings/index');
    }

    public static function informationAction(){
        self::$page['content'] = "";
        self::$page['content']['branch'] = Session::get("branch");
        self::$page['content']['filials'] = self::getFilials();
        self::showXSLT('pages/ratings/information');
    }
    /**
     * @return array|void
     */
    public static function getFilials()
    {
        $response = self::connectWsdl("department?wsdl")->getBranches();
        for ($i = 0; $i < count($response-> return); $i++) {
        $array[$i] = array("id" => $response-> return [$i]->id, "city" => $response-> return [$i] -> city);
		}
		return $array;
	}

    public static function getEducPlansAjaxAction()
    {
        $params = new stdClass();
        $params->branch = $_POST['branch'];
        $params->year = date('Y');
        $params->financeform = $_POST['financeform'];
        $params->studyform = $_POST['studyform'];
        $params->skillvalue = $_POST['skillvalue'];

        $response = self::connectWsdl("educplan?wsdl")->getEducPlans($params);
        if (!empty($response-> return)) {
        for ($i = 0; $i < count($response-> return); $i++) {
            $res = count($response-> return) == 1 ? $response-> return : $response-> return [$i];
				$array[$i] = array(
                    "skillId" => $res->skillId,
                    "speccode" => $res->specialityId,
                    "specialityName" => $res->specialityName
                );
			}
			self::$page['content'] = array();
			self::$page['content']['EducPlans'] = $array;
		} else {
             self::$page['content']['error'] = "нет данных";
        }
		self::showXSLT('pages/ratings/EducPlans');
	}
    public static function getInfoEducPlansAjaxAction()
    {
        $params = new stdClass();
        $params->branch = $_POST['branch'];
        $params->year = date('Y');
        $params->skillvalue = $_POST['skillvalue'];

        $response = self::connectWsdl("educplan?wsdl")->getSpecialities($params);
        if (!empty($response-> return)) {
        for ($i = 0; $i < count($response-> return); $i++) {
            $res = count($response-> return) == 1 ? $response-> return : $response-> return [$i];
				$array[$i] = array(
                    "skillId" => $res->specialityId,
                    "speccode" => $res->specialityId,
                    "specialityName" => $res->specialityName
                );
			}
			self::$page['content'] = array();
			self::$page['content']['EducPlans'] = $array;
		}
        else {
        self::$page['content']['error'] = "нет данных";
    }
		self::showXSLT('pages/ratings/EducPlans');
	}

    public static function getEntrantsSubmitDocumentsAjaxAction()
    {
        //branch=1&speccode=1000590&skillid=62&studyform=2&year=2017&financeform=0
        $params = new stdClass();
        $skillvalue = $_POST['skillvalue'];
        $params->branch = $_POST['branch'];
        $params->skillid = $_POST['skillid'];
        $params->speccode = $_POST['speccode'];
        $params->studyform = $_POST['studyform'];
        $params->year = date('Y');
        $params->financeform = $_POST['financeform'];

        $response = self::connectWsdl("entrants?wsdl")->getEntrantsSubmitDocuments($params);

        if (!empty($response-> return)) {
        for ($i = 0; $i < count($response-> return); $i++) {
            $res = count($response-> return) == 1 ? $response-> return : $response-> return [$i];
				$array[$i] = array(
                    "familyname" => $res->familyname,
                    "firstname" => $res->firstname,
                    "secondname" => $res->secondname,
                    "resultScore" => $res->resultScore,
                    "privelege" => $res->privelege,
                    "status" => $res->status,
                    "achivScore" =>  isset($res->achivScore) ? $res->achivScore : "",
                    "condition" => isset($res->condition) ? $res->condition : null,
                );
			}
			self::$page['content'] = array();
			self::$page['content']['EntrantsSubmitDocuments'] = $array;
            self::$page['content']['current_date'] = date('d.m.Y');
		}
		else {
            self::$page['content']['error'] = "нет данных";
        }
		switch ($skillvalue) {
            case '4':
                self::showXSLT('pages/ratings/EntrantsDocumentsCollege');
                break;
            default:
                self::showXSLT('pages/ratings/EntrantsDocuments');
        }
	}

    public static function getExamsListAjaxAction()
    {
        //branch=1&speccode=1000594&skillid=62&studyform=2&year=2017&financeform=0
        $params = new stdClass();
        $params->branch = $_POST['branch'];
        $params->skillid = $_POST['skillid'];
        $params->speccode = $_POST['speccode'];
        $params->studyform = $_POST['studyform'];
        $params->year = date('Y');
        $params->financeform = $_POST['financeform'];

        $response = self::connectWsdl("entrants?wsdl")->getExamsList($params);
        $extExamScoreArray = array();
        if (!empty($response-> return)) {
            for ($i = 0; $i < count($response-> return); $i++) {

                $res = count($response-> return) == 1 ? $response-> return : $response-> return [$i];

                    unset($extExamScoreArray);
                    $extExamScoreArray = !empty($res->extExamScore) ? self::getExamScoreArray($res->extExamScore) : null;
                    $array[$i] = array(
                        "familyname" => $res->familyname,
                        "firstname" => $res->firstname,
                        "secondname" => $res->secondname,
                        "resultScore" => $res->resultScore,
                        "extExamScores" => !empty($extExamScoreArray) ? $extExamScoreArray : array(),
                        "extExamScores2" => !empty($extExamScoreArray) ? $extExamScoreArray : array()
                    );
			}
			self::$page['content'] = array();
			self::$page['content']['ExamsList'] =  $array;
            self::$page['content']['current_date'] = date('d.m.Y');
		}

		else {
            self::$page['content']['error'] = "нет данных";
        }
        self::showXSLT('pages/ratings/ExamsList');
	}

    public static function getOrdersAjaxAction()
    {
        //branch=1&speccode=1000594&skillid=62&studyform=2&year=2017&financeform=0
        //branch=1&speccode=1000590&skillid=62&studyform=2&year=2017&financeform=0
        $params = new stdClass();
        $params->branch = $_POST['branch'];
        $params->skillid = $_POST['skillid'];
        $params->speccode = $_POST['speccode'];
        $params->studyform = $_POST['studyform'];
        $params->year = date('Y');
        $params->financeform = $_POST['financeform'];

        $response = self::connectWsdl("entrants?wsdl")->getOrders($params);
        if (!empty($response-> return)) {
            for ($i = 0; $i < count($response-> return); $i++) {

                $res = count($response-> return) == 1 ? $response-> return : $response-> return [$i];
                $array[$i] = array(
                    "familyname" => $res->familyname,
                    "firstname" => $res->firstname,
                    "secondname" => $res->secondname,
                    "resultScore" => $res->resultScore,
                    "status" => $res->status,
                );
            }
            self::$page['content'] = array();
            self::$page['content']['ExamsList'] =  $array;
            self::$page['content']['current_date'] = date('d.m.Y');
		}

		else {
        self::$page['content']['error'] = "нет данных";
    }
        self::showXSLT('pages/ratings/Orders');
	}

    public static function getEntrantsListAjaxAction()
    {
        $params = new stdClass();

        $financeform = $_POST['financeform'];
        $skillvalue = $_POST['skillvalue'];
        $kvota= $_POST['kvota'];
        //?branch=1&speccode=1000590&skillid=62&studyform=2&year=2017&financeform=0&kvota=0
        //branch=1&speccode=1000424&skillid=51&studyform=2&year=2018&financeform=2&krim=0&kvota=0
        $params->branch = $_POST['branch'];
        $params->skillid = $_POST['skillid'];
        $params->speccode = $_POST['speccode'];
        $params->studyform = $_POST['studyform'];
        $params->year = date('Y');
        $params->financeform = $financeform;
        $params->krim = 0;
        $params->kvota = $kvota;

        $response = self::connectWsdl("entrants?wsdl")->getEntrantsList($params);
        $extExamScoreArray = array();
        $schoolDiscScoreArray = array();
        if (!empty($response-> return)) {
        for ($i = 0; $i < count($response-> return); $i++) {

            $res = count($response-> return) == 1 ? $response-> return : $response-> return [$i];

				unset($extExamScoreArray);
                unset($schoolDiscScoreArray);
				$extExamScoreArray = !empty($res->extExamScore) ? self::getExamScoreArray($res->extExamScore) : null;
				$schoolDiscScoreArray = !empty($res->schoolDiscScore) ? self::getSchoolDiscScoreArray($res->schoolDiscScore) : null;
				$array[$i] = array(
                    "familyname" => $res->familyname,
                    "firstname" => $res->firstname,
                    "secondname" => $res->secondname,
                    "resultScore" => $res->resultScore,
                    "privelege" => $res->privelege,
                    "consentEnrollment" => !empty($res->consentEnrollment) ? $res->consentEnrollment : null,
                    "achivScore" => !empty($res->achivScore) ? $res->achivScore : null,
                    "docOriginal" => !empty($res->docOriginal) ? $res->docOriginal : null,
                    "averagescore" => !empty($res->averagescore) ? $res->averagescore : null,
                    "extExamScores" => !empty($extExamScoreArray) ? $extExamScoreArray : array(),
                    "extExamScores2" => !empty($extExamScoreArray) ? $extExamScoreArray : array(),
                    "schoolDiscScore" => !empty($schoolDiscScoreArray) ? $schoolDiscScoreArray : array(),
                    "schoolDiscScore2" => !empty($schoolDiscScoreArray) ? $schoolDiscScoreArray : array(),
                    "status" => !empty($res->status) ? $res->status : null
                );
			}
			self::$page['content'] = array();
			self::$page['content']['EntrantsList'] =  $array;
            self::$page['content']['current_date'] = date('d.m.Y');
		}
    else {
        self::$page['content']['error'] = Debug::dump($params);
    }

		switch ($skillvalue) {
            case '4':
                switch ($financeform) {
                    case '2':
                        self::showXSLT('pages/ratings/EntrantsListCollegeBudget');
                        break;
                    case '0':
                        self::showXSLT('pages/ratings/EntrantsListCollegePay');
                        break;
                }
                break;
            default:
                self::showXSLT('pages/ratings/EntrantsList');

        }
	}


    private static function getExamScoreArray($extExamScore)
    {
        $extExamScoreArray = array();
        if (isset($extExamScore) && !empty($extExamScore)) {
            for ($ii = 0; $ii < count($extExamScore); $ii++) {
                $res2 = count($extExamScore) == 1 ? $extExamScore : $extExamScore[$ii];
                $extExamScoreArray[$ii] = array(
                    "disciplineName" => $res2->disciplineName,
                    "entranceDisciplineId" => $res2->entranceDisciplineId,
                    "priority" => $res2->priority,
                    "score" => $res2->score
                );
            }
        }
        return $extExamScoreArray;
    }

    private static function getSchoolDiscScoreArray($schoolDiscScore)
    {
        $schoolDiscScoreArray = array();
        if (!empty($schoolDiscScore)) {
            for ($ii = 0; $ii < count($schoolDiscScore); $ii++) {
                $res2 = count($schoolDiscScore) == 1 ? $schoolDiscScore : $schoolDiscScore[$ii];
                $schoolDiscScoreArray[$ii] = array(
                    "disciplineName" => $res2->disciplineName,
                    "entranceDisciplineId" => $res2->entranceDisciplineId,
                    "priority" => $res2->priority,
                    "score" => $res2->score
                );
            }
        }
        return $schoolDiscScoreArray;
    }


    public static function setDepartmentRequest($id)
    {
        $Request = new stdClass();
        $Request->department = "department";
        return $Request;
    }

    public static function setTeacherId($id)
    {
        $Request = new stdClass();
        $Request->teacherid = $id;
        return $Request;
    }

    public static function setLetter($id)
    {
        $Request = new stdClass();
        $Request->familyname = "$id";
        return $Request;
    }

    public static function getInformationRatingAjaxAction(){
        $params = new stdClass();
        $params->branch = $_POST['branch'];
        $skillvalue = $_POST['skillvalue'];
        $params->skillvalue = $skillvalue;
        $params->speccode = $_POST['speccode'];
        $params->year = date('Y');
        $response = self::connectWsdl("entrants?wsdl")->getNumberOfApplications($params);

        if (!empty($response-> return)) {
            for ($i = 0; $i < count($response-> return); $i++) {

                $res = count($response-> return) == 1 ? $response-> return : $response-> return [$i];

				$array[$i] = array(
                    "specName" => !empty($res->specName) ? $res->specName : null,
                    "numberKrimO" => !empty($res->numberKrimO) ? $res->numberKrimO : 0,
                    "numberKrimZ" => !empty($res->numberKrimZ) ? $res->numberKrimZ : 0,
                    "numberKrimV" => !empty($res->numberKrimV) ? $res->numberKrimV : 0,
                    "numberO" => !empty($res->numberO) ? $res->numberO : 0,
                    "numberZ" => !empty($res->numberZ) ? $res->numberZ : 0,
                    "numberV" => !empty($res->numberV) ? $res->numberV : 0,
                    "number9O" => !empty($res->number9O) ? $res->number9O : 0,
                    "number11O" => !empty($res->number11O) ? $res->number11O : 0,
                    "number9Z" => !empty($res->number9Z) ? $res->number9Z : 0,
                    "number11Z" => !empty($res->number11Z) ? $res->number11Z : 0,
                    "numberBudget9O" => !empty($res->numberBudget9O) ? $res->numberBudget9O : 0,
                    "numberBudget11O" => !empty($res->numberBudget11O) ? $res->numberBudget11O : 0
                );
			}
			self::$page['content'] = array();
            self::$page['content']['current_date'] = date('d.m.Y');
			self::$page['content']['InfoRatingList'] =  $array;
		}
        else {
            self::$page['content']['error'] = "нет данных";
        }

		switch ($skillvalue) {
            case 1:
                self::showXSLT('pages/ratings/info/BakalavrInfo');
                break;
            case '2':
                self::$page['content']['FormType'] = 2;
                self::showXSLT('pages/ratings/info/Other');
                break;
            case '3':
                self::$page['content']['FormType'] = 3;
                self::showXSLT('pages/ratings/info/Other');
                break;
            case '4':
                self::showXSLT('pages/ratings/info/KolegeInfo');
                break;
             /*   self::showXSLT('pages/ratings/info/MagistrInfo');
                break;
            case '3':
                self::showXSLT('pages/ratings/info/AspirantInfo');
                break;
            case '4':
                self::showXSLT('pages/ratings/info/KolegeInfo');
                break;*/

        }
    }
    private static function connectWsdl($service)
    {
        $Headers = new SoapHeader('http://idis.ieml.ru/ws/person', 'UserCredentials', array('@samigullin', 'mklP54sd'));
        $client = new SoapClient("https://idis.ieml.ru/Education/services/" . $service, array('encoding' => 'utf-8', "exceptions" => 0));
        $client->__setSoapHeaders($Headers);
        return $client;
    }


}
