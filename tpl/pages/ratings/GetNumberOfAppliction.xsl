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
            <xsl:when test="count(GetNumberOfApplicationsList/item) = 0">
                <p>Нет данных!</p>
            </xsl:when>
            <xsl:otherwise>
                <div class="current_date">Последнее обновление данных: <strong><xsl:value-of select="current_date"/></strong></div>
                <table class="result">
                    <thead>
                        <tr>
                            <th>Направление</th>
                            <th>Общее<br/> количество заявлений</th>
                            <th>Количество<br/> зявлений на очную форму обучения</th>
                            <th>Количество<br/> зявлений на заочную форму обучения</th>
                            <th>Количество<br/> зявлений на очно-заочную форму обучения</th>
                        </tr>
                    </thead>
                    <xsl:apply-templates select="GetNumberOfApplicationsList/item" />
                </table>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="GetNumberOfApplicationsList/item">
        <tr class="num">
            <td>
                <xsl:value-of select="specName" />
            </td>
            <td>
                <xsl:value-of select="all" />
            </td>
            <td>
                <xsl:value-of select="ochn" />
            </td>
            <td>
                <xsl:value-of select="zaochn" />
            </td>
            <td>
                <xsl:value-of select="ochnZaochn" />
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
