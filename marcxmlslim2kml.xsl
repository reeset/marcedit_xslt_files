<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:marc="http://www.loc.gov/MARC21/slim"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="marc xsi">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="sourcefile" />
    
    <xsl:template match="/">
        <kml xmlns="http://www.opengis.net/kml/2.2" 
            xmlns:gx="http://www.google.com/kml/ext/2.2" 
            xmlns:kml="http://www.opengis.net/kml/2.2" 
            xmlns:atom="http://www.w3.org/2005/Atom">
            <xsl:for-each select="//marc:collection/marc:record">
                <Document>
                    <xsl:call-template name="marcRecord"/>
                </Document>
            </xsl:for-each>
        </kml>
    </xsl:template>
    <xsl:template name="marcRecord">
        <name><xsl:value-of select="substring-before($sourcefile, '.')"/><xsl:text>.kml</xsl:text></name>        
        <Style id="orange-5px">
            <LineStyle>
                <color>ff00aaff</color>
                <width>5</width>
            </LineStyle>
        </Style>              
        <Placemark>            
            <xsl:choose>
                <xsl:when test = "marc:datafield[@tag='245']">
                    <!--have a tradition title -->
                    <name><xsl:value-of select="normalize-space(marc:datafield[@tag='245']/marc:subfield[@code='a'])" /></name>
                </xsl:when>
                <xsl:otherwise>
                    <!--likely a uniform title -->
                    <name><xsl:value-of select="normalize-space(marc:datafield['240']/marc:subfield[@code='a'])" /></name>
                </xsl:otherwise>
            </xsl:choose>                      
            <styleUrl>#orange-5px</styleUrl>            
            <LineString>                
                <tessellate>1</tessellate>
                <xsl:if test="marc:datafield[@tag='034']">
                    <coordinates>
                        <xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='d']" />,<xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='f']" />,0
                        <xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='e']" />,<xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='f']" />,0
                        <xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='e']" />,<xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='g']" />,0
                        <xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='d']" />,<xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='g']" />,0
                        <xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='d']" />,<xsl:value-of select="marc:datafield[@tag='034']/marc:subfield[@code='f']" />,0
                    </coordinates>    
                </xsl:if>                                
            </LineString>            
        </Placemark>        
    </xsl:template>
</xsl:stylesheet>
