<!--- 
magicmime
Author: Paul Connell
Date:	23/04/2010
Desc:	Does file-string matching to determine the file type of any given file.
Ver:	0.1
-------------------------------------------------------------------------------
Changelog:	
23/04/2010	Original Version
--->
<cffunction name="getMagicMime" returntype="struct" output="no">
	<cfargument name="filePath" required="yes">
	<cfscript>
	var theFile = "";
	var hexFile = "";
	var LookupArray = ArrayNew(2);
	var resultStruct = StructNew();
	var i = 0;
	
	// Default results
	resultStruct.typename = "Unknown";
	resultStruct.mimetype = "Unknown";
	resultStruct.extension = "Unknown";
	
	// Hardcoded array of formats setup as regexes (add more as needed, searching for HEX strings).
	// This seemed quicker than putting all of them in a file that was loaded and parsed at runtime.
	LookupArray[1][1] = "25504446";
	LookupArray[1][2] = "Adobe PDF Document";
	LookupArray[1][3] = "application/pdf";
	LookupArray[1][4] = "pdf";
	
	LookupArray[2][1] = "504B030414000600[A-Z0-9]+776F72642F"; 
	LookupArray[2][2] = "Microsoft Office Open XML Format Document";
	LookupArray[2][3] = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
	LookupArray[2][4] = "docx";
	
	LookupArray[3][1] = "504B030414000600[A-Z0-9]+786C2F";
	LookupArray[3][2] = "Microsoft Office Open XML Format Spreadsheet";
	LookupArray[3][3] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	LookupArray[3][4] = "xlsx";
	
	LookupArray[4][1] = "504B030414000600[A-Z0-9]+7070742F";
	LookupArray[4][2] = "Microsoft Office Open XML Format Presentation";
	LookupArray[4][3] = "application/vnd.openxmlformats-officedocument.presentationml.presentation";
	LookupArray[4][4] = "pptx";

	LookupArray[5][1] = "474946383761|474946383961";
	LookupArray[5][2] = "Graphics interchange format file";
	LookupArray[5][3] = "image/gif";
	LookupArray[5][4] = "gif";

	LookupArray[6][1] = "FFD8FFE0[A-Z0-9]+4A46494600";
	LookupArray[6][2] = "JPEG/JFIF graphics file";
	LookupArray[6][3] = "image/jpeg";
	LookupArray[6][4] = "jpg";
	
	LookupArray[7][1] = "FFD8FFE0[A-Z0-9]+4578696600";
	LookupArray[7][2] = "Digital camera JPG using Exchangeable Image File Format (EXIF)";
	LookupArray[7][3] = "image/jpeg";
	LookupArray[7][4] = "jpg";
	
	LookupArray[8][1] = "FFD8FFE0[A-Z0-9]+535049464600";
	LookupArray[8][2] = "Still Picture Interchange File Format (SPIFF)";
	LookupArray[8][3] = "image/jpeg";
	LookupArray[8][4] = "jpg";
	
	LookupArray[9][1] = "D0CF11E0A1B11AE1[A-Z0-9]+576F7264";
	LookupArray[9][2] = "Microsoft Office Word 97-2003 Document";
	LookupArray[9][3] = "application/vnd.msword";
	LookupArray[9][4] = "doc";
	
	LookupArray[10][1] = "D0CF11E0A1B11AE1[A-Z0-9]+457863656C";
	LookupArray[10][2] = "Microsoft Office Excel 97-2003 Document";
	LookupArray[10][3] = "application/vnd.ms-excel";
	LookupArray[10][4] = "xls";

	LookupArray[11][1] = "D0CF11E0A1B11AE1[A-Z0-9]+506F776572706F696E74";
	LookupArray[11][2] = "Microsoft Office Powerpoint 97-2003 Document";
	LookupArray[11][3] = "application/vnd.ms-powerpoint";
	LookupArray[11][4] = "ppt";
	
	LookupArray[12][1] = "89504E470D0A1A0A";
	LookupArray[12][2] = "Portable Network Graphics Image";
	LookupArray[12][3] = "image/png";
	LookupArray[12][4] = "png";
	
	LookupArray[13][1] = "3C68746D6C|3C48544D4C";
	LookupArray[13][2] = "HTML Document";
	LookupArray[13][3] = "text/html";
	LookupArray[13][4] = "html";
	</cfscript>
	<cflock type="readonly" name="MimeLock#Hash(Arguments.filePath)#" timeout="10" throwontimeout="no">
		<cffile action="readbinary" file="#Arguments.filePath#" variable="theFile">
	</cflock>
	<cfset hexFile = BinaryEncode(theFile,'Hex')>
	<cfloop from="1" to="#ArrayLen(LookupArray)#" step="1" index="i">
		<cfif ReFind(LookupArray[i][1],hexFile,0,false)>
			<cfset resultStruct.typename = LookupArray[i][2]>
			<cfset resultStruct.mimetype = LookupArray[i][3]>
			<cfset resultStruct.extension = LookupArray[i][4]>
			<cfbreak>
		</cfif>
	</cfloop>
	<cfreturn resultStruct>
</cffunction>