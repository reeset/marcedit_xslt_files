<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns="http://www.loc.gov/MARC21/slim" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd" >
      <leader>00596nz  a2200217n  4500</leader>

      <xsl:variable name="mod_date">
        <xsl:choose>
          <xsl:when test="//modified">
            <xsl:variable name="holddata" select="//modified/value" />
            <xsl:value-of select="substring(translate($holddata,'-',''),3,6)" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>210101</xsl:text>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:variable>"
      <!-- Control field 008 needs processed-->
      <controlfield tag="008">
        <xsl:value-of select="$mod_date"/>|||anznnbab||||||||||||||a|||||||d
      </controlfield>

      <xsl:if test="//identifier">
        <datafield tag="024" ind1="8" ind2=" ">
          <subfield code="a">
            <xsl:value-of select="//identifier" />
          </subfield>
          <subfield code="0">
            <xsl:value-of select="//id" />
          </subfield>
        </datafield>
      </xsl:if>

      <xsl:if test="//prefLabel">
        <datafield tag="150" ind1=" " ind2=" ">
          <subfield code="a">
            <xsl:value-of select="//prefLabel" />
          </subfield>
        </datafield>
      </xsl:if>

      <xsl:for-each select="//altLabel">
        <datafield tag="450" ind1=" " ind2=" ">
          <subfield code="a">
            <xsl:value-of select="." />
          </subfield>
        </datafield>
      </xsl:for-each>
      
      <xsl:for-each select="//hasTopConcept">
        <datafield tag="550" ind1=" " ind2=" ">
          <subfield code="0">
            <xsl:value-of select="./id" />
          </subfield>
        </datafield>
      </xsl:for-each>

      <xsl:for-each select="//broader">
        <datafield tag="550" ind1=" " ind2=" ">
          <subfield code="0">
            <xsl:value-of select="./id" />
          </subfield>
        </datafield>
      </xsl:for-each>

      <xsl:for-each select="//comment">
        <datafield tag="680" ind1=" " ind2=" ">
          <subfield code="a">
            <xsl:value-of select="." />
          </subfield>          
        </datafield>
      </xsl:for-each>

    </record>
  </xsl:template>
</xsl:stylesheet>
