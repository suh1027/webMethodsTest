/*
 * Copyright ? 1996 - 2017 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
*/
//*******************************
//
// Code for ACL Page
//
var groups = new Array();
var ACLs = new Array();
var Dirty = 0;
var previousACL;
var addingACL = false;

function quickSave(oTo, newValue)
{
    // not implement yet
}

function buildResultingUsers() {
    //******
    //clearList(userList);
    userBox.value = "";

    //*******
    //WHICH GROUPS FOR ALLOW
    var AllowGroups = new Array();
    for (var i = 0; i < allowList.length; ++i) 
    {
        AllowGroups[allowList.options[i].value] = 1;
    }

    //********
    //BUILD ALLOW ARRAY
    var AllowArray = new Array();
    for (groupID in AllowGroups)
    {
        if(groupID.indexOf('/') >0) 
        { 
            groupID = groupID.substring(groupID.indexOf('/')+1);
        }
        for (user in groups[groupID])
        {
            AllowArray[user] = user;
        }
    }

    //*******
    //WHICH GROUPS FOR DENY
    var DenyGroups = new Array();
    for (var i = 0; i < denyList.length; ++i) 
    {
        DenyGroups[denyList.options[i].value] = 1;
    }

    //********
    //BUILD DENY ARRAY
    var DenyArray = new Array();
    for (groupID in DenyGroups)
    {
        if(groupID.indexOf('/') >0) 
        { 
            groupID = groupID.substring(groupID.indexOf('/')+1);
        }

        for (user in groups[groupID])
        {
            DenyArray[user] = user;
        }
    }

    var resultingUsers = new Array();

    //*****
    //BUILDING RESULTING USERS
    //PRECIDENCE =  ALLOW
    //Everybody - Deny + Allow
    if (precedence.value == "allow")
    {
        for (user in groups["Everybody"])
        {
            if (DenyArray[groups["Everybody"][user]] == null)
            {
                resultingUsers[user] = user;
            }
        }
        for (user in AllowArray)
        {
            resultingUsers[user] = user;
        }
    }

    //*****
    //BUILDING RESULTING USERS
    //PRECIDENCE =  ALLOW
    //Nobody + Allow - Deny
    if (precedence.value == "deny")
    {
        for (user in AllowArray)
        {
            if (DenyArray[user] == null)
            {
                resultingUsers[user] = user;
            }
        }
    }
    
    //******
    //ADD TO WEB PAGE
    for (user in resultingUsers)
    {
        //var newoption = new Option(user, user);
        //userList.options[userList.length] = newoption;
        if (userBox.value == "")
            userBox.value = user;
        else
            userBox.value = userBox.value + ", " + user;
    }

    //ADD the ----NONE---- to Resulting Users (if empty)
    if (userBox.value == "")
        userBox.value = "----NONE----";
}

function moveitem (buttonPressed)  {
    Dirty++;
    
    var oFrom = null;
    var oTo = null;
    
    switch (buttonPressed) {
    case "addAllow":

        oFrom = groupList;
        oTo = allowList;
        break;

    case "removeAllow":
        oFrom = allowList;
        oTo = groupList;
        break;

    case "addDeny":
    oFrom = groupList;
    oTo = denyList;
    break;
    
    case "removeDeny":
    oFrom = denyList;
    oTo = groupList;
    break;

    case "left":
    if (groupList.selectedIndex > -1)
    {
            oFrom = groupList;
            oTo = allowList;
    }
    if (denyList.selectedIndex > -1)
    {
            oFrom = denyList;
            oTo = groupList;
    }
    break;

    case "right":
    if (allowList.selectedIndex > -1)
    {
            oFrom = allowList;
            oTo = groupList;
    }
    if (groupList.selectedIndex > -1)
    {
            oFrom = groupList;
            oTo = denyList;
    }

    break;

    default:
    alert ("This shouldn't happen.");
    break;
    } 

    if (oFrom == null || oTo == null)
        return false;

    moveItems(oFrom,oTo);

    buildResultingUsers();
}

function addGroup(group, users) {
    //Arrays must be "prepped" to be containainers of arrays.
    groups[group] = ["placeholder"]
    groups[group].length = 0
    
    for (user in users)
    {
        groups[group][users[user]] = users[user];
    }

}

function addACL(ACL, allowGroups, denyGroups) {
    //Arrays must be "prepped" to be containainers of arrays.
    ACLs[ACL] = ["placeholder"]
    ACLs[ACL].length = 0
    
    for (group in allowGroups)
    {
        ACLs[ACL][allowGroups[group]] = "allow";
    }

    for (group in denyGroups)
    {
        ACLs[ACL][denyGroups[group]] = "deny";
    }
}

function populateGroupList()
{
    clearList(groupList);

    for (group in groups)
    {
        insertOptionABC(group,group, groupList, false);
    }
}

function populateACLList()
{
    clearList(aclList);

    for (ACL in ACLs)
    {
        insertOption(ACL + " ACL",ACL, aclList, true);
    }
}

