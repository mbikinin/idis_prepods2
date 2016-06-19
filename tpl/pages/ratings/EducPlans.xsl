<?xml version="1.0" encoding="UTF-8"?>
<!-- Главная страница -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Код страницы -->


	<xsl:template match="content">
		<select name="speccode" class="speccode">
			<option value="-1">Выберите направление подготовки</option>
			<xsl:apply-templates select="EducPlans/item" />
		</select>
	</xsl:template>

	<xsl:template match="EducPlans/item">
		<option value="{speccode}" rel="{skillId}" class="speccode_{speccode}">
			<xsl:value-of select="specialityName" />
		</option>
	</xsl:template>
</xsl:stylesheet>
