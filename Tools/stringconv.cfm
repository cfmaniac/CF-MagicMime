<!--- Tool I used to convert a given string in a file (open the file in Notepad) to Hex --->
<cfset theString = "">
<cfloop from="1" to="#Len(theString)#" step="1" index="i">
<cfoutput>#Ucase(FormatbaseN(asc(Mid(theString,i,1)),"16"))#</cfoutput>
</cfloop>