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
		<div class="teacher_box">
			<div class="photo">
				<img src="{teacher_foto}" alt="" title="{teacher_info/familyName} {teacher_info/firstName} {teacher_info/secondName}" />
			</div>
			<div class="information">
				<table class="prepod_table">
					<tr>
						<td class="b title">Фамилия</td><td><xsl:value-of select="teacher_info/familyName" /></td>
					</tr><tr>
						<td class="b title">Имя</td><td><xsl:value-of select="teacher_info/firstName" /></td>
					</tr><tr>
						<td class="b title">Отчество</td><td><xsl:value-of select="teacher_info/secondName" /></td>
					</tr>
					<tr>
						<td class="b title">Должность</td><td>
							<xsl:value-of select="teacher_info/acadegree" />
							<xsl:value-of select="teacher_info/science_short" />&#160;
							<xsl:value-of select="teacher_info/position" />&#160;
						</td>
					</tr>
					<tr>
						<td class="b title">Кафедра</td><td>
							<xsl:value-of select="teacher_info/department" /></td>
					</tr>
				</table>
			</div>
			<div class="clear"></div>
			<div class="disciplines_list_item">
				<xsl:apply-templates select="teacher_disc/item" />
			</div>
		</div>
	<div class="clear"></div>
		
	</xsl:template>
	<xsl:template match="teacher_disc/item">
		<div class="item">
			<xsl:value-of select="disciplines" />
		</div>
	</xsl:template>
</xsl:stylesheet>
