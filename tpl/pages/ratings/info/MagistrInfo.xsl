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
                <p>Колмчество заявлений о приеме на обучение по программам высшего образования - программам магистратуры на 2016-2017 учебный год в ЧОУ ВО "Казанский инновационный университет имени В.Г. Тимирясова (ИЭУП)"</p>
                <br/>
                <div class="current_date">По состоянию на: <strong><xsl:value-of select="current_date"/></strong></div>
                <table class="result_i rating_info_table">
                    <thead>
                        <tr class="row0">
                            <td class="column0 style59 s style59" rowspan="3">Наименование направления подготовки</td>
                            <td class="column1 style60 s style60" colspan="5">ОЧНАЯ ФОРМА ОБУЧЕНИЯ</td>
                            <td class="column6 style60 s style60" colspan="5">ЗАОЧНАЯ ФОРМА ОБУЧЕНИЯ</td>
                        </tr>
                        <tr class="row1">
                            <td class="column1 style60 s style60" colspan="3">Контрольные цифры приема (бюджет)</td>
                            <td class="column4 style60 s style60" colspan="2">Места по договорам об оказании платных образовательных услуг (внебюджет)</td>
                            <td class="column6 style60 s style60" colspan="3">Контрольные цифры приема (бюджет)</td>
                            <td class="column9 style60 s style60" colspan="2">Места по договорам об оказании платных образовательных услуг (внебюджет)</td>
                        </tr>
                        <tr class="row2">
                            <td class="column1 style61 s">Особая квота (общие бюджетные места)</td>
                            <td class="column2 style62 s">Количество мест по основному конкурсу (общие бюджетные места)</td>
                            <td class="column3 style62 s">Количество мест для лиц, постоянно проживающих в Крыму (выделенные бюджетные места)</td>
                            <td class="column4 style62 s">Количество мест для лиц, постоянно проживающих в Крыму </td>
                            <td class="column5 style61 s">Количество мест по основному конкурсу</td>
                            <td class="column6 style61 s">Особая квота (общие бюджетные места)</td>
                            <td class="column7 style62 s">Количество мест по основному конкурсу (общие бюджетные места)</td>
                            <td class="column8 style62 s">Количество мест для лиц, постоянно проживающих в Крыму (выделенные бюджетные места)</td>
                            <td class="column9 style62 s">Количество мест для лиц, постоянно проживающих в Крыму </td>
                            <td class="column10 style61 s">Количество мест по основному конкурсу</td>
                        </tr>
                    </thead>
                    <xsl:apply-templates select="InfoRatingList/item" />
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="InfoRatingList/item">
        <tr>
            <td class="column0 style63 s"><xsl:value-of select="specName" /></td>
            <td class="column1 style31 s">-</td>
            <td class="column2 style31 s">-</td>
            <td class="column3 style31 s">-</td>
            <td class="column4 style31 n"><xsl:value-of select="numberKrimO" /></td>
            <td class="column5 style64 n"><xsl:value-of select="numberO" /></td>
            <td class="column6 style31 s">-</td>
            <td class="column7 style31 s">-</td>
            <td class="column8 style31 s">-</td>
            <td class="column9 style31 n"><xsl:value-of select="numberKrimZ" /></td>
            <td class="column10 style64 n"><xsl:value-of select="numberZ" /></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
