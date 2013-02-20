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
	<a class="gray" href="javascript: history.go(-1)">назад</a>
		<div class="teacher_box">
			<div class="photo">
			<a href="{teacher_foto}" title="" rel="group">
				<img src="{teacher_foto}" alt="" title="{teacher_info/familyName} {teacher_info/firstName} {teacher_info/secondName}" />
			</a>
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
					<!--<tr>
						<td class="b title">Количество публикаций</td><td>
							<xsl:value-of select="count(teacher_pub/item)" /></td>
					</tr>
				--></table>
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
			<div class="publications_list_item hideBlock">
				<div class="sort_by_year">
					<xsl:apply-templates select="years_array/item"/>
					<span class="rounded border pub_year" rel="all">Все</span>
				</div>
				<ul class="teachers_pub_ul">
					<xsl:apply-templates select="teacher_pub/item" />
				</ul>
			</div>
			</xsl:if>
		</div>
	
	<div class="clear"></div>
	<script>
		
	</script>
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
				<span id="active" class="rounded border pub_year" rel="{text()}"><xsl:value-of select="text()" /></span>
			</xsl:when>
			<xsl:otherwise>
				<span class="rounded border pub_year" rel="{text()}"><xsl:value-of select="text()" /></span>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template match="teacher_pub/item">
		<li class="hideBlock">
			<xsl:value-of select="proceedings_name" />
					<xsl:if test="pages != ''"><span class="gray">&#160;(стр.<xsl:value-of select="pages" />)</span></xsl:if>
					<br/>
				<span class="description gray">
					Автор: <xsl:value-of select="author " />,&#160;
					<xsl:value-of select="type" /> &#160;
					<xsl:if test="vak = 'Y'">(ВАК),&#160;</xsl:if>
					<xsl:value-of select="year" /> г.
				</span>
				
		</li>
	</xsl:template>
</xsl:stylesheet>
