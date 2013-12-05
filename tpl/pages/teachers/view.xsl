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
					<xsl:if test="teacher_info/totalExperienceDate != '' " >					
						<tr>
							<td colspan="2">Общий стаж работы с <xsl:value-of select="teacher_info/totalExperienceDate" /></td>
						</tr>
					</xsl:if>
					<xsl:if test="teacher_info/teachingExperienceDate != '' " >
					<tr>
						<td colspan="2">Общий педагогический стаж работы с <xsl:value-of select="teacher_info/teachingExperienceDate" /></td>
					</tr>
					</xsl:if>
					<!-- <tr>
						<td class="b title">Образование</td>
						<td>
							<xsl:value-of select="teacher_info/academy" />
							
						</td>
					</tr>
					
					<tr>
						<td class="b title">Квалификация</td>
						<td>
							<xsl:value-of select="teacher_info/qualification" />
						</td>
					</tr>
					<tr>
                                                <td class="b title">Специальность</td>
                                                <td>
                                                        <xsl:value-of select="teacher_info/speciality"/>
                                                </td>
                                        </tr>	 -->				
<!--<tr>
					<td class="b title">Количество публикаций</td><td>
					<xsl:value-of select="count(teacher_pub/item)" /></td>
					</tr>
					-->
				</table>
			</div>
			<div class="clear"></div>
			<div class="padding"></div>
			<span class="title_education">Образование</span>
			<div class="clear"></div>
			<div class="education_box">
				<div class="titles">
					 <div class="item">
					 	<strong>ВУЗ</strong>
					 </div>
					 <div class="item">
					 	<strong>Квалификация</strong>
					 </div>
					 <div class="item">
					 	<strong>Специальность</strong>
					 </div>
				</div>
				<div class="clear"></div>
				<div class="academies">
						<xsl:for-each select="teacher_info/academy/item">
						    <div class="item">
						      	<div class="academy"><xsl:value-of select="position()"/>. <xsl:value-of select="academy"/></div>
						    </div>
					    </xsl:for-each>
				</div>
				<div class="qualifications">
						<xsl:for-each select="teacher_info/qualification/item">
						    <div class="item">
						      	<div class="qualification"><xsl:value-of select="qualification"/></div>
						    </div>
					    </xsl:for-each>
				</div>
				<div class="specialities">
						<xsl:for-each select="teacher_info/speciality/item">
						    <div class="item">
						      	<div class="speciality"><xsl:value-of select="speciality"/></div>
						    </div>
					    </xsl:for-each>
				</div>
			</div>
			<div class="clear"></div>
			<div class="padding"></div>
			<xsl:if test="count(teacher_info/teacherTraining/item)!=0">
				<a href="#" class="disciplines_href">Повышение квалификации (<xsl:value-of select="count(teacher_info/teacherTraining/item)" />)</a>
				<div class="disciplines_list_item hideBlock">
					<ul class="teachers_disc_ul">
						<xsl:for-each select="teacher_info/teacherTraining/item">
						    <div class="item">
						      	<li>
						      		<xsl:value-of select="year"/>г. <br/>
						      		<xsl:value-of select="place"/>&#160;
						      		<xsl:value-of select="place"/>&#160;
						      		<br/>
						      		по программе: 
						      		<strong>
						      			<xsl:value-of select="courseName"/>&#160;
						      		</strong>
						      		<xsl:if test="hours!=''">
						      		(<i><xsl:value-of select="hours"/> ч.</i>)
						      		</xsl:if>
						      	</li>
						      	
						    </div>
					    </xsl:for-each>
					</ul>
				</div>
			</xsl:if>
			<div class="clear"></div>
			<xsl:if test="count(teacher_disc/item)!=0">
				<a href="#" class="disciplines_href">Преподаваемые дисциплины (<xsl:value-of select="count(teacher_disc/item)" />)</a>
				<div class="disciplines_list_item hideBlock">
					<ul class="teachers_disc_ul">
						<xsl:apply-templates select="teacher_disc/item" />
					</ul>
				</div>
			</xsl:if>
			<div class="clear"></div>
			<xsl:if test="count(teacher_pub/item)!=0">
				<a href="#" class="publications_href">Публикации и статьи (<xsl:value-of select="count(teacher_pub/item)" />)</a>
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

					<li>
						<a class="border rounded" href="#tabs-{text()}"><xsl:value-of select="text()" /></a>
					</li>

	</xsl:template>
	<xsl:template match="teacher_pub/item">
		<div id="tabs-{year}">
		
			<xsl:value-of select="proceedings_name" disable-output-escaping="yes"/>
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
