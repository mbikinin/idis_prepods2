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



	<xsl:template match="content">
		<a class="gray" href="/">Главная </a>
		<xsl:call-template name="search_block" />
		<p><xsl:value-of select ="message" /></p>
		<p><xsl:value-of select ="error" /></p>

		<ul class="teachers_ul">
		<xsl:apply-templates select="teachers/item" />
		</ul>
		<div class="clear"></div>
	</xsl:template>


	<xsl:template match="teachers/item">
	
			<li>
				<a href="/teachers/view/{id}">
					<xsl:value-of select="familyName" />&#160;
					<xsl:value-of select="firstName" />&#160; 
					<xsl:value-of select="secondName" /> 
				</a><br/>
				<span class="gray">(<xsl:value-of select="position" />)</span>
			</li>
			
	<!-- 
	<div class="abbr_info">
		<span class="abbr_disc"><a href="#">краткая информация</a></span>
	</div> -->
	</xsl:template>
</xsl:stylesheet>
