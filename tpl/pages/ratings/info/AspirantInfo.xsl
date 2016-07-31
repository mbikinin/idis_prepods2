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
                <p>Количество заявлений о приеме на обучение по программам высшего образования - по программам подготовки научно-педагогических кадров аспирантуре в ЧОУ ВО "Казанский инновационный университет имени В.Г. Тимирясова (ИЭУП)" на 2016-2017 учебный год</p>
                <br/>
                <div class="current_date">По состоянию на: <strong><xsl:value-of select="current_date"/></strong></div>
                <table class="result_i rating_info_table">
                    <thead>
                        <tr class="row0">
                            <td class="column0 style20 s style22" rowspan="3">Наименование направления подготовки аспирантуры</td>
                            <td class="column1 style11 s style13" colspan="5">Очная форма обучения</td>
                            <td class="column6 style11 s style13" colspan="5">Заочная форма обучения</td>
                        </tr>
                        <tr class="row1">
                            <td class="column1 style14 s style16" colspan="3">Контрольные цифры приема (бюджет)</td>
                            <td class="column4 style17 s style18" colspan="2">Места по договорам об оказании платных образовательных услуг (внебюджет)</td>
                            <td class="column6 style19 s style19" colspan="3">Контрольные цифры приема (бюджет)</td>
                            <td class="column9 style17 s" colspan="2">Места по договорам об оказании платных образовательных услуг (внебюджет)</td>
                        </tr>
                        <tr class="row2">
                            <td class="column1 style3 s">Квота целевого приема (общие бюджетные места) </td>
                            <td class="column2 style3 s">Количество мест по общему конкурсу (общие бюджетные места)</td>
                            <td class="column3 style3 s">Количество мест для лиц, постоянно проживающих в Крыму (выделенные бюджетные места)</td>
                            <td class="column4 style3 s">Количество мест для лиц, постоянно проживающих в Крыму </td>
                            <td class="column5 style4 s">Количество мест по общему конкурсу</td>
                            <td class="column6 style3 s">Квота целевого приема (общие бюджетные места) </td>
                            <td class="column7 style3 s">Количество мест по общему конкурсу (общие бюджетные места)</td>
                            <td class="column8 style3 s">Количество мест для лиц, постоянно проживающих в Крыму (выделенные бюджетные места)</td>
                            <td class="column9 style3 s">Количество мест для лиц, постоянно проживающих в Крыму </td>
                            <td class="column10 style4 s">Количество мест по общему конкурсу</td>
                        </tr>
                    </thead>
                    <xsl:apply-templates select="InfoRatingList/item" />
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="InfoRatingList/item">
        <tr>
            <td class="column0 style5 s"><xsl:value-of select="specName" /></td>
            <td class="column1 style6 s">-</td>
            <td class="column2 style6 s">-</td>
            <td class="column3 style6 s">-</td>
            <td class="column4 style6 n"><xsl:value-of select="numberKrimO" /></td>
            <td class="column5 style7 n"><xsl:value-of select="numberO" /></td>
            <td class="column6 style8 s">-</td>
            <td class="column7 style8 s">-</td>
            <td class="column8 style8 s">-</td>
            <td class="column9 style9 n"><xsl:value-of select="numberKrimZ" /></td>
            <td class="column10 style10 n"><xsl:value-of select="numberZ" /></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
