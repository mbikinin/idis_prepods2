<?php

/**
 * @package PapipuEngine
 * @author z-mode
 * @version 0.1
 * РџР»Р°РіРёРЅ РґР»СЏ СЂР°Р±РѕС‚С‹ СЃ РјРµРЅСЋ
 */
class MenuPlugin {

    /**
     * РњР°СЃСЃРёРІ РіРґРµ С…СЂР°РЅРёС‚СЃСЏ РІСЃС‘ РјРµРЅСЋ
     * @var String
     */
    private static $_menu = null;

    /**
     * Р�РЅРёС†РёР°Р»РёР·Р°С†РёСЏ РїР»Р°РіРёРЅР°
     * @return null
     */
    public static function initPlugin() {
      //  self::$_menu = DB::fetchAll('SELECT id,title_on_menu AS title,uri,link,parent_id FROM structure WHERE on_menu = 1 ORDER BY `sort` ASC');
        
    }

    public static function getMenu() {
        $html = "<ul class='dropMenu'>";
        foreach (self::$_menu as $i => $v) {
            if ($v['parent_id'] == 0) {
                $href = !empty($v['link']) ? $v['link'] : "/page/view/" . $v['uri'];
                $current_class = self::isCurrent('/'.Router::$uri, $href) ? "class='current'" : null;
                $html .= "<li $current_class>";
                $html .= "<a href='$href' title='$v[title]'>$v[title]</a>";
                $html .= self::getChilds($v['id'], self::$_menu);
                $html .= !empty($current_class) ? "<div class='bg_current'><div class='left'></div><div class='center'></div><div class='right'></div></div></li>": null;
            }
        }
        $html .="</ul>";
        return $html;

    }


    private static function getChilds($parent_id,$menu){

    	$html_li = "";
        foreach ($menu as $i => $v) {
            $i++;
            if ($v['parent_id'] == $parent_id ) {
                $href = !empty($v['link']) ? $v['link'] : "/page/view/".$v['uri'];
                $html_li .= "<li><a href='$href' title='$v[title]'>$v[title]</a></li>";
            }
        }

        if (!empty($html_li)) {
            return '<ul>'.$html_li.'</ul>';
        }
    }


    public static function getSubMenu() {

        $uri = Router::$uri;
        if(strpos($uri,'page') !== false) {
            $page_uri = Router::getRouteIndex(3);
            $parent_id = DB::getValue('structure','parent_id',"uri='$page_uri'");
            if ($parent_id == 0) $parent_id = DB::getValue('structure','id',"uri='$page_uri'");
            return DB::fetchAll("SELECT title_on_menu AS title,uri,link FROM structure 
            WHERE parent_id = '$parent_id' AND on_menu = 1 ORDER BY `sort` ASC");
        }
    }

    
    
    public static function isCurrent ($uri,$href) {
    	$page_uri = str_replace('/page/view/', '', $uri);
    	$currentParrentId = DB::getValue('structure','parent_id',"uri='$page_uri' OR link='$page_uri'");
    	$parent_uri = DB::getValue('structure','uri',"id='$currentParrentId'");
    	    	Debug::addParam($parent_uri);
                if ($href == $uri || $href == '/page/view/'.$parent_uri || $href == $parent_uri || ("/".(Router::getRouteParam('page'))) == "$href")
                    return true;
                else
                    return false;
    	
    }

}
