
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />
	<xsl:include href="layout.xsl" />
	<xsl:template match="root">
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru" lang="ru">
			<xsl:call-template name="head" />
			<body>
			<xsl:call-template name="call-blocks" />
				<div id="conteiner">
					<xsl:apply-templates select="header" />
					<div id="contentOnMain">
						<div class="col2left">
							<xsl:apply-templates select="content" />
						</div>
						<div class="col2right">
							<div class="offers">
								<img src="/upload/offers/1.png"/>
							</div>
							<div class="clear"></div>
						</div>
					</div>
					<div class="clear"></div>
					<div class="empty"></div>
				</div>
				<xsl:apply-templates select="footer" />
			</body>
			<script type="text/javascript" src="/public/js/libs/jquery.fancybox-1.3.4.pack.js"></script>
			<script type="text/javascript">
			$(document).ready(function() {
				$("a.imgZoom").fancybox();
			});
			</script>
			<link rel="stylesheet" type="text/css" href="/public/css/jquery.fancybox-1.3.4.css" media="screen" />
			
		</html>
	</xsl:template>
</xsl:stylesheet>

