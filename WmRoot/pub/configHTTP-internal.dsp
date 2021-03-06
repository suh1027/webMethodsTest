<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <TITLE>Integration Server -- Port Management</TITLE>

  </HEAD>
%ifvar mode equals('edit')%
  %ifvar disableport equals('true')%
    %invoke wm.server.net.listeners:disableListener%
    %endinvoke%
  %endif%
%endif%

%invoke wm.server.net.listeners:getListener%

<SCRIPT Language="JavaScript">
        var hiddenOptions = new Array();
        function confirmDisable()
        {
          if(document.properties1.listening.value=='true')
          {
            if(confirm("Port must be disabled to edit these settings.  Would you like to disable this port?"))
            {
				if(is_csrf_guard_enabled && needToInsertToken) {
					createForm("htmlForm_configHTTP", 'configHTTP.dsp', "POST", "HEAD");
					setFormProperty("htmlForm_configHTTP", "listenerKey", "%value listenerKey%");
				   setFormProperty("htmlForm_configHTTP", "pkg", "%value pkg%");
				   %ifvar listenerType%
				   setFormProperty("htmlForm_configHTTP", "listenerType", "%value listenerType%");
				   %endif%
				   setFormProperty("htmlForm_configHTTP", "mode", "edit");
				   setFormProperty("htmlForm_configHTTP", "disableport", "true");
				
				   setFormProperty("htmlForm_configHTTP", _csrfTokenNm_, _csrfTokenVal_);
				   var htmlForm_configHTTP = document.forms["htmlForm_configHTTP"];
					htmlForm_configHTTP.submit();
				   
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				    	document.location.replace("configHTTP.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true&webMethods-wM-AdminUI=true");
					}
					else {
				    	document.location.replace("configHTTP.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&disableport=true");
					}
				}
				   
            }
          }
          else{
			  if(is_csrf_guard_enabled && needToInsertToken) {
					createForm("htmlForm_configHTTP2", 'configHTTP.dsp', "POST", "HEAD");	
				   setFormProperty("htmlForm_configHTTP2", "listenerKey", "%value listenerKey%");
				   setFormProperty("htmlForm_configHTTP2", "pkg", "%value pkg%");
				   %ifvar listenerType%
				   setFormProperty("htmlForm_configHTTP2", "listenerType", "%value listenerType%");
				   %endif%
				   setFormProperty("htmlForm_configHTTP2", "mode", "edit");
			 
				   setFormProperty("htmlForm_configHTTP2", _csrfTokenNm_, _csrfTokenVal_);
				 var htmlForm_configHTTP2 = document.forms["htmlForm_configHTTP2"];
		         htmlForm_configHTTP2.submit();  
				} else {
					var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
					if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
				    	document.location.replace("configHTTP.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit&webMethods-wM-AdminUI=true");
					}
					else {
				    	document.location.replace("configHTTP.dsp?listenerKey=%value listenerKey encode(url)%&pkg=%value pkg encode(url)%%ifvar listenerType%&listenerType=%value listenerType encode(url)%%endif%&mode=edit");
					}
				}
				   
				 
      }

          return false;
        }
        
        function submit() {

            if ( document.properties1.port.value.length > 0 &&
                 document.properties1.proxyHost.value.length > 0 )
        {
            document.properties1.submit();
        }
            else
            {
            alert("Enterprise Gateway Registration Port and Enterprise Gateway Server Host MUST be set correctly before saving.");
        }
        }

</SCRIPT>
    <base target="_self">
        <style>
            .listbox  { width: 100%; }
        </style>

  <body onload="setupKeystoreData(document.properties1);setNavigation('security-ports.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Security_EditInternalSvrPortScrn');">
    <TABLE width="100%">
      <TR>
        <TD class="breadcrumb" colspan=2>
          Security &gt;
          Ports &gt;
          %ifvar ../mode equals('view')%
            View Internal Server Details
          %else%
            Edit Internal Server Configuration
          %endif% </TD>
      </TR>
      <TR>
        <TD colspan="2">
          <UL>
            <li>
			
			<script>
						    createForm("htmlform_http_security_ports", "security-ports.dsp", "POST", "BODY");
           </script>			
			<script>getURL("security-ports.dsp", "javascript:document.htmlform_http_security_ports.submit();", "Return to Ports");</script>
			
		  </li>
            %ifvar ../mode equals('view')%
              %ifvar ../listening equals('primary')%
              %else%
                <LI><A onclick="return confirmDisable();" HREF="">
                  Edit %ifvar ssl equals('true')% HTTPS %else% HTTP %endif% Port Configuration
                </a></li>
              %endif%
            %endif%
          </UL>
        </TD>
      </TR>
      <TR>
        <TD>
       <TABLE border="0" cellpadding="0" cellspacing="0">
            <tr>
        <td valign="top">
              <TABLE class="%ifvar ../mode equals('view')%tableView%else%tableView%endif%">
                <form name="properties1" action="security-ports.dsp" method="POST">
                %ifvar webMethods-wM-AdminUI% <input type="hidden" name="webMethods-wM-AdminUI" value="true"> %endif%


