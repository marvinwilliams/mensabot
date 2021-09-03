<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" />

  <xsl:template match="@* | text()"/>
  <xsl:template match="//div[@id='platocontent']/table[1]">
    <xsl:text>| Linie | Essen|\n</xsl:text>
    <xsl:text>|---|---|\n</xsl:text>
    <xsl:for-each select="tr/td[1]">
      <xsl:if test="count(../td[2]/table/tr[1]/td) = 3">
        <xsl:text>|</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>|</xsl:text>
        <xsl:for-each select="../td[2]/table/tr/td[2]/span/b">
          <xsl:if test="./text() != 'zu jedem Gericht ein Dessert oder Obst'">
            <xsl:if test="position() > 1">
              <xsl:text>||</xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
            <xsl:text>|\n</xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
