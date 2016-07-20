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
        <xsl:when test="count(EntrantsSubmitDocuments/item) = 0">
            <p>Нет данных!</p>
        </xsl:when>
        <xsl:otherwise>
            <div class="info_date">
                <div class="current_date">Последнее обновление данных: <strong><xsl:value-of select="current_date"/></strong></div>
            </div>

            <table class="result EntrantsSubmitDocuments_box">
                <thead>
                    <tr>
                        <th>ФИО</th>
                        <th>Общее количество <br/>баллов</th>
                        <!--Вывод дисциплин-->
                        <th>Особые права</th>
                        <th>Статус</th>
                        <th>Кол. баллов по<br/> индивидуальным достижениям</th>
                        <th>Условия приема</th>
                    </tr>
                </thead>
                <xsl:apply-templates select="EntrantsSubmitDocuments/item" />
            </table>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="EntrantsSubmitDocuments/item">
       <tr class="num">
           <td>
               <xsl:value-of select="familyname" />&#160;
               <xsl:value-of select="firstname" />&#160;
               <xsl:value-of select="secondname " />
           </td>
           <td><xsl:value-of select="resultScore" /></td>
           <!--Вывод дисциплин-->
           <td><xsl:value-of select="privelege" /></td>
           <td><xsl:value-of select="status" /></td>
           <td><xsl:value-of select="achivScore " /></td>
           <td><xsl:value-of select="condition" /></td>
       </tr>
    </xsl:template>
</xsl:stylesheet>
