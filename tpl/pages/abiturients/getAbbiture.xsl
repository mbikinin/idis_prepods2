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

			<li>
					<xsl:choose>
                        <xsl:when test="inst = '0' and  budget = '0' ">

                            <table>
                                <xsl:if test="count(getAbbitureColledg/item) > 0 ">
                                    <thead>
                                        <th></th><th>Фамилия</th>
                                        <th>Имя</th><th>Отчество</th><th>Средний балл <br/> по аттестату</th><th>Статус</th><th>Оригинал</th></thead>
                                    <xsl:apply-templates select="getAbbitureColledg/item" />
                                </xsl:if>
                            </table>
                        </xsl:when>

						<xsl:when test="inst = '0' and budget = 1 ">
							<table>
								<xsl:if test="count(getAbbitureColledgBudg/item) > 0 ">
									<thead>
										<th></th><th>Фамилия</th>
										<th>Имя</th><th>Отчество</th><th>Средний балл <br/> по аттестату</th><th>Оригинал</th></thead>
									<xsl:apply-templates select="getAbbitureColledgBudg/item" />
								</xsl:if>
							</table>
						</xsl:when>
						<xsl:when test="phase = 6 ">
                            <table>
                                <xsl:if test="count(getAbbitureStatus/item) > 0 ">
                                    <thead>
                                        <th></th><th>Фамилия</th>
                                        <th>Имя</th><th>Отчество</th><th>Сумма конкурсных <br/>баллов</th><th>Статус</th></thead>
                                    <xsl:apply-templates select="getAbbitureStatus/item" />
                                </xsl:if>
                            </table>
						</xsl:when>
						<xsl:otherwise>
                        <table>
							<xsl:if test="count(getAbbitureAll/item) > 0 ">
								<xsl:if test="budget = 1 and count(getAbbitureNoKvote/item) > 0">
									<h5 style="width: 650px">Рейтинг абитуриентов по общему конкурсу на места, финансируемые из бюджета</h5>
									<thead><th></th><th>Фамилия</th><th>Имя</th><th>Отчество</th><th>Сумма конкурсных <br/>баллов	</th>
										<th>Оригинал</th><th>Индивидуальные<br/> достижения	</th></thead>
									<xsl:apply-templates select="getAbbitureNoKvote/item" />
								</xsl:if>
								<xsl:if test="budget = 0">
										<xsl:if test="free = 0">
											<h5 style="width: 650px">Рейтинг абитуриентов по общему конкурсу на места по договорам об оказании платных образовательных услуг</h5>
										</xsl:if>
										<thead><th></th><th>Фамилия</th><th>Имя</th><th>Отчество</th><th>Сумма конкурсных <br/>баллов</th><th>Оригинал</th>
											<th>Индивидуальные<br/> достижения	</th></thead>
										<xsl:if test="free = 1">
											<xsl:apply-templates select="getAbbitureAllFree/item" />
										</xsl:if>
										<xsl:if test="free != 1">
											<xsl:apply-templates select="getAbbitureAll/item" />
										</xsl:if>
									</xsl:if>
								</xsl:if>
						</table>
						<table>
							<xsl:if test="count(getAbbitureKvote/item) > 0">
								<xsl:if test="budget = 1">
									<h5 style="width: 650px">Рейтинг абитуриентов на места, финансируемые из федерального бюджета по квоте приема лиц, имеющих особое право</h5>
									<thead><th></th><th>Фамилия</th><th>Имя</th><th>Отчество</th><th>Сумма конкурсных <br/>баллов</th><th>Оригинал</th><th>Индивидуальные<br/> достижения	</th></thead>
									<xsl:apply-templates select="getAbbitureKvote/item" />
								</xsl:if>
							</xsl:if>
                        </table>
						</xsl:otherwise>
					</xsl:choose>
			</li>
		</ul>
	</xsl:template>

    <xsl:template match="getAbbitureColledg/item">

        <tr class="pcolor{priority}" >
            <td class="col"></td>
            <td><xsl:value-of select = "familyname" /></td>
            <td><xsl:value-of select = "firstname" /></td>
            <td><xsl:value-of select = "secondname" /></td>
            <td><xsl:value-of select = "averagescore" /></td>
            <td><xsl:value-of select = "status" /></td>
            <td><xsl:value-of select = "docOriginal" /></td>
        </tr>
        <tr>
            <td colspan="4" style=" background-color: #fff; padding-bottom: 10px; cursor: pointer; " >
                <xsl:if test="count(schoolDiscScore/item) != 0 ">
                    <a href="#" class="ShowDisc">  предметы  </a>

                    <table class="format" style="float:right; display: none;">
                        <thead><th>Дисциплина</th><th>Кол.баллов</th></thead>
                        <tbody>
                            <xsl:apply-templates select="schoolDiscScore/item" />
                        </tbody>
                    </table>
                </xsl:if>
            </td>
        </tr>

    </xsl:template>
	<xsl:template match="getAbbitureColledgBudg/item">

		<tr class="pcolor{priority}" >
			<td class="col"></td>
			<td><xsl:value-of select = "familyname" /></td>
			<td><xsl:value-of select = "firstname" /></td>
			<td><xsl:value-of select = "secondname" /></td>
			<td><xsl:value-of select = "averagescore" /></td>
			<td><xsl:value-of select = "docOriginal" /></td>
		</tr>
		<tr>
			<td colspan="4" style=" background-color: #fff; padding-bottom: 10px; cursor: pointer; " >
				<xsl:if test="count(schoolDiscScoreBudg/item) != 0 ">
					<a href="#" class="ShowDisc">  предметы  </a>

					<table class="format" style="float:right; display: none;">
						<thead><th>Дисциплина</th><th>Кол.баллов</th></thead>
						<tbody>
							<xsl:apply-templates select="schoolDiscScoreBudg/item" />
						</tbody>
					</table>
				</xsl:if>
			</td>
		</tr>

	</xsl:template>
	<xsl:template match="getAbbitureStatus/item">

		<tr class="pcolor{priority}" >
			<td class="col"></td>
			<td><xsl:value-of select = "familyname" /></td>
			<td><xsl:value-of select = "firstname" /></td>
			<td><xsl:value-of select = "secondname" /></td>
			<td><xsl:value-of select = "resultScore" /></td>
			<td><xsl:value-of select = "status" /></td>
		</tr>

	</xsl:template>
	<xsl:template match="getAbbitureAllFree/item">

		<tr class="pcolor{priority}" ><td class="col"></td>
			<td><xsl:value-of select = "familyname" /></td>
			<td><xsl:value-of select = "firstname" /></td>
			<td><xsl:value-of select = "secondname" /></td>
			<td><xsl:value-of select = "resultScore" /></td>
			<td><xsl:value-of select = "docOriginal" /></td>
			<td><xsl:value-of select = "achivScore" /></td>
		</tr>
		<tr>
			<td colspan="4" style=" background-color: #fff; padding-bottom: 10px; cursor: pointer; " >
				<xsl:if test="count(getDisciplineAllFree/item) != 0 ">
					<a href="#" class="ShowDisc">  предметы  </a>

					<table class="format" style="float:right; display: none;">
						<thead><th>Дисциплина</th><th>Кол.баллов</th></thead>
						<tbody>
							<xsl:apply-templates select="getDisciplineAllFree/item" />
						</tbody>
					</table>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="getAbbitureAll/item">
					
				
				<xsl:choose>
					<xsl:when test="status = 'рекомендован(а) к зачислению' ">
						<tr class="in_budget pcolor{priority}"><td class="col"></td>
							<td><xsl:value-of select = "familyname" /></td>
							<td><xsl:value-of select = "firstname" /></td>
							<td><xsl:value-of select = "secondname" /></td>
							<td><xsl:value-of select = "resultScore" /></td>
							<td><xsl:value-of select = "docOriginal" /></td>
							<td><xsl:value-of select = "achivScore" /></td>
                            <td><xsl:value-of select = "status" /></td>
						</tr>
					</xsl:when>
					<xsl:otherwise>

						<tr class="pcolor{priority}" ><td class="col"></td>
							<td><xsl:value-of select = "familyname" /></td>
							<td><xsl:value-of select = "firstname" /></td>
							<td><xsl:value-of select = "secondname" /></td>
							<td><xsl:value-of select = "resultScore" /></td>
							<td><xsl:value-of select = "docOriginal" /></td>
							<td><xsl:value-of select = "achivScore" /></td>
                            <td><xsl:value-of select = "status" /></td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				<tr>
					<td colspan="4" style=" background-color: #fff; padding-bottom: 10px; cursor: pointer; " >
					<xsl:if test="count(getDiscipline/item) != 0 ">						
						<a href="#" class="ShowDisc">  предметы  </a>

						<table class="format" style="float:right; display: none;">						
								<thead><th>Дисциплина</th><th>Кол.баллов</th></thead>
								<tbody>
									<xsl:apply-templates select="getDisciplineAll/item" />
								</tbody>
						</table>
					</xsl:if>
					</td>
				</tr>
	</xsl:template>
	<xsl:template match="getAbbitureNoKvote/item">
		
				<xsl:choose>
					<xsl:when test="status = 'рекомендован(а) к зачислению' ">
						<tr class="in_budget pcolor{priority}"><td class="col"></td>
							<td><xsl:value-of select = "familyname" /></td>
							<td><xsl:value-of select = "firstname" /></td>
							<td><xsl:value-of select = "secondname" /></td>
							<td><xsl:value-of select = "resultScore" /></td>
							<td><xsl:value-of select = "docOriginal" /></td>
							<td><xsl:value-of select = "achivScore" /></td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr class="pcolor{priority}"><td class="col"></td>
							<td><xsl:value-of select = "familyname" /></td>
							<td><xsl:value-of select = "firstname" /></td>
							<td><xsl:value-of select = "secondname" /></td>
							<td><xsl:value-of select = "resultScore" /></td>
							<td><xsl:value-of select = "docOriginal" /></td>
							<td><xsl:value-of select = "achivScore" /></td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				<tr>
					<td colspan="4" style=" background-color: #fff; padding-bottom: 10px; cursor: pointer; " >
					<xsl:if test="count(getDiscipline/item) != 0 ">						
						<a href="#" class="ShowDisc">  предметы  </a>

						<table class="format" style="float:right; display: none;">						
							<thead><th>Дисциплина</th><th>Кол.баллов</th></thead>
							<tbody>
								<xsl:apply-templates select="getDiscipline/item" />
							</tbody>
						</table>
					</xsl:if>
					</td>
				</tr>
	</xsl:template>
	<xsl:template match="getAbbitureKvote/item">
		<xsl:if test="kvota = 1 ">
				<xsl:choose>
					<xsl:when test="status = 'рекомендован(а) к зачислению' ">
						<tr class="in_budget pcolor{priority}"><td class="col"></td>
							<td><xsl:value-of select = "familyname" /></td>
							<td><xsl:value-of select = "firstname" /></td>
							<td><xsl:value-of select = "secondname" /></td>
							<td><xsl:value-of select = "resultScore" /></td>
							<td><xsl:value-of select = "docOriginal" /></td>
							<td><xsl:value-of select = "achivScore" /></td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr class="pcolor{priority}"><td class="col"></td>
							<td><xsl:value-of select = "familyname" /></td>
							<td><xsl:value-of select = "firstname" /></td>
							<td><xsl:value-of select = "secondname" /></td>
							<td><xsl:value-of select = "resultScore" /></td>
							<td><xsl:value-of select = "docOriginal" /></td>
							<td><xsl:value-of select = "achivScore" /></td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				<tr>
					<td colspan="4" style=" background-color: #fff; padding-bottom: 10px; cursor: pointer; " >
					<xsl:if test="count(getDiscipline/item) != 0 ">						
						<a href="#" class="ShowDisc">  предметы  </a>

						<table class="format" style="float:right; display: none;">						
							<thead><th>Дисциплина</th><th>Кол.баллов</th></thead>
							<tbody>
								<xsl:apply-templates select="getDisciplineKvote/item" />
							</tbody>
						</table>
					</xsl:if>
					</td>
				</tr>
			</xsl:if>
	</xsl:template>

	<xsl:template match="getAbbitureColledgBudg/item/schoolDiscScoreBudg/item">
		<tr>
			<td><xsl:value-of select = "disciplineName" /></td>
			<td><xsl:value-of select = "score" /></td>
		</tr>
	</xsl:template>

    <xsl:template match="getAbbitureColledg/item/schoolDiscScore/item">
        <tr>
            <td><xsl:value-of select = "disciplineName" /></td>
            <td><xsl:value-of select = "score" /></td>
        </tr>
    </xsl:template>
	<xsl:template match="getAbbitureNoKvote/item/getDiscipline/item">	
		<tr>
			<td><xsl:value-of select = "disciplineName" /></td>
			<td><xsl:value-of select = "score" /></td>
		</tr>

	</xsl:template>
	<xsl:template match="getAbbitureKvote/item/getDisciplineKvote/item">	
		<tr>
			<td><xsl:value-of select = "disciplineName" /></td>
			<td><xsl:value-of select = "score" /></td>
		</tr>
	</xsl:template>
	<xsl:template match="getAbbitureAll/item/getDisciplineAll/item">
		<tr>
			<td><xsl:value-of select = "disciplineName" /></td>
			<td><xsl:value-of select = "score" /></td>
		</tr>
	</xsl:template>
	<xsl:template match="getAbbitureAllFree/item/getDisciplineAllFree/item">
		<tr>
			<td><xsl:value-of select = "disciplineName" /></td>
			<td><xsl:value-of select = "score" /></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
