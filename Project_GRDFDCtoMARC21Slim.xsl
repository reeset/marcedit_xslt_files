<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"  
xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:marc="http://www.loc.gov/MARC21/slim" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
         xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns:dcterms="http://purl.org/dc/terms/"
         xmlns:dcmitype="http://purl.org/dc/dcmitype/"
         xmlns:cc="http://web.resource.org/cc/"
         xmlns:pgterms="http://www.gutenberg.org/rdfterms/"
         xml:base="http://www.gutenberg.org/feeds/catalog.rdf" exclude-result-prefixes="dc">
    
	<xsl:output method="xml" indent="yes"/>
	
	<xsl:template match="/">
		<marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/MARC/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
			<xsl:apply-templates />
		</marc:collection>
	</xsl:template>
	
	<xsl:template match="text()" />
	<xsl:template match="pgterms:etext">
		<xsl:variable name="eid" select="substring-after(@rdf:ID, 'etext')" />
		<marc:record>
			<marc:leader>00000nmm  2200000Ka 4500</marc:leader>
			<!--<marc:controlfield tag="008">060620s00009999utu                 und d</marc:controlfield>-->
			
			<marc:datafield tag="042" ind1=" " ind2=" ">
				<marc:subfield code="a">dc</marc:subfield>
			</marc:datafield>

			<xsl:for-each select="dc:title[1]">
				<marc:datafield tag="245" ind1="0" ind2="0">
					<marc:subfield code="a">
						<xsl:choose>
							<xsl:when test="contains(., '&#xa;')">
								<xsl:value-of select="substring-before(., '&#xa;')" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="." />
							</xsl:otherwise>
						</xsl:choose>
					</marc:subfield>
					<marc:subfield code="h">[electronic resource]</marc:subfield>
				</marc:datafield>
			</xsl:for-each>
			
			
			<marc:datafield tag="260" ind1=" " ind2=" ">
				<marc:subfield code="a">Salt Lake City :</marc:subfield>
				<xsl:choose>
					<xsl:when test="dc:created">
						<marc:subfield code="b">Project Gutenberg Literary Archive Foundation, </marc:subfield>
						<marc:subfield code="c"><xsl:value-of select="substring(dc:created/dcterms:W3CDTF/rdf:value/., 1, 4)" />.</marc:subfield>
					</xsl:when>
					<xsl:otherwise>
						<marc:subfield code="b">Project Gutenberg Literary Archive Foundation.</marc:subfield>
					</xsl:otherwise>
				</xsl:choose>
			</marc:datafield>
			
			<xsl:if test="contains(dc:title[1], '&#xa;')">
				<marc:datafield tag="500" ind1=" " ind2=" ">
					<marc:subfield code="a">From &quot;<xsl:value-of select="substring-after(dc:title[1], '&#xa;')" />&quot;.</marc:subfield>
				</marc:datafield>
			</xsl:if>
			
			<marc:datafield tag="500" ind1=" " ind2=" ">
				<marc:subfield code="a">Records generated from Project Gutenberg RDF data.</marc:subfield>
			</marc:datafield>
			
			<marc:datafield tag="500" ind1 = " " ind2=" ">
				<marc:subfield code="a">ISO 639-2 language code: <xsl:value-of select="dc:language/dcterms:ISO639-2/rdf:value/." /></marc:subfield>
			</marc:datafield>

			<marc:datafield tag="540" ind1=" " ind2=" ">
				<marc:subfield code="a">Applicable license: http://www.gutenberg.org/license</marc:subfield>
			</marc:datafield>
			
			<xsl:if test="dc:subject">
				<xsl:choose>
					<xsl:when test="dc:subject/rdf:Bag">
						<xsl:for-each select="dc:subject/rdf:Bag/rdf:li">
							<xsl:if test="dcterms:LCSH">
								<marc:datafield tag="690" ind1=" " ind2=" ">
									<marc:subfield code="a"><xsl:value-of select="dcterms:LCSH/." /></marc:subfield>
								</marc:datafield>
							</xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="dc:subject">
							<xsl:if test="dcterms:LCSH">
								<marc:datafield tag="690" ind1=" " ind2=" ">
									<marc:subfield code="a"><xsl:value-of select="dcterms:LCSH/rdf:value/." /></marc:subfield>
								</marc:datafield>
							</xsl:if>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			
			</xsl:if>
			
			<xsl:for-each select="dc:creator">
				<marc:datafield tag="720" ind1=" " ind2=" ">
					<marc:subfield code="a"><xsl:value-of select="."/></marc:subfield>
					<marc:subfield code="e">author</marc:subfield>
				</marc:datafield>
			</xsl:for-each>
			
			<marc:datafield tag="856" ind1="4" ind2=" ">
				<marc:subfield code="u">http://www.gutenberg.org/etext/<xsl:value-of select="$eid" /></marc:subfield>
			</marc:datafield>
		</marc:record>
	</xsl:template>
</xsl:stylesheet>