function loadACL(acl)    
{
    Dirty = 0;
    previousACL = acl;

    clearList(denyList);
    clearList(allowList);

    for (group in ACLs[acl])
    {
        
        if (ACLs[acl][group] == "allow")
        {
            insertOptionABC(group, group, allowList, false);
        }

        if (ACLs[acl][group] == "deny")
        {
            insertOptionABC(group,group, denyList, false);
        }
    }
    
    addNone(allowList);
    addNone(denyList);

    buildResultingUsers();
}

function saveACL(previousACL)
{

    for (index in ACLs[previousACL]){
        ACLs[previousACL][index]=null;
    }
    
    for (var i=0; i < allowList.length; i++)
    {
        if (allowList.options[i].value != "" && allowList.options[i].value != "---none--")
        {
            ACLs[previousACL][allowList.options[i].value] = "allow"
        }
    }        

    for (var i=0; i < denyList.length; i++)
    {
        if (denyList.options[i].value != "" && denyList.options[i].value != "---none--"){
            ACLs[previousACL][denyList.options[i].value] = "deny"
        }

    }        
}

function changeACL(acl)
{

    saveACL(previousACL);    
    loadACL(acl);

}


function insertACL()
{
    //Arrays must be "prepped" to be containainers of arrays.
    ACLs[newACL.value] = ["placeholder"];
    ACLs[newACL.value].length = 0;

    newACLname = newACL.value;

    if (newACLname == "")
    {
        alert("New ACL requires a name.");
        newACL.focus();
        return false;
    }

    var invalidItems = /\;|\:|\,|\s|\_|\<|\>|\@|\?|\#|\*|\&|\^|\~|\%|\!|\$/ig;
    if (newACLname.match(invalidItems))
    {
        alert("Invalid name for an ACL.  ACL names can only contain letters and numbers.");
        newACL.focus();
        return false;
    }

    for (var i=0; i< aclList.length; i++)
    {
        if (aclList.options[i].value.toLowerCase() == newACLname.toLowerCase())
        {
            alert("ACL name is already being used.");
            aclList.selectedIndex = i;
            changeACL(aclList.options[i].value);
            newACL.focus();
            return false;
        }
    }

    insertOptionABC(newACLname + " ACL",newACLname, aclList, true);

    clearList(denyList);
    clearList(allowList);
    addNone(allowList);
    addNone(denyList);
    //populateGroupList();
    buildResultingUsers();

    newACL.value = "";
}

function saveChanges()
{
    if (aclList.length > 0) saveACL(aclList.options[aclList.selectedIndex].value);

    var saveData = "";

    saveData += "";

    for (var i=0; i < aclList.length; i++)
    {
        acl = aclList.options[i].value;
        saveData += "" + acl + ";";

        var allowSection = "";
        var denySection = "";

        for (group in ACLs[acl])
        {
            if (ACLs[acl][group] == "allow")
                allowSection += "" + group + ",";
            if (ACLs[acl][group] == "deny")
                denySection += "" + group + ",";
        }
        saveData += "" + allowSection + ";";
        saveData += "" + denySection + ":";
        saveData += "";
    }
    saveData += "";
    hiddenSave.value = saveData;
    hiddenAction.value = "update";
}

function submitForm()
{
    if (addingACL)
    {
        insertACL();
        return false;
    }
    Dirty = 0;
    return true;
}

function checkDirty () {
    if (Dirty > 0)
    {
        event.returnValue = '--- ACL changes have not been saved. ---';
    }
}

function removeACL()
{
    if (aclList.length > 0)
    {    
        ACLtoRemove = aclList.options[aclList.selectedIndex].value
        if (confirm("Are you sure you want to remove " + ACLtoRemove + "?"))
        {
            aclList.options[aclList.selectedIndex] = null;
            if (aclList.length > 0)
            {
                aclList.selectedIndex = 0;
                changeACL(aclList.options[0].value);
            }
            else
            {
                changeACL("");
            }
            
            for (var i=0; i < groupList.length; i++)
            {
                ACLs[ACLtoRemove][groupList.options[i].value] = ""
            }        
        }
    }
}

function insertGroup(oTo, group)
{
    Dirty++;
    //REMOVE the ----NONE----
    if (oTo.options[0].value == "---none--")
    {
        oTo.options[0] = null;
    }
    insertOptionABC(group,group, oTo, false);
    quickSave(oTo, group);
    buildResultingUsers();
}

function removeGroup(fromList){
    Dirty++;
    if (fromList.selectedIndex > -1)
    {
        groupToRemove = fromList.options[fromList.selectedIndex].value
        removeOption(groupToRemove, fromList);
        fromList.options[fromList.selectedIndex] = null;
        if (fromList.options[0]==null){
            var newoption = new Option("-----none-----", "---none--" );
            fromList.options[0] = newoption;
        }
        quickSave(fromList, group);
        buildResultingUsers();        
    }
}

function setupPage()
{
    populateACLList();
    aclList.selectedIndex = 0;
    loadACL(aclList.options[aclList.selectedIndex].value);
    buildResultingUsers();
}
