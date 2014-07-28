<?xml version="1.0" encoding="UTF-8"?>
<!-- Главная страница -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Код страницы -->


	<xsl:template match="content">
		<ul class="s4">
			<xsl:apply-templates select="EducPlans/item" />
		</ul>
	</xsl:template>

	<xsl:template match="EducPlans/item">	
			<li class="plan" rel="{id}" >
				<a href="#" class="getEntrantsInfo" >
					<span class="pluse">+ </span> <xsl:value-of select = "specialityName" />
				</a>				
				<span class="kvotaplaces hideBlock"><br/>
					<p>
						<i>Рейтинг абитуриентов по состоянию на <xsl:value-of select = "dateNow" /> г.</i><br/>
						<xsl:if test="budgetplaces != '' ">	
							<i>Количество бюджетных мест - <xsl:value-of select = "budgetplaces" /> </i>
						</xsl:if>
						<br/>
						<xsl:if test="kvotaplaces != '' ">	
							<i>Количество бюджетных мест по квоте  - <xsl:value-of select = "kvotaplaces" /> </i>
						</xsl:if>
					</p>
				</span>
				<input type="hidden" class="budgetplaces" value="{budgetplaces}"/>
				<div class="resultAbbiture"></div>

			</li>
	</xsl:template>
</xsl:stylesheet>
