<!--- Implements a simple upload form to test the magicmime function --->
<cfif isDefined("form.theFile")>
	<cffile action="upload" destination="#Expandpath('.')#" filefield="form.theFile" nameconflict="overwrite">
	<cfinclude template="../magicmime.cfm">
	Your File is:<br />
	<cfdump var="#getMagicMime(Expandpath('./#cffile.SERVERFILE#'))#">
	<cffile action="delete" file="#Expandpath('./#cffile.SERVERFILE#')#">
</cfif>
<br />
Upload a file
<form action="uploadTest.cfm" method="post" enctype="multipart/form-data">
<input type="file" name="theFile">
<input type="submit">
</form>

Currently Supports
<ul>
<li>Adobe PDF Document</li>
<li>Microsoft Office Open XML Format Document</li>
<li>Microsoft Office Open XML Format Spreadsheet</li>
<li>Microsoft Office Open XML Format Presentation</li>
<li>Microsoft Office Word 97-2003 Document</li>
<li>Microsoft Office Excel 97-2003 Document</li>
<li>Microsoft Office Powerpoint 97-2003 Document</li>
<li>Graphics interchange format Image</li>
<li>Portable Network Graphics Image</li>
<li>JPEG Image</li>
<li>HTML (Experimental)</li>
</ul>
Try renaming the file extension.
