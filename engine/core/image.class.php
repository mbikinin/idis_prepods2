<?php
/**
 * @package PapipuEngine
 * @author valmon, z-mode
 * @version 0.2
 * Класс для работы с изображениями
 */
class Image {

    /**
     * Инициализация модуля
     * @return null
     */
    public static function initModule () {
        Event::sendEvent('Image','INIT');
        Event::sendEvent('Image','AFTER');
    }
 /**
     * Сохраняет фаил в нужную папку и возвращает название сохранённое файла
     * @param string $fieldName имя поля в пост запросе содержащее фаил
     * @param string $fileName имя файла с котором сохранить, иначе сохраняет по маске.
     * @param string $pathToSave путь сохранения файла
     * @return string
     */
    public static function saveImg ($fieldName,$fileName=null,$pathToSave=null) {
        $pic = null;
        if (is_uploaded_file($_FILES[$fieldName]['tmp_name'])) {
                $pic = $_FILES[$fieldName]['name'];
                $extension = explode(".",$pic);
                $extension = end($extension);
                $datakod = date('U');
                $pic = !empty($fileName) ? $fileName.".".$extension : $datakod.".".$extension;
                if (empty($pathToSave)) {
                    $pathToDir = self::getFileType($extension);
                    $pathToSave = "upload/$pathToDir";
                }
               
            if(!is_dir($pathToSave)) mkdir($pathToSave,0777,true);
            $res = copy($_FILES[$fieldName]['tmp_name'], "$pathToSave/$pic");      
            chmod("$pathToSave/$pic",0777);
            self::resize($pathToSave.$pic, $pathToSave.$pic, 650, 0);  
            
            $pathTmb = $pathToSave."tmb/";
            
            if(!is_dir($pathTmb)) mkdir($pathTmb,0777,true);
            chmod("$pathTmb",0777);
            self::resize($pathToSave.$pic, $pathTmb.'mini_'.$pic, 150, 0);
        }
        return $pic;
    }
      /**
     * Обрезаем изображение
     * @param string $file_input Название файла
     * @param string $file_output Готовый файл
     * @param string $crop Тип обрезки
     * @param bool $percent Процентное соотношение
     * @return mixed
     */
  public static function imagecrop($file_input, $file_output, $crop = 'square', $percent = false) {
	list($w_i, $h_i, $type) = getimagesize($file_input); 
	if (!$w_i || !$h_i) {
		echo 'Невозможно получить длину и ширину изображения';
		return;
        }
        $types = array('','gif','jpeg','png');
        $ext = $types[$type];
        if ($ext) {
    	        $func = 'imagecreatefrom'.$ext;
    	        $img = $func($file_input);
        } else {
    	        echo 'Некорректный формат файла';
		return;
        }
	if ($crop == 'square') {
		$min = $w_i;
		if ($w_i > $h_i) $min = $h_i;
		$w_o = $h_o = $min;
	} else {
		list($x_o, $y_o, $w_o, $h_o) = $crop;
		if ($percent) {
			$w_o *= $w_i / 100;
			$h_o *= $h_i / 100;
			$x_o *= $w_i / 100;
			$y_o *= $h_i / 100;
		}
    	if ($w_o < 0) $w_o += $w_i;
	        $w_o -= $x_o;
	   	if ($h_o < 0) $h_o += $h_i;
		$h_o -= $y_o;
	}
	$img_o = imagecreatetruecolor($w_o, $h_o);
	imagecopy($img_o, $img, 0, 0, $x_o, $y_o, $w_o, $h_o);
	if ($type == 2) {
		return imagejpeg($img_o, $file_output, 100);
	} else {
		$func = 'image'.$ext;
		return $func($img_o,$file_output);
	}
}
   /**
     * Уменьшаем изображение
     * @param string $file_input Название файла
     * @param string $file_output Готовый файл
     * @param string $w ширина
     * @param string $h высота
     * @param bool $percent Процентное соотношение
     * @return mixed
     */
public static function resize($file_input, $file_output, $w_o, $h_o, $percent = false) {
	list($w_i, $h_i, $type) = getimagesize($file_input);
	if (!$w_i || !$h_i) {
		echo 'Невозможно получить длину и ширину изображения';
		return;
        }
        $types = array('','gif','jpeg','png');
        $ext = $types[$type];
        if ($ext) {
    	        $func = 'imagecreatefrom'.$ext;
    	        $img = $func($file_input);
        } else {
    	        echo 'Некорректный формат файла';
		return;
        }
	if ($percent) {
		$w_o *= $w_i / 100;
		$h_o *= $h_i / 100;
	}
	if (!$h_o) $h_o = $w_o/($w_i/$h_i);
	if (!$w_o) $w_o = $h_o/($h_i/$w_i);

	$img_o = imagecreatetruecolor($w_o, $h_o);
	imagecopyresampled($img_o, $img, 0, 0, 0, 0, $w_o, $h_o, $w_i, $h_i);
	if ($type == 2) 
	{
		return imagejpeg($img_o, $file_output, 100);
	} else 
	{
		$func = 'image'.$ext;
		return $func($img_o,$file_output);
	}
}
    /**
     * Изменить размер изображения
     * @param string $file Название файла
     * @param string $width Ширина изображения
     * @param string $height Высота изображения
     * @param bool $proportional Изменить пропорционально
     * @param string $output Место назначения
     * @param bool $delete_original Удалить оригинальный файл
     * @return mixed
     */
    public static function resize_image($image,$width,$height){
$temp=imagecreate($width, $height);
$new_image = ImageCreateFromJpeg($image);

$imagedata = getimagesize($image);
imagecopyresampled($temp, $new_image, 0, 0, 0, 0, $width, $height, $imagedata[0], $imagedata[1]);

imagejpeg($temp, $image,100); //== число 100 указывает на процент качества изображения
} 
    public static function resizeImage($file, $width=0, $height=0, $proportional=false,
            $output = 'file', $delete_original = true) {
        if ( ($height <= 0 && $width <= 0) || !file_exists($file)) {
            return false;
        }

        $info = getimagesize($file);
        $image = '';

        $final_width = 0;
        $final_height = 0;
        list($width_old, $height_old) = $info;
        if ($proportional) {
            if ($width == 0) $factor = $height/$height_old;
            elseif ($height == 0) $factor = $width/$width_old;
            else $factor = min ( $width / $width_old, $height / $height_old);
            $final_width = round ($width_old * $factor);
            $final_height = round ($height_old * $factor);
        } else {
            $final_width = ( $width <= 0 ) ? $width_old : $width;
            $final_height = ( $height <= 0 ) ? $height_old : $height;
        }
        // Обрезаем изображение
        if ($proportional) {
            $factor_y = $height_old/$height;
            $factor_x = $width_old/$width;
            if ($factor_x>$factor_y) {
                $start_x = ($height-$final_height)/2*$factor_x;
                $width_old=$width_old-$start_x*2;
                $start_y = 0;
                $final_height=$height;
            } else {
                $start_y = ($width-$final_width)/2*$factor_y;
                $height_old=$height_old-$start_y*2;
                $start_x = 0;
                $final_width=$width;
            }
        } else {
            $start_x = 0;
            $start_y = 0;
        }

        switch ($info[2]) {
            case IMAGETYPE_GIF:
                $image = imagecreatefromgif($file);
                break;
            case IMAGETYPE_JPEG:
                $image = imagecreatefromjpeg($file);
                break;
            case IMAGETYPE_PNG:
                $image = imagecreatefrompng($file);
                break;
            default:
                return false;
        }

        $image_resized = imagecreatetruecolor( $final_width, $final_height );

        if ( ($info[2] == IMAGETYPE_GIF) || ($info[2] == IMAGETYPE_PNG) ) {
            $trnprt_indx = imagecolortransparent($image);

            if ($trnprt_indx >= 0) {
                $trnprt_color = imagecolorsforindex($image, $trnprt_indx);
                $trnprt_indx = imagecolorallocate($image_resized, $trnprt_color['red'],
                        $trnprt_color['green'], $trnprt_color['blue']);
                imagefill($image_resized, 0, 0, $trnprt_indx);
                imagecolortransparent($image_resized, $trnprt_indx);
            }
            elseif ($info[2] == IMAGETYPE_PNG) {
                imagealphablending($image_resized, false);
                $color = imagecolorallocatealpha($image_resized, 0, 0, 0, 127);
                imagefill($image_resized, 0, 0, $color);
                imagesavealpha($image_resized, true);
            }
        }

        imagecopyresampled($image_resized, $image, 0, 0, $start_x, $start_y, $final_width, $final_height, $width_old, $height_old);

        if ($delete_original) @unlink($file);

        switch ( strtolower($output) ) {
            case 'browser':
                $mime = image_type_to_mime_type($info[2]);
                header("Content-type: $mime");
                $output = NULL;
                break;
            case 'file':
                $output = $file;
                break;
            case 'return':
                return $image_resized;
                break;
            default:
                break;
        }

        switch ($info[2]) {
            case IMAGETYPE_GIF:
                imagegif($image_resized, $output);
                break;
            case IMAGETYPE_JPEG:
                imagejpeg($image_resized, $output);
                break;
            case IMAGETYPE_PNG:
                imagepng($image_resized, $output);
                break;
            default:
                return false;
        }

        return true;
    }

