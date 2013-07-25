<?xml version="1.0" encoding="UTF-8"?>
<!-- Главная страница -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Импорт макета -->
	<xsl:include href="../../layouts/layout.xsl" />
	<xsl:template match="/">
		<xsl:apply-templates select="root" />
	</xsl:template>

	<!-- Код страницы -->


	<xsl:template match="content">
	<h1>Поиск преподавателей</h1>
		<xsl:call-template name="search_block" />
			
		<!-- <ul class="parrent"><xsl:apply-templates select="facultets/item" /> </ul>-->
			
		
	</xsl:template>
	<xsl:template match="alphabet/item">
		<a href="/teachers/index?id={text()}" ><xsl:value-of select="text()" /></a>
	</xsl:template>
	
</xsl:stylesheet>
