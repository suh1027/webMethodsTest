<html>
    <head>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta http-equiv="Expires" CONTENT="-1">
        <title>Connection Details</title>
        <link rel="stylesheet" TYPE="text/css" HREF="../WmRoot/webMethods.css"></link>  
		<Link REL="stylesheet" TYPE="text/css" HREF="../WmART/webMethods.css"></LINK>
		
        <SCRIPT SRC="../WmRoot/webMethods.js"></SCRIPT>
        <script src="artconnjs.js"></script>
		 <script src="lookUp.js"></script>
		<script SRC="../%value adapterPackageName%/adapterConnPropValidator.js"></script>			
		<SCRIPT SRC="csrfGuard.js"></SCRIPT>
	<script type="text/javascript">
		function load()
		{		
			if (document.form.elements[".CMGRPROP.poolable"]!=undefined && document.form.elements[".CMGRPROP.poolable"].value == "false") {
				setEnabledFields(document.form, false);
			}		
		}		
	
	</script>

    </head>
    <body onload="load()">  
        <form name="form" action="ListResources.dsp" method="POST" onSubmit="return validateForm(form)">
        <input type="hidden" name="action" value="editConnection">
        <input type="hidden" name="passwordChange" value="false">
        <input type="hidden" name="searchConnectionName" value="%value searchConnectionName%">
        
            %invoke wm.art.admin:retrieveAdapterTypeData%
            %onerror%
            %endinvoke%
			
			
			%ifvar test equals(true)%
				<INPUT NAME="test" TYPE="hidden" VALUE="true">
			%else%
				%ifvar test equals(completed)%
					<INPUT NAME="test" TYPE="hidden" VALUE="completed">
				%else%
					<INPUT NAME="test" TYPE="hidden" VALUE="false">
				%endif%
			%endif%

            <table width=100%>
            <tr>
                %ifvar readOnly equals('true')%
                    <td class="breadcrumb" colspan=4>Adapters &gt; %value displayName% &gt; View Connection</td>
                %else%       
                    <td class="breadcrumb" colspan=4>Adapters &gt; %value displayName% &gt; Edit Connection</td>
                %endif%    
                <!-- <td class="menusection-Adapters" colspan=7>Adapters &gt;<A HREF="ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%">%value displayName%</a> 
                &gt; Edit %value connectionAlias% Connection</td> -->
            </tr>
			
			
			%ifvar test equals(true)%
			  %invoke wm.art.admin.connection:testResource% 
			  <SCRIPT>testCompleted();</SCRIPT>
			  %ifvar message%
				<TR><TD class="message" colspan="8">%value message encode(html)%</TD></TR>
			  %else%
			  %endif%
			  %onerror%
				 %ifvar localizedMessage%
                        <tr><td class="message" colspan=8>Error encountered <pre>%value localizedMessage%</pre></td></tr>
                    %else%
                        %ifvar error%
                             <tr><td class="message" colspan=8>Error encountered <pre>%value errorMessage%</pre></td></tr>
                        %endif%
                    %endif%		
			  %endinvoke%
			%endif%
          
            <tr>
                <td colspan=2>
                    <ul>
                    <li><A id="Return_to_%value displayName%_Connections" HREF="ListResources.dsp?adapterTypeName=%value -urlencode adapterTypeName%&searchConnectionName=%value -urlencode searchConnectionName%&action=lastAccessPage&dspName=.LISTRESOURCES">Return to %value displayName% Connections</A><script>updateURL("Return_to_%value displayName%_Connections", "Return to %value displayName% Connections");</script>
                    </ul>
                </td>
            </tr>
           
			<tr>
			<td>
			<table class="tableView" width="100%">
			<tbody>
            %invoke wm.art.admin.connection:getResourceConfiguration%
                <tr>
                    <td class="heading" colspan=2>%value connectionAlias% Details</td>
                </tr>
              
                <tr>
                    <script>writeTD('row');</script>Connection Type</td>
                    <script>writeTD('rowdata-l');swapRows();</script>%ifvar mcfDisplayName%%value mcfDisplayName%%else%%value connectionFactoryType%%endif%</td>
                </tr>

                <tr>
                    <script>writeTD('row');</script>Package Name</TD>
                    <script>writeTD('rowdata-l');swapRows();</script>%value packageName%</td>
                </tr>    
            
                %include EditConnectionProperties.dsp%
                   
                %comment%----------------------ConnectionManagerProperties--------------%endcomment%    
                %include EditConnectionManagerProperties.dsp%
                %comment%----------------------End ConnectionManagerProperties--------------%endcomment%  
            
            %onerror%
                %ifvar localizedMessage%
                    %comment%-- Localized error message supplied --%endcomment%
                    <tr><td class="message" colspan="2">Error encountered <PRE>%value localizedMessage%</PRE></td></tr>
                %else%
                    %ifvar error%
                        <tr><td class="message" colspan="2">Error encountered <PRE>%value errorMessage%</PRE></td></tr>
                    %endif%
                %endif%
            %endinvoke%
			</tbody>
			</table>
			</td>
			</tr>
            </table>
              
            <table width=100%>
                <tr>
                    <td class="action" colspan="2">
                        %ifvar readOnly equals('false')%
                            <input type="submit" name="SUBMIT" value="Save Changes" width=100></input>
							<input type="submit" name="TEST" value="Test Connection" onClick="return testConnection('ConnNodeDetails.dsp');" />
                            <input type="hidden" name="adapterTypeName" value="%value adapterTypeName%">
                            <input type="hidden" name="connectionFactoryType" value="%value connectionFactoryType%">       
                            <input type="hidden" name="connectionAlias" value="%value connectionAlias%">
							<input type="hidden" name="readOnly" value="false">
                        %endif%        
                    </td>    
                </tr>
            </table>
        </form>    
    </body>
</html>