    /**
     * Добавить водный знак
     * @param string $main_img_path Название главного файла
     * @param string $watermark_img_path Название файла водного знака
     * @param integer $alpha_level Прозрачность
     * @param integer $otstup Отступ
     * @param integer $corner Угол
     * @return mixed
     */
    public static function addWatermark($main_img_path, $watermark_img_path, $alpha_level = 100, $otstup = 25, $corner = 0) {
        $main_img_obj = imagecreatefromjpeg($main_img_path);
        $watermark_img_obj = imagecreatefrompng($watermark_img_path);
        $alpha_level /= 100;
        $main_img_obj_w = imagesx($main_img_obj);
        $main_img_obj_h = imagesy($main_img_obj);
        $watermark_img_obj_w = imagesx($watermark_img_obj);
        $watermark_img_obj_h = imagesy($watermark_img_obj);
        switch ($corner) {
            case (1):
                $main_img_obj_min_x = $main_img_obj_w - $otstup - $watermark_img_obj_w;
                $main_img_obj_max_x = $main_img_obj_w - $otstup;
                $main_img_obj_min_y = $otstup;
                $main_img_obj_max_y = $otstup + $watermark_img_obj_h;
                break;
            case (2):
                $main_img_obj_min_x = $main_img_obj_w - $otstup - $watermark_img_obj_w;
                $main_img_obj_max_x = $main_img_obj_w - $otstup;
                $main_img_obj_min_y = $main_img_obj_h - $otstup - $watermark_img_obj_h;
                $main_img_obj_max_y = $main_img_obj_h - $otstup;
                break;
            case (3):
                $main_img_obj_min_x = $otstup;
                $main_img_obj_max_x = $otstup + $watermark_img_obj_w;
                $main_img_obj_min_y = $main_img_obj_h - $otstup - $watermark_img_obj_h;
                $main_img_obj_max_y = $main_img_obj_h - $otstup;
                break;
            case (4):
                $main_img_obj_min_x = ($main_img_obj_w / 2) - ($watermark_img_obj_w / 2);
                $main_img_obj_max_x = ($main_img_obj_w / 2) + ($watermark_img_obj_w / 2);
                $main_img_obj_min_y = ($main_img_obj_h / 2) - ($watermark_img_obj_h / 2);
                $main_img_obj_max_y = ($main_img_obj_h / 2) + ($watermark_img_obj_h / 2);
                break;
            default:
                $main_img_obj_min_x = $otstup;
                $main_img_obj_max_x = $otstup + $watermark_img_obj_w;
                $main_img_obj_min_y = $otstup;
                $main_img_obj_max_y = $otstup + $watermark_img_obj_h;
                break;
        }
        $return_img = imagecreatetruecolor($main_img_obj_w, $main_img_obj_h);
        for ($y = 0; $y < $main_img_obj_h; $y++) {
            for ($x = 0; $x < $main_img_obj_w; $x++) {
                $return_color = NULL;
                $watermark_x = $x - $main_img_obj_min_x;
                $watermark_y = $y - $main_img_obj_min_y;
                $main_rgb = imagecolorsforindex($main_img_obj, imagecolorat($main_img_obj, $x, $y));
                if ($watermark_x >= 0 && $watermark_x < $watermark_img_obj_w && $watermark_y >= 0 && $watermark_y < $watermark_img_obj_h) {
                    $watermark_rbg = imagecolorsforindex($watermark_img_obj, imagecolorat($watermark_img_obj, $watermark_x, $watermark_y));
                    $watermark_alpha = round(((127 - $watermark_rbg['alpha']) / 127), 2);
                    $watermark_alpha = $watermark_alpha * $alpha_level;
                    $avg_red = self::_get_ave_color($main_rgb['red'], $watermark_rbg['red'], $watermark_alpha);
                    $avg_green = self::_get_ave_color($main_rgb['green'], $watermark_rbg['green'], $watermark_alpha);
                    $avg_blue = self::_get_ave_color($main_rgb['blue'], $watermark_rbg['blue'], $watermark_alpha);
                    $return_color = self::_get_image_color($return_img, $avg_red, $avg_green, $avg_blue);
                } else {
                    $return_color = imagecolorat($main_img_obj, $x, $y);
                }
                imagesetpixel($return_img, $x, $y, $return_color);
            }
        }
        imagejpeg($return_img, $main_img_path);
    }
    
    private static function _get_ave_color($color_a, $color_b, $alpha_level) {
        return round((($color_a * (1 - $alpha_level)) + ($color_b * $alpha_level)));
    }

    private static function _get_image_color($im, $r, $g, $b) {
        $c = imagecolorexact($im, $r, $g, $b);
        if ($c != -1) return $c;
        $c = imagecolorallocate($im, $r, $g, $b);
        if ($c != -1) return $c;
        return imagecolorclosest($im, $r, $g, $b);
    }
}