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
		<form method="get" action="/teachers/index/">
		<table class="search_teacher">
		<tr><td></td><td><div class="alphbet">
			<xsl:apply-templates select="alphabet/item" />
		</div></td></tr>
		<tr>
		<td><span class="title">Поиск по фамилии</span></td>
		<td><input name="id" type="text" class="find_teacher" /> <!--<a class="find_teacher_extended" href="/#">расширенный поиск</a>--></td>
		</tr>
		<tr>
			<td></td><td ><span class="lable">Пример: Байбакова</span></td>
		</tr>
		<tr><td></td><td><input type="submit" class="search_button" value="Найти"/></td></tr>
		</table>
		</form>
			
		<!-- <ul class="parrent"><xsl:apply-templates select="facultets/item" /> </ul>-->
			
		
	</xsl:template>
	<xsl:template match="alphabet/item">
		<a href="/teachers/index?id={text()}" ><xsl:value-of select="text()" /></a>
	</xsl:template>
	<xsl:template match="facultets/item">
		<xsl:if test="count(chairs/item) > 0" >
			<a href="#" class="show_child"><li>
			<xsl:choose>
			<xsl:when test="id=24">
				<xsl:attribute name="class">psychologic</xsl:attribute>
			</xsl:when>
			<xsl:when test="id=25">
				<xsl:attribute name="class">menegment</xsl:attribute>
			</xsl:when>
			<xsl:when test="id=363">
				<xsl:attribute name="class">food</xsl:attribute>
			</xsl:when>
			<xsl:when test="id=6">
				<xsl:attribute name="class">economy</xsl:attribute>
			</xsl:when>
			<xsl:when test="id=4">
				<xsl:attribute name="class">low</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="class">other</xsl:attribute>
			</xsl:otherwise>
			</xsl:choose>
			<div class="icon"></div>
			<xsl:value-of select="fullName" />
				<ul class="chaild hideBlock">
					<xsl:apply-templates select="chairs/item" />
				</ul>
			</li>
			</a>
		</xsl:if>
	</xsl:template>
	<xsl:template match="chairs/item">
			<li><a href="/teachers/index/{id}">
				<xsl:value-of select="fullName" /></a>
			</li>
	</xsl:template>
</xsl:stylesheet>
