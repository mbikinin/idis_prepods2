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
				<li class="stage" rel="1"> 1 поток
					<ul>
						<xsl:apply-templates select="getStages/item" />
					</ul>
				</li>
			</ul>
		</ul>
		<script>
		$(document).ready(function(){
			$('.showBudget').live("click", function(){
				$(this).parent().find('.s2').toggle();
				return false;
			});
		});
		</script>
	</xsl:template>
	
	<xsl:template match="getStages/item">
			
			<li class="phase" rel="0">
				<a href="#" class="showBudget">
					+ Пофамильный перечень лиц, зачисление которых рассматривается приемной комиссией по каждому направлению подготовки (27.07.13)
				</a>
				<ul class="s2" style="display:none;">						
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
				<a href="#" class="showBudget">
					+ Список абитуриентов, рекомендованных к зачислению на I курс (30.07.13)
				</a>
				<ul class="s2" style="display:none;">						
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
	</xsl:template>
</xsl:stylesheet>
