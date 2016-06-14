<?xml version="1.0" encoding="UTF-8"?>
<!-- Главная страница -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Код страницы -->


	<xsl:template match="content">
		<ul class="s3">
			<xsl:if test = "error != '' "> 
				<li><xsl:value-of select = "error" />
				</li>
			</xsl:if>
			
			<xsl:apply-templates select="StudyForms/item" />
		</ul>
	</xsl:template>

	<xsl:template match="StudyForms/item">	
			<li class="studyForm" rel="{id}">
				<a href="#" class="getEducPlans">
					<span class="pluse">+ </span> <xsl:value-of select = "name" />
				</a>
				<div class="resultEducPlans"></div>
			</li>
	</xsl:template>
</xsl:stylesheet>
