<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />


	<xsl:template name="search_block">
		<table class="search_teacher">
		<tr>
			<td>Cписок направлений</td>
			<td>
				<!-- 			<div class="alphbet">
				<xsl:apply-templates select="//alphabet/item" /> </div>-->
			<ul class="specialities_ul">
				<xsl:apply-templates select="//specialities/item" />
			</ul>
			</td>
		</tr>
		<!--<tr>
			<td><span>Поиск по фамилии</span></td>
			<td>
				<div class="search_box">
					<form method="get" action="/teachers/index/">
						<input name="id" type="text" class="find_teacher" /> <br/>
						<span class="lable">Пример: Байбакова</span> <br/>
						<input type="submit" class="search_button" value="Найти"/>
					</form>
				</div>
			</td>
		</tr>-->
		</table>

		</xsl:template>
		<xsl:template match="//alphabet/item">
			<a href="/teachers/index?id={text()}" ><xsl:value-of select="text()" /></a>
		</xsl:template>

		<xsl:template match="//specialities/item">
			<li>
				<a href="https://idis.ieml.ru/Education/public/PedagogPdfReport?branch=1&amp;year=2016&amp;speccode={id}">
					<img src="/public/images/ico_pdf.gif"/>
					 <xsl:value-of select="name" />					
				</a><br/>
			</li>
		</xsl:template>
</xsl:stylesheet>
