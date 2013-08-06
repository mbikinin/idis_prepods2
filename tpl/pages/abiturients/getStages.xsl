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
	
	<xsl:template match="getStages/item">
			<li class="stage" rel="{id}"> <xsl:value-of select = "stageName" />
					<ul>
					<xsl:choose>
						<xsl:when test = "id = 1 ">
							<li class="phase" rel="0">
								<a href="#" class="showBudget">
									+ Пофамильный перечень лиц, зачисление которых рассматривается приемной комиссией по каждому направлению подготовки (27.07.2013)
								</a>
									<ul class="s2 hideBlock">						
										<li class="budget" rel="1">
											<a href="#" class="getStudy"><span class="pluse">+ </span>Бюджет</a>
											<div class="resultStudy">
															
											</div>
										</li>
										<li class="budget" rel="0">
											<a href="#" class="getStudy"><span class="pluse">+ </span>Внебюджет</a>
											<div class="resultStudy">
															
											</div>
										</li>
									</ul>
							</li>
							<li class="phase" rel="1">
								<a href="#" class="showBudget ">
									+ Список абитуриентов, рекомендованных к зачислению на I курс (30.07.13)
								</a>
								<ul class="s2 hideBlock">						
									<li class="budget" rel="1">
										<a href="#" class="getStudy"><span class="pluse">+ </span>Бюджет</a>
										<div class="resultStudy">
														
										</div>
									</li>
									<li class="budget" rel="0">
										<a href="#" class="getStudy"><span class="pluse">+ </span>Внебюджет</a>
										<div class="resultStudy">
														
										</div>
									</li>
								</ul>
							</li>
							<li class="phase" rel="2">
								<a href="#" class="showBudget ">
									+ Приказ о зачислении на 1 курс, по итогам 1-ого этапа зачисления (05.08.13)
								</a>
								<ul class="s2 hideBlock">						
									<li class="budget" rel="1">
										<a href="#" class="getStudy"><span class="pluse">+ </span>Бюджет</a>
										<div class="resultStudy">
														
										</div>
									</li>
									<li class="budget" rel="0">
										<a href="#" class="getStudy"><span class="pluse">+ </span>Внебюджет</a>
										<div class="resultStudy">
														
										</div>
									</li>
								</ul>
							</li>
						</xsl:when>
						<xsl:when test = "id = 2 ">
							
							<li class="phase" rel="1">
								<a href="#" class="showBudget ">
									+ Список абитуриентов, рекомендованных к зачислению на I курс (30.07.13)
								</a>
								<ul class="s2 hideBlock">						
									<li class="budget" rel="0">
										<a href="#" class="getStudy"><span class="pluse">+ </span>Внебюджет</a>
										<div class="resultStudy">
														
										</div>
									</li>
								</ul>
							</li>
						</xsl:when>
						<xsl:when test="id = 102">
							<li class="phase" rel="1">
								<a href="#" class="showBudget ">
									+ Список абитуриентов, рекомендованных к зачислению на I курс (05.08.13)
								</a>
								<ul class="s2 hideBlock">						
									<li class="budget" rel="1">
										<a href="#" class="getStudy"><span class="pluse">+ </span>Бюджет</a>
										<div class="resultStudy">
														
										</div>
									</li>
									<li class="budget" rel="0">
										<a href="#" class="getStudy"><span class="pluse">+ </span>Внебюджет</a>
										<div class="resultStudy">
														
										</div>
									</li>
								</ul>
							</li>
						</xsl:when>
						<xsl:otherwise>
							<li class="phase" rel="1">
								нет данных
							</li>
						</xsl:otherwise>
					</xsl:choose>
					
				</ul>
			</li>
	</xsl:template>
</xsl:stylesheet>
