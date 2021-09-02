<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" />
  <xsl:param name="dow" />
  <xsl:template match="@* | text()"/>
  <xsl:template match="/html/body/main/div/div[1]/div/section[3]/div[2]">
  <xsl:text>|  Essen |\n</xsl:text>
  <xsl:text>|---|\n</xsl:text>
  <xsl:for-each select="div[$dow]/div/div[2]/div/ul/li/span">
      <xsl:text>|</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>|\n</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
