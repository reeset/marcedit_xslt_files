<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:marc="http://www.loc.gov/MARC21/slim"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />

  <!--<xsl:output method="xml" indent="yes" encoding="iso8859-1"/>-->
  <xsl:template match="/">
    <marc:collection
			xmlns:marc="http://www.loc.gov/MARC21/slim"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
      <marc:record>
        <xsl:call-template name="datafield"/>
      </marc:record>
    </marc:collection>

  </xsl:template>

  <xsl:template name="datafield">

    <xsl:for-each select="IIIRECORD/VARFLD">
      <xsl:sort select="MARCINFO/MARCTAG" data-type="number"/>
      <xsl:choose>
        <xsl:when test="MARCINFO">
          <xsl:choose>
            <xsl:when test="MARCINFO/MARCTAG&lt;'010'">
              <xsl:element name="controlfield">
                <xsl:attribute name="tag">
                  <xsl:value-of select="MARCINFO/MARCTAG"/>
                </xsl:attribute>
                <xsl:value-of select="MARCFIXDATA"/>
              </xsl:element>
              <xsl:text>&#xa;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:element name="datafield">
                <xsl:attribute name="tag">
                  <xsl:value-of select="MARCINFO/MARCTAG"/>
                </xsl:attribute>
                <xsl:attribute name="ind1">
                  <xsl:value-of select="MARCINFO/INDICATOR1"/>
                </xsl:attribute>
                <xsl:attribute name="ind2">
                  <xsl:value-of select="MARCINFO/INDICATOR2"/>
                </xsl:attribute>
                <xsl:text>&#xa;</xsl:text>
                <xsl:for-each select="MARCSUBFLD">
                  <xsl:element name="subfield">
                    <xsl:attribute name="code">
                      <xsl:value-of select="SUBFIELDINDICATOR"/>
                    </xsl:attribute>
                    <xsl:value-of select="SUBFIELDDATA"/>
                  </xsl:element>
                  <xsl:text>&#xa;</xsl:text>
                </xsl:for-each>
              </xsl:element>
              <xsl:text>&#xa;</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>

    <marc:datafield tag="907" ind1=" " ind2=" ">
      <marc:subfield code="a">
        <xsl:value-of select="IIIRECORD/RECORDINFO/RECORDKEY"/>
      </marc:subfield>
    </marc:datafield>
   
    <xsl:element name="iiidatafield">
      <xsl:text>&#xa;</xsl:text>
      <xsl:element name="record_key">
        <xsl:for-each select="IIIRECORD/RECORDINFO/RECORDKEY">
          <xsl:value-of select="."/>
        </xsl:for-each>
      </xsl:element>
      <xsl:text>&#xa;</xsl:text>
      <xsl:element name="create_date">
        <xsl:for-each select="IIIRECORD/RECORDINFO/CREATEDATE">
          <xsl:value-of select="."/>
        </xsl:for-each>
      </xsl:element>
      <xsl:text>&#xa;</xsl:text>
      <xsl:element name="last_update_date">
        <xsl:for-each select="IIIRECORD/RECORDINFO/LASTUPDATEDATE">
          <xsl:value-of select="."/>
        </xsl:for-each>
      </xsl:element>
      <xsl:text>&#xa;</xsl:text>
      <xsl:element name="revisions">
        <xsl:for-each select="IIIRECORD/RECORDINFO/REVISIONS">
          <xsl:value-of select="."/>
        </xsl:for-each>
      </xsl:element>
      <xsl:text>&#xa;</xsl:text>
      <xsl:element name="previous_update_date">
        <xsl:for-each select="IIIRECORD/RECORDINFO/PREVUPDATEDATE">
          <xsl:value-of select="."/>
        </xsl:for-each>
      </xsl:element>
      <xsl:text>&#xa;</xsl:text>
      <xsl:for-each select="IIIRECORD/TYPEINFO/BIBLIOGRAPHIC/FIXFLD">
        <xsl:element name="fixed_field">
          <xsl:attribute name="label">
            <xsl:value-of select="FIXLABEL"/>
          </xsl:attribute>
          <xsl:attribute name="number">
            <xsl:value-of select="FIXNUMBER"/>
          </xsl:attribute>
          <xsl:attribute name="value">
            <xsl:value-of select="FIXVALUE"/>
          </xsl:attribute>
        </xsl:element>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
      <xsl:for-each select="IIIRECORD/BIBCOPIESAVAILABLE">
        <xsl:element name="bib_copies_available">
          <xsl:attribute name="number_of_copies">
            <xsl:value-of select="NBRCOPIES"/>
          </xsl:attribute>
          <xsl:attribute name="number_of_locations">
            <xsl:value-of select="NBRLOCATIONS"/>
          </xsl:attribute>
          <xsl:text>&#xa;</xsl:text>
          <xsl:for-each select="LOCATIONNAMES">
            <xsl:element name="location_names">
              <xsl:value-of select="."/>
            </xsl:element>
          </xsl:for-each>
          <xsl:text>&#xa;</xsl:text>
        </xsl:element>
      </xsl:for-each>
      <xsl:text>&#xa;</xsl:text>
    </xsl:element>

    <xsl:element name="linked_records">
      <xsl:text>&#xa;</xsl:text>
      <xsl:for-each select="IIIRECORD/LINKFIELD/Link">
        <xsl:element name="linked_record">
          <xsl:attribute name="link_type">
            <xsl:value-of select="../LinkType"/>
          </xsl:attribute>
          <xsl:text>&#xa;</xsl:text>
          <xsl:element name="link_number">
            <xsl:value-of select="SequenceNumber"/>
          </xsl:element>
          <xsl:text>&#xa;</xsl:text>
          <xsl:element name="record_key">
            <xsl:for-each select="IIIRECORD/RECORDINFO/RECORDKEY">
              <xsl:value-of select="."/>
            </xsl:for-each>
          </xsl:element>
          <xsl:text>&#xa;</xsl:text>
          <xsl:element name="create_date">
            <xsl:for-each select="IIIRECORD/RECORDINFO/CREATEDATE">
              <xsl:value-of select="."/>
            </xsl:for-each>
          </xsl:element>
          <xsl:text>&#xa;</xsl:text>
          <xsl:element name="last_update_date">
            <xsl:for-each select="IIIRECORD/RECORDINFO/LASTUPDATEDATE">
              <xsl:value-of select="."/>
            </xsl:for-each>
          </xsl:element>
          <xsl:text>&#xa;</xsl:text>
          <xsl:element name="revisions">
            <xsl:for-each select="IIIRECORD/RECORDINFO/REVISIONS">
              <xsl:value-of select="."/>
            </xsl:for-each>
          </xsl:element>
          <xsl:text>&#xa;</xsl:text>
          <xsl:element name="previous_update_date">
            <xsl:for-each select="IIIRECORD/RECORDINFO/PREVUPDATEDATE">
              <xsl:value-of select="."/>
            </xsl:for-each>
          </xsl:element>
          <xsl:text>&#xa;</xsl:text>
          <xsl:for-each select="IIIRECORD">
            <xsl:element name="item_status">
              <xsl:attribute name="status">
                <xsl:value-of select="ITEMSTATUS"/>
              </xsl:attribute>
              <xsl:attribute name="number_available">
                <xsl:value-of select="ITEMISAVAILABLE"/>
              </xsl:attribute>
              <xsl:attribute name="location">
                <xsl:value-of select="ITEMLOCATION"/>
              </xsl:attribute>
              <xsl:value-of select="ITEMIMESSAGETEXT"/>
            </xsl:element>
            <xsl:text>&#xa;</xsl:text>
          </xsl:for-each>
          <xsl:for-each select="IIIRECORD/TYPEINFO/ITEM/FIXFLD">
            <xsl:element name="fixed_field">
              <xsl:attribute name="label">
                <xsl:value-of select="FIXLABEL"/>
              </xsl:attribute>
              <xsl:attribute name="number">
                <xsl:value-of select="FIXNUMBER"/>
              </xsl:attribute>
              <xsl:attribute name="value">
                <xsl:value-of select="FIXVALUE"/>
              </xsl:attribute>
            </xsl:element>
            <xsl:text>&#xa;</xsl:text>
          </xsl:for-each>

          <xsl:for-each select="IIIRECORD/VARFLD">
            <xsl:element name="header">
              <xsl:attribute name="type">
                <xsl:value-of select="HEADER/NAME"/>
              </xsl:attribute>
              <xsl:attribute name="display">
                <xsl:value-of select="DisplayForm"/>
              </xsl:attribute>
            </xsl:element>
            <xsl:text>&#xa;</xsl:text>
            <xsl:if test="normalize-space(MARCINFO/MARCTAG)">
              <xsl:element name="datafield">
                <xsl:attribute name="tag">
                  <xsl:value-of select="MARCINFO/MARCTAG"/>
                </xsl:attribute>
                <xsl:attribute name="ind1">
                  <xsl:value-of select="MARCINFO/INDICATOR1"/>
                </xsl:attribute>
                <xsl:attribute name="ind2">
                  <xsl:value-of select="MARCINFO/INDICATOR2"/>
                </xsl:attribute>
                <xsl:text>&#xa;</xsl:text>
                <xsl:for-each select="MARCSUBFLD">
                  <xsl:element name="subfield">
                    <xsl:attribute name="code">
                      <xsl:value-of select="SUBFIELDINDICATOR"/>
                    </xsl:attribute>
                    <xsl:value-of select="SUBFIELDDATA"/>
                  </xsl:element>
                  <xsl:text>&#xa;</xsl:text>
                </xsl:for-each>
              </xsl:element>
              <xsl:text>&#xa;</xsl:text>
            </xsl:if>
          </xsl:for-each>

        </xsl:element>
      </xsl:for-each>
    </xsl:element>


    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
</xsl:stylesheet>
