<?php

/**
 * @package PapipuEngine
 * @author valmon, z-mode
 * @version 0.2
 * РљР»Р°СЃСЃ РґР»СЏ СѓРїСЂР°РІР»РµРЅРёСЏ РѕС‚РѕР±СЂР°Р¶РµРЅРёРµРј
 */
class View {

    /**
     * РњР°СЃСЃРёРІ РїРµСЂРµРјРµРЅРЅС‹С… РІРёРґР°
     * @var Array
     */
    private static $_vars = Array();
    /**
     * РњР°СЃСЃРёРІ РїРµСЂРµРјРµРЅРЅС‹С… xslt
     * @var Array
     */
    protected static $page = Array();
    /**
     * РљР»Р°СЃСЃ РґР»СЏ СЂР°Р±РѕС‚С‹ СЃ xml
     * @var XMLWriter
     */
    protected static $writer;

    /**
     * Р�РЅРёС†РёР°Р»РёР·Р°С†РёСЏ РјРѕРґСѓР»СЏ
     * @return null
     */
    public static function initModule() 
	{
        Event::addListener('Error', 'PAGENOTFOUND', 'View', 'showError');
        self::$writer = new XMLWriter();
        if (Config::getValue('site', 'disabled')) 
		{
            if (empty($_SESSION['admin']['access']) || $_SESSION['admin']['access'] != 'superadmin') {
                self::showPage('error', 'disabled');
                die();
            }
        }
    }

    /**
     * Р�РЅРёС†РёР°Р»РёР·Р°С†РёСЏ РѕС‚РѕР±СЂР°Р¶РµРЅРёСЏ
     * @return null
     */
    public static function initView() {
        //РџРµСЂРµРјРµРЅРЅС‹Рµ СЂРѕСѓС‚РµСЂР°
        self::$page['route'] = Array(
            'page' => Router::getRouteParam('page'),
            'action' => Router::getRouteParam('action'),
            'id' => Router::getRouteParam('id')
        );
        //self::$page['site'] = Config::getSection('site');
        self::$page['c_uri'] = Router::$uri;
        $user_id = Session::get('user_id');
		//self::$page['message'] = DB::getCount('user_message',"id_adress = '$user_id ' and is_open = '0' and is_delete_adress = '0' ");
		//РќРѕРІРѕСЃС‚Рё
		//$news = DB::FetchAll("SELECT title, uri, anounce, DATE_FORMAT( `date` , '%d' ) AS date_day, DATE_FORMAT( `date` , '%m' ) AS month, DATE_FORMAT( `date` , '%Y' ) AS year FROM news ORDER BY `date` DESC LIMIT 0,3") or die(View::showError());
       // foreach ($news as & $item) $item['month'] = String::toMonth($item['month']);
       // self::$page['newsblock'] = $news;
        self::$page['alphabet'] = array('А','Б','В','Г','Д','Е','Ж','З',
    	'И','К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Щ','Ш','Э','Ю','Я');
       //self::$page['header']['menu'] = MenuPlugin::getMenu();
      // self::$page['submenu'] = MD_Catalog::getMenu();    		
       // self::$page['footer'] = '';
       // Debug::dump(self::$page['banner']);
      // self::$page['infoSite'] = DB::getRecord('admin_info','id=1');
        self::$page['date_today']['year'] = String::getDate();
        self::$page['date_today']['month'] = String::toMonth(date('m'));
        self::$page['date_today']['month_number'] = date('m');
        self::$page['date_today']['day'] = date('d');
        self::$page['date_today']['week'] = String::toWeek(date('w'));
        self::$page['date_tomorrow']['month'] = String::toMonth(date('m', time() + 60 * 60 * 24));
        self::$page['date_tomorrow']['day'] = date('d', time() + 60 * 60 * 24);
        self::$page['date_tomorrow']['week'] = String::toWeek(date('w', time() + 60 * 60 * 24));
    }



    

