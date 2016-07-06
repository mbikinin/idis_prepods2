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
    }

    /*
     * Главная страница сайта
     */

    public static function indexAction($id)
    {
        Session::set("filial", Router::getRouteParam('id'));
        self::$page['content'] = "";
        self::$page['content']['filials'] = self::getFilials();
        self::showXSLT('pages/ratings/index');
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
        $params->level = $_POST['level'];
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


    public static function getEntrantsSubmitDocumentsAjaxAction()
    {
        $params = new stdClass();
        $skillvalue = $_POST['skillvalue'];
        $params->branch = $_POST['branch'];
        $params->skillid = $_POST['skillid'];
        $params->speccode = $_POST['speccode'];
        $params->studyform = $_POST['studyform'];
        $params->year = date('Y');
        $params->financeform = $_POST['financeform'];
        $params->krim = $_POST['krim'];
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


    public static function getEntrantsListAjaxAction()
    {
        $params = new stdClass();

        $financeform = $_POST['financeform'];
        $skillvalue = $_POST['skillvalue'];

        $params->branch = $_POST['branch'];
        $params->skillid = $_POST['skillid'];
        $params->speccode = $_POST['speccode'];
        $params->studyform = $_POST['studyform'];
        $params->year = date('Y');
        $params->financeform = $financeform;
        $params->krim = $_POST['krim'];
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
                    "achivScore" => $res->achivScore,
                    "docOriginal" => !empty($res->docOriginal) ? $res->docOriginal : null,
                    "averagescore" => $res->averagescore,
                    "extExamScores" => !empty($extExamScoreArray) ? $extExamScoreArray : array(),
                    "schoolDiscScore" => !empty($schoolDiscScoreArray) ? $schoolDiscScoreArray : array()
                );
			}
			self::$page['content'] = array();
			self::$page['content']['EntrantsList'] = $array;
            self::$page['content']['current_date'] = date('d.m.Y');
		}
    else {
        self::$page['content']['error'] = "нет данных";
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
        if (isset($schoolDiscScore) && !empty($schoolDiscScore)) {
            for ($ii = 0; $ii < count($schoolDiscScoreArray); $ii++) {
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

    private static function connectWsdl($service)
    {
        $Headers = new SoapHeader('http://idis.ieml.ru/ws/person', 'UserCredentials', array('@samigullin', 'mklP54sd'));
        $client = new SoapClient("https://idis.ieml.ru/Education/services/" . $service, array('encoding' => 'utf-8', "exceptions" => 0));
        $client->__setSoapHeaders($Headers);
        return $client;
    }


}
