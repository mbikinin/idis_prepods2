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
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

		<script>$(function() {
			$( "#tabs" ).tabs({
			collapsible: true
			});
			});
		</script>
		<a class="gray" href="/">Главная </a> ->
		<a class="gray" href="/teachers/index?id={substring(teacher_info/familyName,1,1)}">Алфавитный указатель</a> ->
		<strong class="gray" ><xsl:value-of select="teacher_info/familyName" />&#160;<xsl:value-of select="teacher_info/firstName" />&#160;<xsl:value-of select="teacher_info/secondName" />
		</strong>
		
		
		<div class="teacher_box">
			<div class="photo">
				<a href="{teacher_foto}" title="" rel="group">
					<img src="{teacher_foto}" alt="" title="{teacher_info/familyName} {teacher_info/firstName} {teacher_info/secondName}" />
				</a>
			</div>
			<div class="information">
				<table class="prepod_table">
					<tr>
						<td class="b title">Фамилия</td>
						<td>
							<xsl:value-of select="teacher_info/familyName" />
						</td>
					</tr>
					<tr>
						<td class="b title">Имя</td>
						<td>
							<xsl:value-of select="teacher_info/firstName" />
						</td>
					</tr>
					<tr>
						<td class="b title">Отчество</td>
						<td>
							<xsl:value-of select="teacher_info/secondName" />
						</td>
					</tr>
					<tr>
						<td class="b title">Должность</td>
						<td>
							<xsl:value-of select="teacher_info/acadegree" />
							<xsl:value-of select="teacher_info/science_short" />
							&#160;
							<xsl:value-of select="teacher_info/position" />
							&#160;
						</td>
					</tr>
					<tr>
						<td class="b title">Кафедра</td>
						<td>
							<xsl:value-of select="teacher_info/department" />
						</td>
					</tr>
					<tr>
						<td class="b title">Образование</td>
						<td>
							<xsl:value-of select="teacher_info/teacherEducation" />
						</td>
					</tr>
					<tr>
						<td class="b title">Квалификация</td>
						<td>
							<xsl:value-of select="teacher_info/qualification" />
						</td>
					</tr>
					<!--<tr>
					<td class="b title">Количество публикаций</td><td>
					<xsl:value-of select="count(teacher_pub/item)" /></td>
					</tr>
					-->
				</table>
			</div>
			<div class="clear"></div>
			<div class="padding"></div>
			<xsl:if test="count(teacher_disc/item)!=0">
				<a href="#" class="disciplines_href">Преподаваемые дисциплины</a>
				<div class="disciplines_list_item hideBlock">
					<ul class="teachers_disc_ul">
						<xsl:apply-templates select="teacher_disc/item" />
					</ul>
				</div>
			</xsl:if>
			<div class="clear"></div>
			<xsl:if test="count(teacher_pub/item)!=0">
				<a href="#" class="publications_href">Публикации и статьи</a>
				<div id="tabs" class="hideBlock">
					<ul>
					<xsl:apply-templates select="years_array/item"/>
					</ul>
					<xsl:apply-templates select="teacher_pub/item" />
				</div>
			</xsl:if>
		</div>

		<div class="clear"></div>

	</xsl:template>
	<xsl:template match="teacher_disc/item">
		<li>
			<xsl:value-of select="disciplines" />
		</li>
	</xsl:template>
	<xsl:template match="years_array/item">
		<xsl:if test="5 > position()">
			<xsl:choose>
				<xsl:when test="position() = 1">
					<li>
						<a class="border rounded" href="#tabs-{text()}"><xsl:value-of select="text()" /></a>
					</li>
				</xsl:when>
				<xsl:otherwise>
					<li>
						<a class="border rounded" href="#tabs-{text()}"><xsl:value-of select="text()" /></a>
					</li>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template match="teacher_pub/item">
		<div id="tabs-{year}">
		
			<xsl:value-of select="proceedings_name" />
			<xsl:if test="pages != ''">
				<span class="gray">
					&#160;(стр.
					<xsl:value-of select="pages" />
					)
				</span>
			</xsl:if>
			<br/>
			<span class="description gray">
				Автор:
				<xsl:value-of select="author " />
				,&#160;
				<xsl:value-of select="type" />
				&#160;
				<xsl:if test="vak = 'Y'">(ВАК),&#160;</xsl:if>
				<xsl:value-of select="year" />
				г.
			</span>

		</div>
	</xsl:template>
</xsl:stylesheet>
