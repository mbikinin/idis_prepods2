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
                            <th>ФИО</th>
                            <th>Оригинал аттестата/диплома</th>
                            <th>Статус</th>
                        </tr>
                    </thead>
                    <xsl:apply-templates select="EntrantsList/item" />
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="EntrantsList/item">
        <tr class="num">
            <td>
                <xsl:value-of select="familyname" />&#160;
                <xsl:value-of select="firstname" />&#160;
                <xsl:value-of select="secondname " />
            </td>
            <td><xsl:value-of select="docOriginal" /></td>
            <td><xsl:value-of select="status" /></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
