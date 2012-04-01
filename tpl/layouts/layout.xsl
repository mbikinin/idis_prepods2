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
			<link rel="stylesheet" type="text/css" href="/public/css/inner.css" />

			<xsl:comment><![CDATA[[if IE]>
                <link href="/public/css/ie.css" rel="stylesheet" type="text/css" />
                <![endif]]]>
			</xsl:comment>
		</head>
	</xsl:template>
</xsl:stylesheet>

