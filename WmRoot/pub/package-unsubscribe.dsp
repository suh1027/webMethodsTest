<HTML>
  <HEAD>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <TITLE>Package Exchange</TITLE>
    <SCRIPT SRC="webMethods.js"></SCRIPT>
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    %ifvar webMethods-wM-AdminUI%
      <link rel="stylesheet" TYPE="text/css" HREF="webMethods-wM-AdminUI.css"></link>
      <script>webMethods_wM_AdminUI = 'true';</script>
    %endif%
  </HEAD>

  <BODY onLoad="setNavigation('package-subscribing.dsp', 'doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Packages_UpdateUnsubRemotePkgScrn');">
    <TABLE width=100%>
      <TR>
        <TD class="breadcrumb" colspan=2>
            Packages &gt;
            Subscribing &gt;
            Update and Unsubscribe
        </TD>
      </TR>

%ifvar action equals('unsub')%
  %invoke wm.server.replicator.adminui:subscriptionCancel%
    %ifvar message%
      <tr><td colspan="2">&nbsp;</td></tr>
      <TR>
        <TD class="message" colspan=2>%value message encode(html)%</TD>
      </TR>
    %endif%
  %endinvoke%
%endif%

        <TR>
            <TD colspan=2>
                <UL class="listitems">
					<script>
					createForm("htmlform_package_subscribing", "package-subscribing.dsp", "POST", "BODY");
					setFormProperty("htmlform_package_subscribing", "refresh", "true");
					</script>
                    <li>
					<script>getURL("package-subscribing.dsp?refresh=true", "javascript:document.htmlform_package_subscribing.submit();", "Back to Subscribing");</script>
					</li>
                </UL>
            </TD>
        </TR>
  %invoke wm.server.packages:packageList%
        <TR>
            <TD valign=top>
                <TABLE class="tableView">
                  <TR>
                    <TD class="heading" colspan=3>Available Subscriptions</TD>
                  </TR>

            %invoke wm.server.replicator:subscribedList%
      %ifvar subscribed%
            %loop subscribed%
                    <TR>
                        <TD class="subHeading" colspan=3>Publisher: %value publisher encode(html)%</TD>
                    </TR>

                    <TR>
                        <TH class="oddcol">Package Name</TH>
                        <TH class="oddcol">Update</TH>
                        <TH class="oddcol">Unsubscribe</TH>
                    </TR>

                    <script>resetRows();</script>

                 %ifvar remote equals('no')%
                    %ifvar packageList%
                        %loop packageList%
                        <TR>
                        <script>writeTD("rowdata-l");</script>
                            %value encode(html)%</TD>
                        <script>writeTD("rowdata");</script>
							<script>
							createForm("htmlform_package_edit_subscription_%value $index%", "package-edit-subscription.dsp", "POST", "BODY");
							setFormProperty("htmlform_package_edit_subscription_%value $index%", "hostport", "%value publisher%");
							setFormProperty("htmlform_package_edit_subscription_%value $index%", "package", "%value%");
							</script>
							<script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<A HREF="javascript:document.htmlform_package_edit_subscription_%value $index%.submit();">Edit</A>');
								} else {
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<A HREF="package-edit-subscription.dsp?hostport=%value publisher encode(url)%&package=%value encode(url)%&webMethods-wM-AdminUI=true">Edit</A>');
									}
									else {
										document.write('<A HREF="package-edit-subscription.dsp?hostport=%value publisher encode(url)%&package=%value encode(url)%">Edit</A>');
									}
								}
							</script>
                        	
                            </TD>
                        <script>writeTD("rowdata");</script>
							<script>
							createForm("htmlform_package_unsubscribe_%value $index%", "package-unsubscribe.dsp", "POST", "BODY");
							setFormProperty("htmlform_package_unsubscribe_%value $index%", "action", "unsub");
							setFormProperty("htmlform_package_unsubscribe_%value $index%", "package", "%value%");
							setFormProperty("htmlform_package_unsubscribe_%value $index%", "hostport", "%value publisher%");
							</script>
							<script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<a href="javascript:document.htmlform_package_unsubscribe_%value $index%.submit();"><IMG                           SRC="icons/delete.png" alt="Unsubscribe from package %value encode(url)%" BORDER=0></A>');
								} else {
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<a href="package-unsubscribe.dsp?action=unsub&package=%value encode(url)%&hostport=%value publisher encode(url)%&webMethods-wM-AdminUI=true"><IMG  SRC="icons/delete.png" alt="Unsubscribe from package %value encode(url)%" BORDER=0></A>');
									}
									else {
										document.write('<a href="package-unsubscribe.dsp?action=unsub&package=%value encode(url)%&hostport=%value publisher encode(url)%"><IMG  SRC="icons/delete.png" alt="Unsubscribe from package %value encode(url)%" BORDER=0></A>');
									}
								}
							</script>
                            
                        </TD>
                        </TR>
                        <script>swapRows();</script>
                        %endloop%
                    %else%
                        <tr><td class="oddcol">No packages.</td></tr>
                    %endif%
                %else%
                    %ifvar packageList%
                        %loop packageList%
                        <TR>
                        <script>writeTD("rowdata-l");</script>
                            %value encode(html)%</TD>
                        <script>writeTD("rowdata");</script>

                            Not Available
                            </TD>
                        <script>writeTD("rowdata");</script>
							<script>
							createForm("htmlform_package_unsubscribe_1_%value $index%", "package-unsubscribe.dsp", "POST", "BODY");
							setFormProperty("htmlform_package_unsubscribe_1_%value $index%", "action", "unsub");
							setFormProperty("htmlform_package_unsubscribe_1_%value $index%", "package", "%value%");
							setFormProperty("htmlform_package_unsubscribe_1_%value $index%", "hostport", "%value publisher%");
							</script>
							<script>
								if(is_csrf_guard_enabled && needToInsertToken) {
									document.write('<a href="javascript:document.htmlform_package_unsubscribe_1_%value $index%.submit();"><IMG                            SRC="icons/delete.png" alt="Unsubscribe from package %value encode(url)%" BORDER=0></A>');
								} else {
									var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
									if (webMethodswMAdminUI || '%value webMethods-wM-AdminUI encode(javascript)%') {
										document.write('<a href="package-unsubscribe.dsp?action=unsub&package=%value encode(url)%&hostport=%value publisher encode(url)%&webMethods-wM-AdminUI=true"><IMG  SRC="icons/delete.png" alt="Unsubscribe from package %value encode(url)%" BORDER=0></A>');
									}
									else {
										document.write('<a href="package-unsubscribe.dsp?action=unsub&package=%value encode(url)%&hostport=%value publisher encode(url)%"><IMG  SRC="icons/delete.png" alt="Unsubscribe from package %value encode(url)%" BORDER=0></A>');
									}
								}
							</script>
                            
                        </TD>
                        </TR>
                        <script>swapRows();</script>
                        %endloop%
                    %else%
                        <tr><td class="oddcol">No packages.</td></tr>
                    %endif%
                %endif%
                %endloop%
                %else%
                <tr><td colspan="3" class="oddcol">No subscriptions.</td></tr>
                %end if%

            %endinvoke%

                </table>
            </td>
        </tr>
    </table>
  </body>
</html>
