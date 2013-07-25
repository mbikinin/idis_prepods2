<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />
	<xsl:include href="../blocks/dialogs.xsl" />
	
	<xsl:template match="root">
	<xsl:call-template name="head" />
		<div id="conteiner">				
			<xsl:apply-templates select="content" />
			<div class="empty"></div>
		</div>		
	</xsl:template>
		<xsl:template name="head">
		<head>
			
			<script type="text/javascript" src="/public/js/libs/libs.js"></script>
			<script type="text/javascript" src="/public/js/main.js"></script>
			<script type="text/javascript" src="/public/js/system.js"></script>
			<link rel="stylesheet" type="text/css" href="/public/css/style.css" />
			<link rel="stylesheet" type="text/css" href="/public/css/bootstrap.css" />

			<link rel="stylesheet" type="text/css" href="/public/css/inner.css" />
			<script type="text/javascript" src="/public/js/libs/jquery.fancybox-1.3.4.pack.js"></script>
			<script type="text/javascript">
			$(document).ready(function() {
				$("a.imgZoom").fancybox({						
					"padding" : 20, // отступ контента от краев окна
					"imageScale" : false, // Принимает значение true - контент(изображения) масштабируется по размеру окна, или false - окно вытягивается по размеру контента. По умолчанию - TRUE
					"zoomOpacity" : false,	// изменение прозрачности контента во время анимации (по умолчанию false)
					"zoomSpeedIn" : 1000,	// скорость анимации в мс при увеличении фото (по умолчанию 0)
					"zoomSpeedOut" : 1000,	// скорость анимации в мс при уменьшении фото (по умолчанию 0)
					"zoomSpeedChange" : 1000, // скорость анимации в мс при смене фото (по умолчанию 0)
					"frameWidth" : 700,	 // ширина окна, px (425px - по умолчанию)
					"frameHeight" : 600, // высота окна, px(355px - по умолчанию)
					"overlayShow" : true, // если true затеняят страницу под всплывающим окном. (по умолчанию true). Цвет задается в jquery.fancybox.css - div#fancy_overlay 
					"overlayOpacity" : 0.8,	 // Прозрачность затенения 	(0.3 по умолчанию)
					"hideOnContentClick" :false, // Если TRUE  закрывает окно по клику по любой его точке (кроме элементов навигации). Поумолчанию TRUE		
					"centerOnScroll" : false // Если TRUE окно центрируется на экране, когда пользователь прокручивает страницу		
				});
			});
			</script>
			<link rel="stylesheet" type="text/css" href="/public/css/jquery.fancybox-1.3.4.css" media="screen" />
			<xsl:comment><![CDATA[[if IE]>
                <link href="/public/css/ie.css" rel="stylesheet" type="text/css" />
                <![endif]]]>
			</xsl:comment>
		</head>
	</xsl:template>
</xsl:stylesheet>

