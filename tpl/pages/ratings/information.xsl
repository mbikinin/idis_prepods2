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
		<div class="rating_box">
			<form name="get_rating" method="post">
				<p><xsl:value-of select ="message" /></p>
				<select  name="branch" class="branch inf_reset_skill" required="required">
					<option value="-1">Город поступления</option>
					<option value = "1">Казань</option>
					<option value = "181">Набережные Челны</option>
					<option value = "224">Нижнекамск</option>
					<option value = "266">Чистополь</option>
					<option value = "323">Зеленодольск</option>
					<option value = "343">Альметьевск</option>
					<option value = "373">Бугульма</option>
				</select>
				<select name="skillvalue" class="skillvalue reset_educplans getInfoEducPlans" required="required">
					<option value="-1">Выберите уровень образования</option>
					<option value="1">Бакалавриат</option>
					<option value="2">Магистратура</option>
					<option value="3">Аспирантура</option>
					<option value="4">Колледж</option>
				</select>
				<div class="resultEducPlans">
					<select name="speccode" class="speccode" required="required">
						<option value="-1">Выберите направление подготовки</option>
					</select>
				</div>
				<br/>
				<div class="progress_box"></div>
				<br/>
				<input type="button" class="getInfoRatingList" value="Получить информацию" />
				<br/><br/>
				<div class="resultList"></div>
			</form>
		</div>
	</xsl:template>

</xsl:stylesheet>
