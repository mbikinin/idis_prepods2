<?xml version="1.0" encoding="UTF-8"?>
<!-- Главная страница -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xml" indent="yes" encoding="utf-8"
                doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

    <!-- Код страницы -->


    <xsl:template match="content">
        <xsl:choose>
            <xsl:when test="count(EntrantsList/item) = 0">
                <p>Нет данных!</p>
            </xsl:when>
            <xsl:otherwise>
                <div class="current_date">Последнее обновление данных: <strong><xsl:value-of select="current_date"/></strong></div>
                <table class="result EntrantsSubmitDocuments_box">
                    <thead>
                        <tr>
                            <th></th>
                            <th>ФИО</th>
                            <th>Общее<br/> количество баллов</th>
                            <th>Дисциплины</th>
                           <!-- <th>Математика</th>
                            <th>Обществознание</th>
                            <th>Русский язык</th>-->
                            <th>Количество баллов<br/> по индивидуальным достижениям</th>
                            <th>Оригинал аттестата/диплома</th>
                            <th>Заявление о <br/>согласии на зачисление</th>
                            <th>Особые права при приеме</th>
                            <th>Статус</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="EntrantsList/item" />
                    </tbody>
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="EntrantsList/item">
        <tr class="num">
            <td><xsl:value-of select="position()" /></td>
            <td>
                <xsl:value-of select="familyname" />&#160;
                <xsl:value-of select="firstname" />&#160;
                <xsl:value-of select="secondname " />
            </td>
            <td><xsl:value-of select="resultScore" /></td>
            <td>
                <xsl:if test="count(extExamScores/item) != 0 ">
                    <table>
                        <tbody>
                            <tr><xsl:apply-templates select="extExamScores/item" /></tr>
                            <tr><xsl:apply-templates select="extExamScores2/item" /></tr>
                        </tbody>
                    </table>
                </xsl:if>
            </td>
            <td><xsl:value-of select="achivScore" /></td>
            <td><xsl:value-of select="docOriginal" /></td>
            <td><xsl:value-of select="consentEnrollment" /></td>
            <td><xsl:value-of select="privelege" /></td>
            <td><xsl:value-of select="status" /></td>
        </tr>
    </xsl:template>
   <xsl:template match="EntrantsList/item/extExamScores/item">
       <td><xsl:value-of select = "disciplineName" /></td>
    </xsl:template>
    <xsl:template match="EntrantsList/item/extExamScores2/item">
        <td><xsl:value-of select = "score" /></td>
    </xsl:template>
</xsl:stylesheet>
