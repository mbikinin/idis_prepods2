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
		<div style="margin-left: -50px;">
			<p><xsl:value-of select ="message" /></p>
				<ul class="s1">
					<li class="instityte" rel="1" >
						
							<a href="#" class="getStages">
								<h4><span class="pluse">+ </span>Институт</h4>
							</a>
							<div class="resultStages"></div>					
					</li>
						
					<li class="instityte" rel="0" >
							<a href="#" class="getStages">
								<h4><span class="pluse">+ </span>Колледж</h4>
							</a>
							<div class="resultStages"></div>					
					</li>
				</ul>
			<!-- <ul class="teachers_ul">
				<xsl:apply-templates select="teachers/item" />
			</ul> -->
			<div class="clear"></div>
		</div>
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
