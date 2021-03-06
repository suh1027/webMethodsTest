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
</HEAD>

<BODY onLoad="setNavigation('settings-broker.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Settings_Msging_BrokerScrn');">

  <TABLE width="100%">
    <TR>
      <TD class="breadcrumb" colspan="2">Settings &gt; Messaging &gt; Broker Settings</TD>
    </TR>

%ifvar action equals('edit')%
  %ifvar isChanged equals('true')%
    %invoke wm.server.dispatcher.adminui:setBrokerSettings%    
    
    <TR>
      <TD colspan="2">&nbsp;</td>
      </TR>
    <TR>
      <TD class="message" colspan=2>%value message encode(html)%</TD>
    </TR>
    
    %endinvoke%
  %else%
    <TR>
      <TD colspan="2">&nbsp;</td>
    </TR>
    <TR>
      <TD class="message" colspan=2>No changes made to Broker Configuration Settings.</TD>
    </TR>
  %endif%
%endif%

    <TR>
      <TD colspan="2">
        <ul class="listitems">
		  <script>
		  createForm("htmlform_settings_messaging", "settings-messaging.dsp", "POST", "BODY");
		  createForm("htmlform_settings_broker_edit", "settings-broker-edit.dsp", "POST", "BODY");
		  </script>
          <li class="listitem"><script>getURL("settings-messaging.dsp", "javascript:document.htmlform_settings_messaging.submit();", "Return to Messaging");</script>
		  </li>
          <li class="listitem"><script>getURL("settings-broker-edit.dsp", "javascript:document.htmlform_settings_broker_edit.submit();", "Edit Broker Settings");</script>
		  </li>
        </UL>
      </TD>
    </TR>
    <TR>
      <TD>
        <TABLE class="tableView">

%invoke wm.server.dispatcher.adminui:isBrokerConfigured%
  %ifvar BROKERCONFIGURATION equals('true')%
    %invoke wm.server.dispatcher.adminui:getBrokerSettings%
    
          <TR>
            <TD class="heading" colspan=2>Broker Connection</TD>
          </TR>
          <TR>
            <TH class="oddrow" scope="row">Broker Host</TH>
            <TD class="oddrowdata-l">%value brokerHost encode(html)%</TD>
          </TR>
          <TR>
            <TH class="evenrow" scope="row">Broker Name</TH>
            <TD class="evenrowdata-l">%value brokerName encode(html)%</TD>
          </TR>
          <TR>
            <TH class="oddrow" scope="row">Client Group</TH>
            <TD class="oddrowdata-l">%value clientGroupName encode(html)%</TD>
          </TR>
          <TR>
            <TH class="evenrow" scope="row">Client Prefix</TH>
            <TD class="evenrowdata-l">%value CLIENTPREFIX encode(html)%</TD>
          </TR>
          <TR>
            <TH class="oddrow" scope="row">Share Client Prefix</TH>
            <TD class="oddrowdata-l"> %ifvar isISClustered equals('true')% Yes %else% %ifvar isClientPrefixShared equals('true')% Yes %else% No %endif% %endif% </TD>
          </TR>
          <TR>
            <TH class="evenrow" scope="row">Client Authentication</TH>
            
            %ifvar clientAuth equals('none')%
            <TD class="evenrowdata-l">None</TD>
        %endif%

            %ifvar clientAuth equals('ssl')%
            <TD class="evenrowdata-l">SSL</TD>
        %endif%
            
            %ifvar clientAuth equals('basic')%
            <TD class="evenrowdata-l">Username/Password</TD>
        %endif%
            
          </TR>
          <TR>
            <TH class="oddrow" scope="row">Connected</TH>
            <TD class="oddrowdata-l"> %ifvar isConnected equals('true')% Yes %else% No %endif% </TD>
          </TR>
                        
      %ifvar action equals('edit')%
      %else%
        %ifvar -notempty lastError%
    
          <tr>
            <td colspan=2 class="padding">&nbsp;</td>
          </tr>
          <TR>
            <TD class="message" colspan=2>Unable to connect to Broker: %value lastError encode(html)%</TD>
          </TR>
    
        %endif%
      %endif%
    %endinvoke%
  %else%
    
          <TR>
            <TD class="heading" colspan=2>General</TD>
          <TR>
            <TH class="oddrow" scope="row">Broker Configuration</TH>
            <TD class="oddrowdata-l">Not Configured</TD>
          </TR>

  %endif%
  
        %ifvar isUpdated equals('true')%
          <tr>
            <td class="subheading" colspan=4> 
              * Settings have been modified. Server restart is required.
            </td>
          </tr>
        %endif%     
  
  
%endinvoke%

         
        </TABLE>
      </td>
    </TR>
    <tr>
      <TD><IMG SRC="images/blank.gif" height=10 width=10></TD>
      <td>
        <TABLE class="tableView">
          <TR>
            
          </TR>
        </table>
      </td>
    <tr>
  </TABLE>
</BODY>
</HTML>