    /**
     * РћС‚РѕР±СЂР°Р¶РµРЅРёРµ СЃС‚СЂР°РЅРёС†С‹
     * @return bool
     */
    public static function showPage($page=null, $action=null, $id=null) {
        if (empty($page))
            $page = Router::getRouteParam('page');
        if (empty($action))
            $action = Router::getRouteParam('action');
        if (empty($id))
            $id = Router::getRouteParam('id');
        if (preg_match("/^[[:lower:]]+$/", $page)) {
            if (file_exists(Config::getValue('path', 'pages') . $page . '.php')) {
                include_once (Config::getValue('path', 'pages') . $page . '.php');

                $pageClass = $page . '_Page';
				if(method_exists($pageClass, $action . 'Action'))
                		self::initView();

                if (file_exists(Config::getValue('path', 'pages') . 'app.php')) {
                    include_once (Config::getValue('path', 'pages') . 'app.php');
                    if (method_exists('App', 'init'))
                        call_user_func(array('App', 'init'), $pageClass);
                }
                if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) &&
                        $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
                    if (method_exists($pageClass, $action . 'AjaxAction'))
                        call_user_func(array($pageClass, $action . 'AjaxAction'), $id);
                    return true;
                } elseif (method_exists($pageClass, $action . 'Action')) {
                    if (method_exists($pageClass, 'initController')) {
                        call_user_func(array($pageClass, 'initController'), $action);
                    }
                    call_user_func(array($pageClass, $action . 'Action'), $id);
                    return true;
                } elseif (method_exists($pageClass, Router::getRouteConfig('action', $page) . 'Action') or
                        method_exists($pageClass, Router::getRouteConfig('action', $page) . 'AjaxAction')) {
                    $id = $action;
                    $action = Router::getRouteConfig('action', $page);
                    self::showPage($page, $action, $id);
                    return true;
                }
            } elseif (file_exists(Config::getValue('path', 'pages') . Config::getValue('route', 'default_page') . '.php')) {
                $default = Config::getValue('route', 'default_page');
                include_once (Config::getValue('path', 'pages') . $default . '.php');
                $id = $action;
                $action = $page;
                $page = $default;
                if (method_exists($page . '_Page', $action . 'AjaxAction') or
                        method_exists($page . '_Page', $action . 'Action')) {
                    self::showPage($page, $action, $id);
                    return true;
                }
            }
        }
        Error::setError('PAGENOTFOUND', $page);
        return false;
    }

    /**
     * РћС‚РѕР±СЂР°Р¶РµРЅРёРµ РѕС€РёР±РєРё
     * @return null
     */
    public static function showError() {
        header("HTTP/1.0 404 Not Found");
        self::showPage('error', 'index');
        die();
    }

    /**
     * РџРµСЂРµРІРѕРґ РјР°СЃСЃРёРІР° РІ XML
     * @param array $array РјР°СЃСЃРёРІ
     * @return string
     */
    public static function arrayToXml($data) {
        self::$writer->openMemory();
        self::$writer->startDocument('1.0', 'UTF-8');
        self::$writer->startElement('root');
        if (is_array($data)) {
            self::getXML($data);
        }
        self::$writer->endElement();
        return self::$writer->outputMemory();
    }

    private static function getXML($data) {
        foreach ($data as $key => $val) {
            if (is_numeric($key)) {
                $key = 'item';
            }
            if (is_array($val)) {
                self::$writer->startElement($key);
                self::getXML($val);
                self::$writer->endElement();
            } else {
                self::$writer->writeElement($key, $val);
            }
        }
    }

    /**
     * РџРѕР»СѓС‡РµРЅРёРµ РєРѕРЅРµС‡РЅРѕРіРѕ html
     * @param string $xml СЃС‚СЂРѕРєР° XML
     * @param string $tpl РЅР°Р·РІР°РЅРёРµ С„Р°Р№Р»Р° XSLT
     * @return string
     */
    public static function getXSLT($array, $tpl) {

        $doc = new DOMDocument();
        $xml = self::arrayToXml($array);
        $doc->loadXML($xml);
        $xsl = new DomDocument();
        $xsl->load(Config::getValue('path', 'tpl') . $tpl . '.xsl');
			ini_set('display_errors','On'); 
        $proc = new XsltProcessor();
        $xsl = $proc->importStylesheet($xsl);
        return $proc->transformToXML($doc);
    }

    /**
     * Р’С‹РІРѕРґ РєРѕРЅРµС‡РЅРѕРіРѕ html
     * @param string $tpl РЅР°Р·РІР°РЅРёРµ С„Р°Р№Р»Р° XSLT
     * @return null
     */
    public static function showXSLT($tpl) {
        echo self::getXSLT(self::$page, $tpl);
    }

    /**
     * РџРѕР»СѓС‡РёС‚СЊ РїРµСЂРµРјРµРЅРЅСѓСЋ
     * @param string $name РЅР°Р·РІР°РЅРёРµ РїРµСЂРµРјРµРЅРЅРѕР№
     * @return var
     */
    public static function get($name) {
        if (!empty(self::$_vars[$name]))
            return self::$_vars[$name];
        else
            return NULL;
    }

    /**
     * Р—Р°РґР°С‚СЊ РїРµСЂРµРјРµРЅРЅСѓСЋ
     * @param string $name РЅР°Р·РІР°РЅРёРµ РїРµСЂРµРјРµРЅРЅРѕР№
     * @param string $value Р·РЅР°С‡РµРЅРёРµ РїРµСЂРµРјРµРЅРЅРѕР№
     * @return null
     */
    public static function assign($name, $value) {
        self::$_vars[$name] = $value;
    }
	

    /**
     * РћС‚РѕР±СЂР°Р·РёС‚СЊ СЃС‚СЂР°РЅРёС†Сѓ
     * @param string $template РЅР°Р·РІР°РЅРёРµ РјР°РєРµС‚Р°
     * @return null
     */
    public static function display($template = 'layout.tpl') {
        include_once(Config::getValue('path', 'layouts') . $template . '.php');
    }

}