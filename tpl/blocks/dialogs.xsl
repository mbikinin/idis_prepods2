<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

		
	<xsl:template name="search_block">
		<form method="get" action="/teachers/index/">
		<table class="search_teacher">
		<tr><td></td><td><div class="alphbet">
			<xsl:apply-templates select="//alphabet/item" />
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
		</xsl:template>
		<xsl:template match="//alphabet/item">
		<a href="/teachers/index?id={text()}" ><xsl:value-of select="text()" /></a>
		</xsl:template>
</xsl:stylesheet>