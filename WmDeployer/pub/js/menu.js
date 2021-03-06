// Copyright (c) 2004-2020 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.

var previousMenuImage;

function adapterMenuClick(url, help){
  moveArrow(url);
  document.forms["urlsaver"].helpURL.value = help;
  return false;
}

function tdClick(thisTD, id)
{
  alert(thisTD.all);
  thisTD.all[id].click();
}

function menuClick(url, target) {


  switch (target) {
    case "rightFrame":
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

  if (target=="rightFrame")
  	moveArrow(url);

}

function IE() {
	if (navigator.appName == "Microsoft Internet Explorer")
		return true;
	return false;

}

function menuMouseOver(object, id) {
	menuext.mouseOver(object, id, selected);
}

function menuMouseOut(object, id) {
	menuext.mouseOut(object, id, selected);
}


function setMenuItem(rootid, bgcolor, color) {
    /* the td element */
    var tdobj = document.getElementById(rootid);
    tdobj.style.backgroundColor = bgcolor;

    /* the a element within the td element above */
    var aobj = document.getElementById(rootid);
    aobj.children[0].firstElementChild.style.color = color;  
}

function defaultSelectedColor() {
	document.getElementById("Projects").style.backgroundColor = "rgb(23, 118, 191)";
	var aobj = document.getElementById("Projects");
	aobj.children[0].firstElementChild.style.color = "#fff";
	selected = "Projects";
}

(function(exports) {
	  exports.select = function(object, id, selected) {
	    if (selected != null) {
	        setMenuItem(selected, "#fff", "#2e5e83");
	    }
	    setMenuItem(id, "rgb(23, 118, 191)", "#fff");
	    window.status = id;
	    return id;
	  };

	  exports.mouseOver = function(object, id, selected) {
		  if (id != selected) {
	        setMenuItem(id, "#cde6f9", "#333");
	    }
	    window.status = id;
	  };

	  exports.mouseOut = function(object, id, selected) {
	    if (id != selected) {
	        setMenuItem(id, "#fff", "#2e5e83");
	    }
	    window.status = "";
	  };
	})(this.menuext = {});

/*function moveArrow(item)
{
  if(previousMenuImage != null) previousMenuImage.src="images/blank.gif";
  var temp = previousMenuImage;
  previousMenuImage=document.images[item];
  if(previousMenuImage == null) previousMenuImage = temp;
  previousMenuImage.src="images/selectedarrow.gif";
}*/


function initMenu(firstImage)
{
	previousMenuImage = document.images[firstImage];
	previousMenuImage.src="images/selectedarrow.gif";
	return true;
}
