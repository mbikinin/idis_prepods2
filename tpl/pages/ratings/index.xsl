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
		<div>
			<p><xsl:value-of select ="message" /></p>
			<select name="branch" class="branch">
				<option>--Выберите филиал</option>
				<option value = "1">Казань</option>
				<xsl:apply-templates select="filials/item" />
			</select>
			<div class="clear"></div>
			<select name="studyform hidden" class="studyform">
				<option value="-1">--Выберите форму обучения</option>
				<option value="2">Очная</option>
				<option value="1">Заочная</option>
			</select>
			<div class="clear"></div>
			<select name="skillvalue hidden" class="skillvalue">
				<option value="-1">--Выберите уровень образования</option>
				<option value="1">Бакалавриат</option>
				<option value="2">Магистратура</option>
				<option value="3">Аспирантура</option>
				<option value="4">Колледж</option>
			</select>
			<div class="clear"></div>
			<select name="financeform hidden" class="financeform getRatingEducPlans">
				<option value="-1">--Выберите форму финансирования</option>
				<option value="0">Места по договорам об оказании платных образовательных услуг</option>
				<option value="1">Бесплатные места</option>
				<option value="2">Бюджетные места</option>
			</select>
			<div class="clear"></div>
			<div class="resultEducPlans"></div>
			<div class="clear"></div>
			<input class="hidden" type="checkbox" name="krim" /><span>Cписок поступающих на места для лиц, постоянно проживающих в Крыму</span>

			<div class="clear"></div>
			<select name="list_type hidden" class="list_type getResultList">
				<option value="-1">--Выберите результат</option>
				<option value="1">Cписок лиц, подавших документы</option>
				<option value="2">Cписок поступающих</option>
			</select>
			<div class="clear"></div>
			<div class="resultList"></div>

		</div>
	</xsl:template>

	<xsl:template match="filials/item">
		<option value="{id}">
			<xsl:value-of select="city" />
		</option>
	</xsl:template>
</xsl:stylesheet>
