<HTML><HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Expires" content="-1">
<LINK href="css/webMethods.css" type="text/css" rel="stylesheet">
<LINK href="css/xtree.css" type="text/css" rel="stylesheet">
<SCRIPT src="js/webMethods.js"></SCRIPT>
<SCRIPT src="js/xtree.js"></SCRIPT>
<BODY>

<SCRIPT language=JavaScript>
</SCRIPT>

<TABLE width="100%" class="tableView">
    <TR>
      <TD class="menusection-Deployer" colspan="2">%value mapSetName% > Configurable Assets</TD>
    </TR>
</TABLE>

<TABLE width="100%" class="errorMessage">
	<TR>
	<script>writeWarning("Previously substituted values will not be shown here. To view the old values, please go to 'Configure Build by Servers'");
  </script>
		<TD colspan="2">
			<UL>
         <LI><A href="javascript:parent.document.location.reload()">Refresh this Page</A>
         <LI><A onclick="startProgressBar();" href="varsub-server-manager.dsp?projectName=%value projectName%&mapSetName=%value mapSetName%&mapSetDescription=%value mapSetDescription%" target="_blank">Configure Build By Servers</A></LI>
			</UL>
		</TD>
	</TR>

	<TR>
		<TD><IMG height="0" src="images/blank.gif" width="5" border="0"></TD>
		<TD>
			<TABLE class="tableView" width="100%">
				<TR>
					<TD class="heading" colspan=2>Configurable Assets</TD>
				</TR>

				<SCRIPT> resetRows(); </SCRIPT>
			
	
		<!-- projectName* deploymentSetName -->
		%invoke wm.deployer.gui.UIProject:getProjectBundleNames%
		<SCRIPT>
			var deploymentSetTree = new WebFXTree("Deployment Sets");
		</SCRIPT>
		%ifvar bundles -notempty%
				<TR>
					<SCRIPT> writeTD("col-l"); </SCRIPT> 
						Click on a tree object to view its source configuration and optionally substitute values on the target server.  </TD>
				</TR>
		<SCRIPT> swapRows(); </SCRIPT>
				<TR>
					<SCRIPT> writeTD("rowdata-l");</SCRIPT> 
		%loop bundles%
			%rename ../projectName projectName -copy%
			%rename bundleName deploymentSetName -copy%
			%rename ../mapSetName mapSetName -copy%
			%invoke wm.deployer.gui.UIVarsub:listVarSubItems%
				%ifvar items -notempty% 

					<SCRIPT>
						var items = new WebFXTreeItem("Deployment Set '%value bundleName%'");
						var serverList = new Array;
						var serverTreeList = new Array;
						var taskTreeList = new Array;
						var portTreeList = new Array;
						var extTreeList = new Array;
						var webServicesList = new Array;
						var packageList = new Array;
						var packageTreeList = new Array;

						// Array to hold the serverAlias:objectType Tree nodes
						var objectList = new Array;
						var objectTreeList = new Array;
						
						// Populate the complete list of source servers for later usage
						%loop items%
							var serverTree = getServerTree("%value sourceServerAlias%", serverList, serverTreeList);
							if (serverTree == null) {

								// Add this Server Node to the main search list 
								serverList[serverList.length] = "%value sourceServerAlias%";

								// Create tree node for server, add to List, and attach it to main tree
								var serverTree = new WebFXTreeItem("%value sourceServerAlias%", null, null, 
									webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
								serverTreeList[serverTreeList.length] = serverTree;
								items.add(serverTree);

								// Create Scheduled Task tree node but don't add it yet
								var taskTree = new WebFXTreeItem("Scheduled Tasks");
								taskTreeList[taskTreeList.length] = taskTree;

								// Create Port tree node but don't add it yet
								var portTree = new WebFXTreeItem("Ports");
								portTreeList[portTreeList.length] = portTree;

								// Create Extended Settings tree node but don't add it yet
								var extTree = new WebFXTreeItem("Extended Settings");
								extTreeList[extTreeList.length] = extTree;

								// Create Web Services tree node but don't add it yet
								var webServiceTree = new WebFXTreeItem("Web Service Descriptor");
								webServicesList[webServicesList.length] = webServiceTree;
								
								// Object Type folder node
								var objectTree = getServerTree("%value sourceServerAlias%:%value type%", objectList, objectTreeList);
								if (objectTree == null) {
									// Add this Object Node to the list
									objectList[objectList.length] = "%value sourceServerAlias%:%value type%";

									// Create tree node for this object type, add to List, but don't add it yet
									objectTree = new WebFXTreeItem("%value label%");
									objectTreeList[objectTreeList.length] = objectTree;
								}
							}

							// For stuff in Packages, build a unique Package List
							%ifvar packageName -notempty%
								var packageTree = getServerTree("%value sourceServerAlias%:%value packageName%", 
									packageList, packageTreeList);
								if (packageTree == null) {

									// Add this Server Node to the main search list 
									packageList[packageList.length] = "%value sourceServerAlias%:%value packageName%";

									// Create node for Package and add to treeList
									var packageTree = new WebFXTreeItem("%value packageName%", null, null, 
										webFXTreeConfig.ISPackage, webFXTreeConfig.ISPackage);
									packageTreeList[packageTreeList.length] = packageTree;

									// Find server node and attach here
									var serverTree = getServerTree("%value sourceServerAlias%", serverList, serverTreeList);
									serverTree.add(packageTree);
								}
							%endif%
						%endloop%

						// Now iterate through and attach as necessary
						%loop items%
							var serverTree = getServerTree("%value sourceServerAlias%", serverList, serverTreeList);
						%ifvar pluginType equals('IS')%							
							%switch type% 
							%case 'ScheduledService'%								
								var taskTree = getServerTree("%value sourceServerAlias%", serverList, taskTreeList);
								if (taskTree.parentNode == null)
									serverTree.add(taskTree);
									
								var node = new WebFXTreeItem("%value service%", "varsub-edit-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&service=%value service%&key=%value taskId%&pluginType=%value pluginType%&varSubItemType=%value type%", 
									null, webFXTreeConfig.ISTask, webFXTreeConfig.ISTask, webFXTreeConfig.propertyClass,"propertyFrame");
								taskTree.add(node);

							%case 'Port'%
								var portTree = getServerTree("%value sourceServerAlias%", serverList, portTreeList);
								if (portTree.parentNode == null)
									serverTree.add(portTree);
									
								var node = new WebFXTreeItem("%value -code name%", 
				"varsub-edit-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&key=%value -code name%&pluginType=%value pluginType%&varSubItemType=%value type%", 
									null, webFXTreeConfig.ISPort, webFXTreeConfig.ISPort, webFXTreeConfig.propertyClass);
								portTree.add(node);

							%case 'ExtendedSettings'%
								var extTree = getServerTree("%value sourceServerAlias%", serverList, extTreeList);
								if (extTree.parentNode == null)
									serverTree.add(extTree);
									
								var node = new WebFXTreeItem("%value name%", "varsub-edit-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&key=%value name%&pluginType=%value pluginType%&varSubItemType=%value type%", 
									null, webFXTreeConfig.ISExtended, webFXTreeConfig.ISExtended, webFXTreeConfig.propertyClass);
								extTree.add(node);
								
							%case 'webServiceDescriptor'%
								var webServiceTree = getServerTree("%value sourceServerAlias%", serverList, webServicesList);								
								if (webServiceTree.parentNode == null)
									serverTree.add(webServiceTree);

								var node = new WebFXTreeItem("%value Name%", "varsub-edit-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&key=%value Name%&pluginType=%value pluginType%&varSubItemType=%value type%&packageName=%value packageName%", 
									null, webFXTreeConfig.ISWSD, webFXTreeConfig.ISWSD, webFXTreeConfig.propertyClass);
								webServiceTree.add(node);

							%case 'AdapterConnection'%
								var packageTree = getServerTree("%value sourceServerAlias%:%value packageName%", 
									packageList, packageTreeList);

								var node = new WebFXTreeItem("%value name%", 
				"varsub-edit-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&key=%value name%&varSubItemType=%value type%&pluginType=%value pluginType%&packageName=%value packageName%", 
								null, getNSIcon("%value type%"), getNSIcon("%value type%"), webFXTreeConfig.propertyClass);
								packageTree.add(node);
								
							%case 'AdapterNotification'%
								var packageTree = getServerTree("%value sourceServerAlias%:%value packageName%", 
									packageList, packageTreeList);

								var node = new WebFXTreeItem("%value name%", 
				"varsub-edit-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&key=%value name%&varSubItemType=%value type%&pluginType=%value pluginType%&packageName=%value packageName%", 
								null, getNSIcon("%value type%"), getNSIcon("%value type%"), webFXTreeConfig.propertyClass);
								packageTree.add(node);
								
							%case 'AdapterListener'%
								var packageTree = getServerTree("%value sourceServerAlias%:%value packageName%", 
									packageList, packageTreeList);

								var node = new WebFXTreeItem("%value name%", 
				"varsub-edit-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&key=%value name%&varSubItemType=%value type%&pluginType=%value pluginType%&packageName=%value packageName%", 
								null, getNSIcon("%value type%"), getNSIcon("%value type%"), webFXTreeConfig.propertyClass);
								packageTree.add(node);									
							%endswitch% 

						%else% 
							// Generic plugin types now
							var objectTree = getServerTree("%value sourceServerAlias%:%value type%", objectList, objectTreeList);
							if (objectTree.parentNode == null)
									serverTree.add(objectTree);
									
							var node = new WebFXTreeItem("%value name%", "varsub-edit-page.dsp?projectName=%value ../projectName%&deploymentMapName=%value ../mapSetName%&deploymentSetName=%value ../bundleName%&sourceServerAlias=%value sourceServerAlias%&key=%value name%&pluginType=%value pluginType%&varSubItemType=%value type%", 
									null, "%value typeIcon%", "%value typeIcon%", webFXTreeConfig.propertyClass);
								objectTree.add(node);
						%endif%	
						%endloop%
						deploymentSetTree.add(items);
						
					</SCRIPT>
					%endif%
				%endinvoke%
	%endloop bundles%
		<SCRIPT>
		w(deploymentSetTree);
		</SCRIPT>
	</TD>
				</TR>
			%else% 
				<TR>
					<SCRIPT> writeTD("row-l"); </SCRIPT> <FONT color="red"> * No configurable assets </FONT> </TD>
				</TR>
			%endif% 
		%endinvoke getProjectBundleNames%
				
			</TABLE>
		</TD>
	</TR>

</TABLE>
</BODY>
</HTML>
