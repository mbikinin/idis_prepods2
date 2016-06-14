<?xml version="1.0" encoding="UTF-8"?>
<!-- Главная страница -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Код страницы -->


	<xsl:template match="content">

		<ul class="s5">
			<xsl:if test = "error != '' "> 
				<li><xsl:value-of select = "error" />
				</li>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="phase = 2 and budget = 1 and inst = 1">
					<li>
						<a href="#" class="getEntrantsInfo2" rel="6">
							<span class="pluse">+ </span> Приказ о зачислении на выделенные бюджетные места (из числа граждан Республики Крым)
						</a>
						<div class="resultAbbiture"></div>
					</li>
					<li>
						<a href="#" class="getEntrantsInfo2" rel="3">
							<span class="pluse">+ </span> Приказ о зачислении поступающих по квоте приема лиц, имеющих особые права
						</a>
						<div class="resultAbbiture"></div>
					</li>
					<li>
						<a href="#" class="getEntrantsInfo2" rel="2">
							<span class="pluse">+ </span> Приказ о зачислении, поступающих по общему конкурсу 04/08/2015
						</a>
						<div class="resultAbbiture"></div>
					</li>
					<li>
                                                <a href="#" class="getEntrantsInfo3" rel="2">
                                                        <span class="pluse">+ </span> Приказ о зачислении, поступающих по общему конкурсу 07/08/2015
                                                </a>
                                                <div class="resultAbbiture"></div>
                                        </li>

				<!--<li>
					<a href="#" class="getEntrantsInfo2" rel="0">
						<span class="pluse">+ </span> Списки лиц, поступающих по общему конкурсу
					</a>
					<input type="hidden" class="budgetplaces" value="{budgetplaces}"/>
					<div class="resultAbbiture"></div>
				</li>-->
				</xsl:when>
				<xsl:when test="inst = 0 ">
					<li>
                        <a href="#" class="getEntrantsInfo2" rel="0">
                            <span class="pluse">+ </span> Списки лиц, поступающих по общему конкурсу
                        </a>
                        <div class="resultAbbiture"></div>
                    </li>
				</xsl:when>

				<xsl:when test="(phase =2 and budget = 0 and free = 1) or (phase =2 and budget = 0 and free = 0)  ">
					<li>
						<a href="#" class="getEntrantsInfo2" rel="2">
							<span class="pluse">+ </span> Приказ о зачислении, поступающих по общему конкурсу от <xsl:value-of select = "orderDate" />
						</a>
						<div class="resultAbbiture"></div>
					</li>
					<li>
						<a href="#" class="getEntrantsInfo3" rel="2">
							<span class="pluse">+ </span> Приказ о зачислении, поступающих по общему конкурсу от 07/08/2015
						</a>
						<div class="resultAbbiture"></div>
					</li>
				</xsl:when>
				<xsl:otherwise>
					<li>
						<a href="#" class="getEntrantsInfo2" rel="5">
							<span class="pluse">+ </span> Списки поступающих на выделенные бюджетные места (из числа граждан Республики Крым)
						</a>
						<div class="resultAbbiture"></div>
					</li>
					<li>
						<a href="#" class="getEntrantsInfo2" rel="4">
							<span class="pluse">+ </span> Списки поступающих по квоте приема лиц, имеющих особые права
						</a>
						<div class="resultAbbiture"></div>
					</li>
					<li>
						<a href="#" class="" rel="">
							<span class="pluse">+ </span> Списки лиц, поступающих в пределах квоты целевого приема
						</a>
						<div class="resultAbbiture"></div>
					</li>
					<li>
						<a href="#" class="getEntrantsInfo2" rel="0">
							<span class="pluse">+ </span> Списки лиц, поступающих по общему конкурсу
						</a>
						<div class="resultAbbiture"></div>
					</li>

				</xsl:otherwise>
			</xsl:choose>
		</ul>
	</xsl:template>
	
</xsl:stylesheet>
