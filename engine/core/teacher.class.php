<?php
/**
 * @package PapipuEngine
 * @author valmon, z-mode
 * @version 0.2
 * Класс для работы со строками
 */
class Teacher {

    public static function getSpecialities(){
$params = new stdClass();
		$params -> branch = Session::get("filial") != NULL ? Session::get("filial") : "1";
        $response = self::connectWsdl()->getSpecialities($params);
        $array = array();
        if (isset($response -> return)) {
            for ($i = 0; $i < count($response-> return); $i++) {
                $res = count($response-> return) == 1 ? $response-> return : $response-> return[$i];
				$array[$i] =
                    array(
                        "id" => $res->id,
                        "name" => $res->name,
                        "OKSO" => $res->OKSO,
                        "specType" => $res->specType
                    );
			}
		}
		return $array;
	}


    private static function connectWsdl(){
        $Headers=new SoapHeader('http://idis.ieml.ru/ws/person',
            'UserCredentials',
            array('@samigullin','mklP54sd'));

        $client = new SoapClient("https://idis.ieml.ru/Education/services/person?wsdl",
            array('encoding'=>'utf-8', "trace"=> 1, "exceptions" => 0));
        $client->__setSoapHeaders($Headers);
        return $client;
    }
}