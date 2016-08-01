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
                <xsl:if test="FormType = 2">
                    <p>Количество заявлений о приеме на обучение по программам высшего образования - программам магистратуры на 2016-2017 учебный год в ЧОУ ВО "Казанский инновационный университет имени В.Г. Тимирясова (ИЭУП)"</p>
                </xsl:if>
                <xsl:if test="FormType = 3">
                    <p>Количество заявлений о приеме на обучение по программам высшего образования - по программам подготовки научно-педагогических кадров аспирантуре в ЧОУ ВО "Казанский инновационный университет имени В.Г. Тимирясова (ИЭУП)" на 2016-2017 учебный год</p>
                </xsl:if>
                <xsl:if test="FormType = 4">
                    <p>Количество заявлений о приеме на обучение по программам среднего профессионального образования в ЧОУ ВО "Казанский инновационный университет имени В.Г. Тимирясова (ИЭУП)" на 2016-2017 учебный год</p>
                </xsl:if>
                <br/>
                <div class="current_date">По состоянию на: <strong><xsl:value-of select="current_date"/></strong></div>
                <xsl:apply-templates select="InfoRatingList/item" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="InfoRatingList/item">
        <table class="result_i rating_info_table">
            <tbody>
                <tr>
                    <td style="text-align: left" colspan="6"><strong><xsl:value-of select="specName" /></strong></td>
                </tr>
                <tr>
                    <td rowspan="2">Форма обучения</td>
                    <td colspan="3" class="rtecenter">Контрольные цифры приема (бюджет)</td>
                    <td colspan="2" class="rtecenter">Места по договорам об оказании платных образовательных услуг (внебюджет)</td>
                </tr>
                <tr>
                    <td>Особая квота (общие бюджетные места)</td>
                    <td>Количество мест по основному конкурсу (общие бюджетные места)</td>
                    <td>Количество мест для лиц, постоянно проживающих в Крыму (выделенные бюджетные места)</td>
                    <td>Количество мест для лиц, постоянно проживающих в Крыму</td>
                    <td>Количество мест по основному конкурсу</td>
                </tr>
                <tr>
                    <td>Очная форма обучения</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td><xsl:value-of select="numberKrimO" /></td>
                    <td><xsl:value-of select="numberO" /></td>
                </tr>
                <tr>
                    <td>Заочная форма обучения</td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    <td><xsl:value-of select="numberKrimZ" /></td>
                    <td><xsl:value-of select="numberZ" /></td>
                </tr>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