<!-- body -->
<SCRIPT>
    var agent = navigator.userAgent.toLowerCase();   
    var ie = (agent.indexOf("msie") != -1);
  function toggleSSL(checkId, spanId) {
    if (document.getElementById(checkId).checked==true){
        elem = document.getElementById(spanId);
        rows = elem.rows;
        for(i = 0; i < rows.length; i++){
           if (ie) {
             rows[i].style.display="block";
           }else{
             rows[i].style.display="block";
             rows[i].style.display="table-row";
           }
        }   

    } else {    
        elem = document.getElementById(spanId);
        rows = elem.rows;
        for(i = 0; i < rows.length; i++){
           rows[i].style.display="none";
        }   

    }
  }
  function setThreadpool(checkId, bool) {
    if (bool==true){
        document.getElementById(checkId).value="true";  
    }else{
        document.getElementById(checkId).value="false";     
    }
        
  }
  function toggleThreadpool(checkId, spanId) {
    
    if (document.getElementById(checkId).value=="true"){
        elem = document.getElementById(spanId);
        rows = elem.rows;
        for(i = 0; i < rows.length; i++){
           if (ie) {
             rows[i].style.display="block";
           }else{
             rows[i].style.display="block";
             rows[i].style.display="table-row";
           }
        }

        eEnable = document.getElementById(spanId+"enable");
        if(eEnable!=null){
            document.getElementById(spanId+"enable").style.display="none";
        }
    } else {    
        elem = document.getElementById(spanId);
        rows = elem.rows;

        for(i = 0; i < rows.length; i++){
           rows[i].style.display="none";
        }

        eEnable = document.getElementById(spanId+"enable");
        if(eEnable!=null){
            if (ie) {
                document.getElementById(spanId+"enable").style.display="block";
            }else{
                document.getElementById(spanId+"enable").style.display="block";
                document.getElementById(spanId+"enable").style.display="table-row";
            }
        }
    }
  }


</SCRIPT>
<tr>
    <td class="heading" colspan="2">Internal Server</td>
</tr>

%ifvar ../mode equals('edit')%
	<tr>
		<td class="oddrow">Enable</td>
		<td class="oddrow-l">
		  <input type="radio" name="enable" id="enable1" value="yes" ><label for="enable1">Yes</label></input>
		  <input type="radio" name="enable" id="enable2" value="no" checked><label for="enable2">No</label></input>
		</td>
	</tr>
%endif%

<tr>
    <td class="evenrow">Protocol</td>
    <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
    %ifvar ../mode equals('view')%
        %ifvar ssl equals('true')%HTTPS%else%HTTP%endif%            
        <INPUT TYPE="radio" NAME="ssl" id="sslIRTon" VALUE="true" style="visibility: hidden;"    %ifvar ssl equals('true')%CHECKED%endif%>
    %else%
	    <INPUT TYPE="radio" name="ssl" id="ssl" VALUE="false" %ifvar ssl equals('true')%%else%CHECKED%endif% onclick="toggleSSL('sslIRTon', 'sslIRT');"><label for="ssl">HTTP</label>
	    <INPUT TYPE="radio" NAME="ssl" id="sslIRTon"  VALUE="true" %ifvar ssl equals('true')%CHECKED%endif%  onclick="toggleSSL('sslIRTon', 'sslIRT');"><label for="sslIRTon">HTTPS</label>
    %endif%
    </td>
</tr>

<input type="hidden" name="factoryKey" value="webMethods/HTTP">
<input type="hidden" name="passwordChanged" value="false">

<tr>
    <td class="oddrow"><label for="pkg">Package Name</label></td>
    <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
    <!-- input name="pkg" value="WmRoot" -->
    %invoke wm.server.packages:packageList%
        %ifvar ../mode equals('view')%
		%value pkg encode(html)%
	    %else%
		<select name="pkg" id="pkg" >
		  %loop packages%
		      %ifvar enabled equals('true')%
			    %ifvar ../pkg -notempty%
				<option %ifvar ../pkg vequals(name)%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                %else%
				<option %ifvar name equals('WmRoot')%selected %endif%value="%value name encode(htmlattr)%">%value name encode(html)%</option>
                %endif%
              %endif%
          %endloop%
        </select>
        %endif%
      %endinvoke%
    </td>
</tr>
<tr>
    <td class="evenrow"><label for="portAlias">Alias</label></td>
    <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
      %ifvar listenerKey -notempty%
        %value portAlias encode(html)% 
      %else%
        <input name="portAlias" id="portAlias"  value="%value portAlias encode(htmlattr)%" size="60">
      %endif%
    </td>
</tr>
<tr>
    <td class="oddrow"><label for="portDescription">Description (optional)</label></td>
    <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
      %ifvar ../mode equals('view')%
        %value portDescription encode(html)%
      %else%
        <input name="portDescription" id="portDescription"  value="%value portDescription encode(htmlattr)%" size="60">
      %endif%
    </td>
