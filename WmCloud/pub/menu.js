/*
 * Copyright ? 1996 - 2017 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. 
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. 
*/

var previousMenuImage;
var menuInit = false;

function adapterMenuClick(url, help){
  moveArrow(url);
  document.forms["urlsaver"].helpURL.value = help;
  return false;
}

function menuClick(url, target) {


  switch (target)
  {

    case "body":
  	  parent[target].window.location.href= url;
	  break;
    default:   
          window.open(url, target, "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes");
	  break;
  }

  menuMove(url, target);

  return false;
}


function menuMove(url, target) {

  if (target=="body")
  	moveArrow(url);

}

function IE() {
	if (navigator.appName == "Microsoft Internet Explorer")
		return true;
	return false;

}
function menuMouseOver(object, id) {
	object.style.background='#FFFFFF';
	window.status= id;
}
function menuMouseOut(object) {
	object.style.background='#F0ECDA';
	window.status='';

}

function moveArrow(item)
{
	if(menuInit)
	{
  		if(previousMenuImage != null) 
			previousMenuImage.src="/WmRoot/images/blank.gif";

  		var temp = previousMenuImage;
  		previousMenuImage=document.images[item];

  		if(previousMenuImage == null) 
			previousMenuImage = temp;

  		previousMenuImage.src="/WmRoot/images/selectedarrow.gif";
	}
}


function initMenu(firstImage)
{
	previousMenuImage = document.images[firstImage];
	previousMenuImage.src="/WmRoot/images/selectedarrow.gif";
	menuInit = true;
	return true;
}
