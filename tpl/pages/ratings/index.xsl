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
				<select  name="branch" class="branch reset_financeform" required="required">
					<option value="-1">Город поступления</option>
					<option value = "1">Казань</option>
					<option value = "181">Набережные Челны</option>
					<option value = "224">Нижнекамск</option>
					<option value = "266">Чистополь</option>
					<option value = "268">Новочебоксарск</option>
					<option value = "323">Зеленодольск</option>
					<option value = "343">Альметьевск</option>
					<option value = "373">Бугульма</option>
					<option value = "1587">Крым</option>
				</select>
				<select name="studyform" class="studyform reset_financeform" required="required">
					<option value="-1">Выберите форму обучения</option>
					<option value="2">Очная</option>
					<option value="1">Заочная</option>
					<option value="3">Вечерняя</option>
				</select>
				<select name="skillvalue" class="skillvalue reset_financeform" required="required">
					<option value="-1">Выберите уровень образования</option>
					<option value="1">Бакалавриат</option>
					<option value="2">Магистратура</option>
					<option value="3">Аспирантура</option>
					<option value="4">Колледж</option>
				</select>
				<select name="financeform" class="financeform getRatingEducPlans" required="required">
					<option value="-1">Выберите форму финансирования</option>
					<option value="0">Места по договорам об оказании платных образовательных услуг</option>
					<option value="1">Бесплатные места</option>
					<option value="2">Бюджетные места</option>
				</select>
				<div class="resultEducPlans">
					<select name="speccode" class="speccode" required="required">
						<option value="-1">Выберите направление подготовки</option>
					</select>
				</div>
				<select name="list_type" class="list_type" required="required">
					<option value="-1">Выберите результат</option>
					<option value="1">Cписок лиц, подавших документы</option>
					<option value="2">Cписок поступающих</option>
				</select>
				<div class="clearfix"></div>
				<div class="krim_box">
					<input type="checkbox" name="krim" class="krim" />
					<span>Отношусь к числу лиц постоянно<br/> проживающих в республике Крым</span>
				</div>
				<br/>
				<div class="progress_box"></div>
				<br/>
				<input type="button" class="getResultList" value="Получить список" />
				<br/><br/>
				<div class="resultList"></div>
			</form>
		</div>
	</xsl:template>

	<xsl:template match="filials/item">
		<option value="{id}">
			<xsl:value-of select="city" />
		</option>
	</xsl:template>
</xsl:stylesheet>