</tr>




        %ifvar listenerKey -notempty%
              <input type="hidden" name="operation" value="update">
              <input type="hidden" name="oldPkg" value="%value pkg encode(htmlattr)%">
            %else%
              <input type="hidden" name="operation" value="add">
              <input type="hidden" name="oldPkg">
            %endif%
            <input type="hidden" name="listenerKey" value="%value listenerKey encode(htmlattr)%">
            <input type="hidden" name="serverType">
            <input type="hidden" name="listening" value="%value listening encode(htmlattr)%">
            <input type="hidden" name="listenerType" value="%value listenerType encode(htmlattr)%">
            <input type="hidden" name="mode" value="%value ../mode encode(htmlattr)%">

	<tr>
	<td class="evenrow"><label for="maxConnections">Max Connections</label></td>
	<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
		%ifvar ../mode equals('view')%
		  %value maxConnections encode(html)%
		%else%
		  %ifvar maxConnections%
		    <input type="text" name="maxConnections" id="maxConnections"  value="%value maxConnections encode(htmlattr)%">
		  %else%
		    <input type="text" name="maxConnections" id="maxConnections"  value="5">
		  %endif%
		%endif%
	 </td>
	<tr>

   %ifvar ../mode equals('view')%
   %else%
   <tr id="tpIRTenable">
     <td class="oddrow">Threadpool</td>
     <td class="oddrow-l">
     <a name="anchor_a" href="#anchor_b" onclick="setThreadpool('tpIRTon',true);toggleThreadpool('tpIRTon', 'tpIRT');"><u>Enable</u></a>
     </td>
   </tr>
   %endif%

<tbody id="tpIRT">
   <tr>
     <td class="heading" colspan="2">Private Threadpool Configuration</td>
	<input  type="hidden" name="threadPool" id="tpIRTon" value="%value threadPool encode(htmlattr)%">
   </tr>
   %ifvar ../mode equals('view')%
   %else%
      <tr>
         <td class="evenrow">Threadpool</td>
         <td class="evenrow-l">
         <a name="anchor_b" href="#anchor_a" onclick="setThreadpool('tpIRTon',false);toggleThreadpool('tpIRTon', 'tpIRT');"><u>Disable</u></a>
         </td>
      </tr>
   %endif%
   %include configHTTP-threadpool.dsp%
</tbody>

<SCRIPT>toggleThreadpool('tpIRTon', 'tpIRT');</SCRIPT>

%ifvar keepAliveTimeout%
    <input type="hidden" name="keepAliveTimeout" value="%value keepAliveTimeout encode(htmlattr)%">
%else%
    <input type="hidden" name="keepAliveTimeout" value="20000">
%endif%
              <tr>
                <td class="heading" colspan="2">Enterprise Gateway Server</td>
              </tr>
           <tr>
              <td class="oddrow"><label for="proxyHost">Host</label></td>
              <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
                 %ifvar ../mode equals('view')%
                   %value proxyHost encode(html)%
                 %else%
                   <input type="text" name="proxyHost" id="proxyHost"  value="%value proxyHost encode(htmlattr)%">
                 %endif%
               </td>
            </tr>
			<tr>
			<td class="evenrow"><label for="port">Port</label></td>
			<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
				%ifvar ../mode equals('view')%
				%value port encode(html)%
				%else%
				<input type="text" name="port" id="port"  value="%value port encode(htmlattr)%">
				%endif%
			</td>
			</tr>
		<tr>
<tr>
    <td class="heading" colspan="2">Registration Credentials (Optional)</td>
</tr>
		<td class="oddrow"><label for="username">User Name</label></td>
		<td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
		 %ifvar ../mode equals('view')%
		   %value username encode(html)%
		 %else%
		   <input type="text" name="username" id="username"  value="%value username encode(htmlattr)%">
		 %endif%
		</td>
	   </tr>
		<tr>
		<td class="evenrow"><label for="password">Password</label></td>
		<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
		%ifvar ../mode equals('view')%
		   *****
		 %else%
		   %ifvar password%
			   <input type="password" id="password" name="password" autocomplete="off" value="*****" onChange="document.properties1.passwordChanged.value=true;"/>
		    %else%
			   <input type="password" id="password" name="password" autocomplete="off" value=""/>
		    %endif%
		 %endif%
		</td>
	   </tr>

    <tbody id="sslIRT">
      %include config-keystore-common.dsp%
    </tbody>
<SCRIPT>toggleSSL('sslIRTon', 'sslIRT');</SCRIPT>

%include config-common-sec-properties.dsp%

<!-- end body -->

        </form>
    </TABLE>
</td>


%ifvar mode equals('view')%
%else%
    <tr><td colspan="2">
    <TABLE width="100%" class="%ifvar ../mode equals('view')%tableView%else%tableView%endif%">
    <tr>
        <td class="action">
            <input type="submit"  value="Save Changes" onClick="submit();">
        </td>
     </tr>
     </TABLE>
     </td></tr>
%endif%

%endinvoke%
               
        </table>
      </td>
    </tr>
    </table>
  </body>
</html>
