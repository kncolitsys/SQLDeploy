<cfcomponent output="false" hint="Applicationsübergreifend Funktionen">

<cffunction name="init" returntype="system" access="public" output="false" hint="contructor">
  <cfargument name="appRoot" type="string" required="true" hint="Pfad zur INI-Datei" />

		<cfloop collection="#arguments#" item="myArg">	<!--- alle Argumente als Objektvariablen setzen --->
			<cfset variables.instance[myArg] = arguments[myArg] />
		</cfloop>

		<cfset variables.instance['myServers']	= loadConfigFile(arguments.appRoot &'config\servers.ini') />
		<cfset variables.instance['variables']	= loadConfigFile(arguments.appRoot &'config\variables.ini') />

		<cfset variables.instance['config']	= structNew() />
		<cfset structAppend(variables.instance['config'],variables.instance['myServers']) />
		<cfset structAppend(variables.instance['config'],variables.instance['variables']) />

	<cfreturn this />
</cffunction>


<cffunction name="getServerName" returntype="string" access="public" output="false" hint="Liefert den Namen der akt. Machine">
	<cfreturn listFirst(createObject('java','java.net.InetAddress').getLocalHost().getHostName(),'/') />
</cffunction>


<cffunction name="getConfig" returntype="any" access="public" hint="liest einen Wert oder Section aus der Configuration">
  <cfargument name="myField"	type="string" required="true" hint="Wert aus der 'INI-Datei' bzw. diesem Objekt lesen">

  <cfreturn evaluate('variables.instance.#arguments.myField#') />
</cffunction>


<cffunction name="loadConfigFile" returntype="struct" access="public" output="false" hint="liest alle Daten die zur Navigation notwendig sind">
  <cfargument name="iniFile" type="string" required="true" hint="Pfad zur INI-Datei" />

  <cfset var struct   = structNew() />
  <cfset var myFile   = arguments.iniFile />
  <cfset var sections = getProfileSections(myFile) />

  <cfset var section  = "" />
  <cfset var entry    = "" />

  <cfloop collection="#sections#" item="section">
    <cfset myStruct[section] = structNew() />
    <cfloop list="#sections[section]#" index="entry">
      <cfset struct[section][entry] = getProfileString(myFile,section,entry) />
    </cfloop>
  </cfloop>

  <cfreturn struct />
</cffunction>


<cffunction name="parseVARs" returntype="string" access="public" output="false" hint="konvertiert alle Variablen; später mal auf RegEx umschreiben">
	<cfargument name="myStatement"	type="string" required="true" hint="das zu konvertieren SQL-Statement" />
	<cfargument name="myMachine"		type="string" required="true" hint="Name der Machine" />

	<cfset var myResult = arguments.myStatement />

	<cfset myResult = replace(myResult,'{database}',listLast(arguments.myMachine)) />

	<cfloop collection="#variables.instance.config#" item="myVAR">
		<cfloop collection="#variables.instance.config[myVAR]#" item="myField">
			<cfset myResult = replaceNoCase(myResult,'{#myVAR#:#myField#}',variables.instance.config[myVAR][myField],'all')>
		</cfloop>
	</cfloop>

	<cfreturn myResult />
</cffunction>


<cffunction name="getInstanceData" returntype="struct" access="public" hint="zur Anzeige der akt. Objekt-Variablen">
  <cfreturn variables.instance />
</cffunction>

</cfcomponent>