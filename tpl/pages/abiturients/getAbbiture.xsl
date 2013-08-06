<?xml version="1.0" encoding="UTF-8"?>
<!-- Главная страница -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Код страницы -->


	<xsl:template match="content">
		<ul class="s5">
			<xsl:if test = "error != '' "> 
				<li><xsl:value-of select = "error" />
				</li>
			</xsl:if>
			<li>
				<table>
					<xsl:if test="count(getAbbiture/item) != 0 ">
						<thead><th></th><th colspan="3">Ф.И.О</th><th>Баллы</th><th>Оригиналы</th><th>Статус</th></thead>
						<xsl:apply-templates select="getAbbiture/item" />
					</xsl:if>
				</table>
			</li>
		</ul>
	</xsl:template>

	<xsl:template match="getAbbiture/item">
		<xsl:choose>
			<xsl:when test="status = 'Рекомендован' ">
				<tr class="in_budget"><td class="col"></td>
					<td><xsl:value-of select = "familyname" /></td>
					<td><xsl:value-of select = "firstname" /></td>
					<td><xsl:value-of select = "secondname" /></td>
					<td><xsl:value-of select = "resultScore" /></td>
					<td><xsl:value-of select = "docOriginal" /></td>
					<td><xsl:value-of select = "status" /></td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr><td class="col"></td>
					<td><xsl:value-of select = "familyname" /></td>
					<td><xsl:value-of select = "firstname" /></td>
					<td><xsl:value-of select = "secondname" /></td>
					<td><xsl:value-of select = "resultScore" /></td>
					<td><xsl:value-of select = "docOriginal" /></td>
					<td><xsl:value-of select = "status" /></td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
				<tr>
					<td colspan="5" style=" background-color: #fff; padding-bottom: 10px; cursor: pointer; " >
					<xsl:if test="count(getDiscipline/item) != 0 ">						
						<a href="#" class="ShowDisc">  предметы  </a>
						<table class="format" style="float:right; display: none;">
						
								<thead><th>Дисциплина</th><th>Кол.баллов</th></thead>
								<xsl:apply-templates select="getDiscipline/item" />
						
						</table>
					</xsl:if>
					</td>
				</tr>
	</xsl:template>
	<xsl:template match="getAbbiture/item/getDiscipline/item">	
				<tr>
					<td><xsl:value-of select = "disciplineName" /></td>
					<td><xsl:value-of select = "score" /></td>
				</tr>
	</xsl:template>
</xsl:stylesheet>
