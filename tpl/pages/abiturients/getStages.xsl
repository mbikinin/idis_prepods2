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
			<ul>
				
				<xsl:apply-templates select="getStages/item" />
					
			</ul>
		</ul>
	</xsl:template>
	<xsl:template match="getStages/item/phases/item">
		<xsl:if test="phasekey = 0">
		<li class="phase" rel="{phasekey}">
			<a href="#" class="showBudget ">
				+ <xsl:value-of select = "phasevalue" />
			</a>
			<ul class="s2 hideBlock">		
			<xsl:choose>	
				<xsl:when test="phasekey = 3">			
					<li class="budget" rel="1">
						<a href="#" class="getStudy">
							<span class="pluse">+ </span>БЮДЖЕТНЫЕ МЕСТА
						</a>											
						<div class="resultStudy"></div>
					</li>
				</xsl:when>
				<xsl:when test="level = 0 and phasekey=0">
					<li class="budget" rel="1">
						<a href="#" class="getStudy">
							<span class="pluse">+ </span>БЮДЖЕТНЫЕ МЕСТА</a>
										
						<div class="resultStudy"></div>
					</li>			
					<li class="budget" rel="0">
						<a href="#" class="getStudy"><span class="pluse">+ </span>МЕСТА ПО ДОГОВОРАМ ОБ ОКАЗАНИИ ПЛАТНЫХ ОБРАЗОВАТЕЛЬНЫХ УСЛУГ</a>
						<div class="resultStudy"></div>
					</li>
				</xsl:when>
				<xsl:otherwise>
					<li class="budget" rel="1">
						<a href="#" class="getStudy">
							<span class="pluse">+ </span>БЮДЖЕТНЫЕ МЕСТА</a>
										
						<div class="resultStudy"></div>
					</li>
					<li class="budget free" rel="0">
						<a href="#" class="getStudy">
							<span class="pluse">+ </span>БЕСПЛАТНЫЕ МЕСТА</a>											
						<div class="resultStudy"></div>
					</li>
					<li class="budget" rel="0">
						<a href="#" class="getStudy"><span class="pluse">+ </span>МЕСТА ПО ДОГОВОРАМ ОБ ОКАЗАНИИ ПЛАТНЫХ ОБРАЗОВАТЕЛЬНЫХ УСЛУГ</a>
						<div class="resultStudy"></div>
					</li>
				</xsl:otherwise>
			</xsl:choose>
					
			</ul>
		</li></xsl:if>
		<xsl:if test="level = 0 or phasekey = 0">
		<li class="phase" rel="2">
			<a href="#" class="showBudget ">
				+ ПРИКАЗЫ О ЗАЧИСЛЕНИИ
			</a>
			<ul class="s2 hideBlock">
				<xsl:choose>
					<xsl:when test="phasekey = 3">
						<li class="budget" rel="1">
							<a href="#" class="getStudy">
								<span class="pluse">+ </span>БЮДЖЕТНЫЕ МЕСТА
							</a>
							<div class="resultStudy"></div>
						</li>
					</xsl:when>
					<xsl:when test="level = 0 and phasekey=0">
						<li class="budget" rel="1">
							<a href="#" class="getStudy">
								<span class="pluse">+ </span>БЮДЖЕТНЫЕ МЕСТА</a>

							<div class="resultStudy"></div>
						</li>
						<li class="budget" rel="0">
							<a href="#" class="getStudy"><span class="pluse">+ </span>МЕСТА ПО ДОГОВОРАМ ОБ ОКАЗАНИИ ПЛАТНЫХ ОБРАЗОВАТЕЛЬНЫХ УСЛУГ</a>
							<div class="resultStudy"></div>
						</li>
					</xsl:when>
					<xsl:otherwise>
						<li class="budget" rel="1">
							<a href="#" class="getStudy">
								<span class="pluse">+ </span>БЮДЖЕТНЫЕ МЕСТА</a>

							<div class="resultStudy"></div>
						</li>
						<li class="budget free" rel="0">
							<a href="#" class="getStudy">
								<span class="pluse">+ </span>БЕСПЛАТНЫЕ МЕСТА</a>
							<div class="resultStudy"></div>
						</li>
						<li class="budget" rel="0">
							<a href="#" class="getStudy"><span class="pluse">+ </span>МЕСТА ПО ДОГОВОРАМ ОБ ОКАЗАНИИ ПЛАТНЫХ ОБРАЗОВАТЕЛЬНЫХ УСЛУГ</a>
							<div class="resultStudy"></div>
						</li>
					</xsl:otherwise>
				</xsl:choose>

			</ul>
		</li>
	</xsl:if>
	</xsl:template>
	<xsl:template match="getStages/item">
			<li class="stage" rel="{id}">


				<ul>
					<xsl:apply-templates select="phases/item" />

				</ul>
				<input type="hidden" value="{orderDate}" class="orderDate" />
			</li>
	</xsl:template>
</xsl:stylesheet>
