/*
 * Copyright ｩ 1996 - 2019 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
*/
      
function filterServicesInternal(){
    var pfilter = document.getElementById("filterTask");
    pfilter.value = trim(pfilter.value);
    var filterCri = pfilter.value;
    if(pfilter.value.length==0){
    filterCri ="*";
    }
    var status = document.getElementById("statusActive").checked;
    var head= document.getElementById("head");
    var rowDisplayCount =0;
    var totalRows = 0;
    var rowCount = head.rows.length ;
    var row=0;
    for(ii=2; ii<rowCount; ii++){
    row = head.rows[ii];
    if (row.cells[1] != null && row.cells[1].innerHTML != "Service"){
            totalRows++;
        var source = row.cells[1].lastElementChild.value;

        if(isEqual(source,filterCri, false)){
        
                if(!status || (status && row.cells[9] !=null) && (trim(ReplaceTags(row.cells[9].innerHTML))=="Active" || ReplaceTags(row.cells[9].innerHTML)=="Running")){
                row.style.display="";
                rowDisplayCount++;
            }else{
                row.style.display="none";               
            }
        } else {
            row.style.display="none";
        }

    }else{
        continue;
    }
    }
   document.getElementById("result").innerHTML="<span style='font-weight:bold'>Showing " + rowDisplayCount + " of " + totalRows + "</span>"
}    


function showFilterPanel(){
        var filtercontainer = document.getElementById("filterContainer");
        var showall = document.getElementById("showall");
        var showfew = document.getElementById("showfew");
        showall.style.display="";
        showfew.style.display="none";
        filtercontainer.style.display="";
        document.getElementById("filterTask").focus();

      }

var regExp = /<\/?[^>]+>/g;
function ReplaceTags(xStr){
xStr = xStr.replace(regExp,"");
return xStr;
}

function trim(a){
        return a.replace(/^\s+|\s+$|\n+$/gm, '');

}

function filterServices(evt){
    var e = evt? evt : window.event;
    if(e.keyCode==13) {
      refreshAndFilter();
    }
}


function refreshAndFilter(){
    
    var pfilter = document.getElementById("filterTask");
    var status = document.getElementById("statusActive");
    if(is_csrf_guard_enabled && needToInsertToken) {
		createForm("htmlform_scheduler_filter", "scheduler.dsp", "POST", "BODY");
		setFormProperty("htmlform_scheduler_filter", "filterTask", pfilter.value);
		setFormProperty("htmlform_scheduler_filter", "statusActive", status.checked);
		setFormProperty("htmlform_scheduler_filter", "thisISOnly", thisISOnly.checked);
		setFormProperty("htmlform_scheduler_filter", "showAll", "true");
		setFormProperty("htmlform_scheduler_filter", _csrfTokenNm_, _csrfTokenVal_);
		document.htmlform_scheduler_filter.submit();
    } else {
    	var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
    	if (webMethodswMAdminUI) {
		  document.location.replace("scheduler.dsp?filterTask=" + pfilter.value + "&statusActive=" + status.checked + "&thisISOnly=" + thisISOnly.checked + "&showAll=true&webMethods-wM-AdminUI=true");
		}
		else {
		  document.location.replace("scheduler.dsp?filterTask=" + pfilter.value + "&statusActive=" + status.checked + "&thisISOnly=" + thisISOnly.checked + "&showAll=true");
		}
    }
      
}
     
function isEqual(source, target, regEx)
{

        if(regEx) 
        {
            var re = new RegExp(target);
            var match = source.match(re);
            return (match != null);
        } else 
        {
            var sourceCount = source.length;
            var sourceIndex = 0;
            var i=0;
            var c;
            var nextChar;
            var index, index1;
            var t; 
            var m;
            var n;
            var o;
                      
            for(;i<target.length;i++)
            {
                sourceCount = source.length;
                c = target.charAt(i);
                if(c=='*')
                {
                    if(i==target.length-1)
                    {
                        return true;
                    }
                    
                    t = target.substring(++i);  
                    m = t.indexOf("*");
                    n= t.indexOf("?");
                    
                    if(m == -1 && n == -1)
                    {
                        index = source.indexOf(t); 
                        //alert(t);
                    } else 
                    {
                     if(m==-1)
                     {
                        o=n;
                     } else if(n==-1)
                     {
                        o=m;
                     }else if(m<n)
                     {
                        o=m;
                     } else 
                     {
                        o=n;
                     }
                    nextChar = t.substring(0,o);
                        index = source.indexOf(nextChar);  
                        //alert("nextCharq " + nextChar);
                    }
                    if(index !=-1)
                    {
                        sourceIndex= index+1;
                        if(sourceIndex == sourceCount) 
                        { 
                            if(i==target.length-1) 
                            {
                                   return (true);
                                } else 
                                {
                                   return (target.charAt(i+1)=="*");
                                }
                        } 
                        source = source.substring(sourceIndex);
                        sourceIndex=0;
                    } else 
                    {
                        return false;
                    }
                } else if(c=='?')
                {
                    sourceIndex++;             
                } else 
                {
                    if(source.charAt(sourceIndex) != target.charAt(i))
                    {
                       //alert(source.charAt(sourceIndex)  + "!= "+ target.charAt(i));
                      return false;
                    } else 
                    {
                    sourceIndex++;
                        source = source.substring(sourceIndex);
                        sourceIndex=0;
                    }
                }
            }
            //alert(sourceIndex + "==" + source.length);
            if (target.length == 2)
                return (sourceIndex <= source.length);
            else
                return (sourceIndex == source.length);
        }
}
      
      var flag="both";
      function setFlag(m){
          flag = m;
      } 
      
      
      function redirectPage(action, oid)
      {
        var pfilter = document.getElementById("filterTask");
        var status = document.getElementById("statusActive");
        var webMethodswMAdminUI = getUrlParameter('webMethods-wM-AdminUI');
		var url= "scheduler.dsp?schaction=" + action + "&oid="+ oid + "&showAll=true&filterTask="+pfilter.value+"&statusActive="+status.checked;
		if (webMethodswMAdminUI) {
		  url += "&webMethods-wM-AdminUI=true";
		}
        if(is_csrf_guard_enabled && needToInsertToken) {
			
			createForm("htmlform_scheduler_filter_url", "scheduler.dsp", "POST", "BODY");
			setFormProperty("htmlform_scheduler_filter_url", "schaction", action);
			setFormProperty("htmlform_scheduler_filter_url", "oid", oid);
			setFormProperty("htmlform_scheduler_filter_url", "showAll", "true");
			setFormProperty("htmlform_scheduler_filter_url", "filterTask", pfilter.value);
			setFormProperty("htmlform_scheduler_filter_url", "statusActive", status.checked);
			setFormProperty("htmlform_scheduler_filter_url", _csrfTokenNm_, _csrfTokenVal_);
			document.htmlform_scheduler_filter_url.submit();
            
        } else {
            document.location.replace(url);
        }
        
      }
      
      
      
    
