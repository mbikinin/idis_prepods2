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
            <xsl:when test="count(InfoRatingList/item) = 0">
                <p>Нет данных!</p>
            </xsl:when>
            <xsl:otherwise>
                <p>Количество заявлений о приеме на обучение по программам среднего профессионального образования в ЧОУ ВО "Казанский инновационный университет имени В.Г. Тимирясова (ИЭУП)" на 2016-2017 учебный год</p>
                <br/>
                <div class="current_date">По состоянию на: <strong><xsl:value-of select="current_date"/></strong></div>
                <table class="result_i rating_info_table">
                    <thead>
                        <tr class="row0">
                            <td class="column0 style17 s style19" rowspan="3">Наименование специальности</td>
                            <td class="column1 style11 s style13" colspan="4">Очная форма обучения</td>
                        </tr>
                        <tr class="row1">
                            <td class="column1 style16 s style14" colspan="2">Контрольные цифры приема (бюджет)</td>
                            <td class="column3 style14 s style15" colspan="2">Места по договорам об оказании платных образовательных услуг (внебюджет)</td>
                        </tr>
                        <tr class="row2">
                            <td class="column1 style8 s">на базе основного общего образования</td>
                            <td class="column2 style4 s">на базе среднего общего образования</td>
                            <td class="column3 style4 s">на базе основного общего образования</td>
                            <td class="column4 style5 s">на базе среднего общего образования</td>
                        </tr>
                    </thead>
                    <xsl:apply-templates select="InfoRatingList/item" />
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="InfoRatingList/item">
        <tr>
            <td class="column0 style10 s"><xsl:value-of select="specName" /></td>
            <td class="column1 style9 s"><xsl:value-of select="numberBudget9O" /></td>
            <td class="column2 style6 s"><xsl:value-of select="numberBudget11O" /></td>
            <td class="column3 style6 s"><xsl:value-of select="number9O" /></td>
            <td class="column4 style7 s"><xsl:value-of select="number11O" /></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
