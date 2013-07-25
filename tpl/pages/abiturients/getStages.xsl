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
			<xsl:if test = "error != '' "> 
				<li><xsl:value-of select = "error" />
				</li>
			</xsl:if>
			<xsl:apply-templates select="getStages/item" />
		</ul>
	</xsl:template>

	<xsl:template match="getStages/item">	
			<li class="stage" rel="{id}">
				<a href="#" class="showBudget">
					<xsl:value-of select = "stageName" />   <xsl:if test = "entrantsDate != ''"> <strong> (<xsl:value-of select = "entrantsDate" />)</strong></xsl:if>
				</a>
				<ul class="s2">						
					<li class="budget" rel="1">
						<a href="#" class="getStudy"><span class="pluse">+ </span>Бюджет</a>
						<div class="resultStudy">
										
						</div>
					</li>
					<li class="budget" rel="0">
						<a href="#" class="getStudy"><span class="pluse">+ </span>Небюджет</a>
						<div class="resultStudy">
										
						</div>
					</li>
				</ul>
			</li>
	</xsl:template>
</xsl:stylesheet>
