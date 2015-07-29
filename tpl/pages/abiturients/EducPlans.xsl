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
				<span class="kvotaplaces hideBlock"><br/>
					<p>

						<i>Рейтинг абитуриентов по состоянию на <xsl:value-of select = "dateNow" /> г.</i><br/>
						<xsl:if test="budget = 1 and bplaces > 0 ">
							<i>Количество мест - <xsl:value-of select = "bplaces" /> </i><br/>
						</xsl:if>
						<xsl:if test="budget = 0 and free = 0 and fplaces > 0 ">
							<i>Количество мест - <xsl:value-of select = "fplaces" /> </i><br/>
						</xsl:if>
						<xsl:if test="kplaces > 0 ">
							<i>Количество мест - <xsl:value-of select = "kplaces" /> </i><br/>
						</xsl:if>
					</p>
				</span>
				<xsl:choose>
					<xsl:when test="budget = 1 ">
						<a href="#" class="getEntrantsInfoList" rel="">				
							<span class="pluse">+ </span> <xsl:value-of select = "specialityName" />							
						</a>
						<div class="resultAbbiture">
						</div>
					</xsl:when>	
					<xsl:otherwise>
						<xsl:value-of select = "kvotaplaces" />

						<a href="#" class="getEntrantsInfo" >				
							<span class="pluse">+ </span> <xsl:value-of select = "specialityName" />							
						</a>			

						<div class="resultAbbiture"></div>
					</xsl:otherwise>
				</xsl:choose>

			</li>
	</xsl:template>
</xsl:stylesheet>
