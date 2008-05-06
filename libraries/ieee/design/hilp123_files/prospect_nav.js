
function prospectMakeNav(mainTab,selSubTab,contID) {
  var mainTab = mainTab;
  if (mainTab.toUpperCase() == "HOME") { mainTab = ""; }
  if (mainTab.toUpperCase() == "WELCOME"  && famSelTab == "Why Choose E*TRADE\?") { mainTab = "WHY CHOOSE E*TRADE\?"; }
  var navCont = document.getElementById(contID);
  var strNavCnt=new strBuffer();
  strNavCnt.append("<ul>");
  var len=navLen+1;
  var i=0;
  var useNormStr = false;
  var refURL = getRefURL(mainTab,selSubTab);
  while (--len) {
    if (mainTab==mainNav[i].tabName) {
      strNavCnt.append("<li>");
      if (mainNav[i].brdClass != null && mainNav[i].brdClass != "")
        strNavCnt.append("<a class=\"navSel" + mainNav[i].brdClass + "\" href=\"" + ETRADE +  mainNav[i].url + "\"><span class=\"s2\" onmouseover=\"this.style.cursor='pointer';\">" + mainNav[i].tabName + "<div class=\"whtLn\"></div></span></a>");
      else
        strNavCnt.append("<a class=\"navSel\" href=\"" + ETRADE + mainNav[i].url + "\"><span class=\"s2\" onmouseover=\"this.style.cursor='pointer';\">" + mainNav[i].tabName + "<div class=\"whtLn\"></div></span></a>");

if (mainTab != "WHY CHOOSE E*TRADE\?")
{
strNavCnt.append(makeSubNav(mainNav[i].subNav,selSubTab,mainNav[i].brdClass));
}

    } else {
      if (mainTab=="BANKING" || mainTab=="MORTGAGES & HOME EQUITY") {
        var sbArr = mainNav[i].url.split("/");  
		    if (sbArr.length == 4){sbArr[4]="";}
        (sbArr[3]=="banking" || sbArr[3]=="mortgageshomeequity" || sbArr[3]=="welcome" || sbArr[3]=="home" || sbArr[3]=="pricingandrates") ? useNormStr = true : useNormStr = false;
      } else useNormStr = true;
      if (useNormStr)
        strNavCnt.append("<li><a class=\"nav\" href=\"" + ETRADE + mainNav[i].url + "\"><span class=\"s1\" onmouseover=\"this.style.cursor='pointer';\">" + mainNav[i].tabName + "</span><div class=\"whtLn\"></div></a>");
      else {
        strNavCnt.append("<li><a class=\"nav\" href=\"/e/t/user/speedbump?target_app=" + sbArr[3] + "&target_page=" + sbArr[4] + "&hReferrer=" + refURL + "\"><span class=\"s1\" onmouseover=\"this.style.cursor='pointer';\">" + mainNav[i].tabName + "</span><div class=\"whtLn\"></div></a>");
      }
    }
    strNavCnt.append("</li>");
    i++;
  }
  strNavCnt.append("</ul>");
  strNavCnt.append("<div id=\"navLn\"><div id=\"navBrd\"></div></div>");
  navCont.innerHTML = strNavCnt.getBuffer();
}

function makeSubNav(objSubNav,selSubTab,brdClass) {
  var subLen = objSubNav.length+1;
  var ret = new strBuffer();
  if (brdClass != null)
    ret.append("<ul class=\"subNav" + brdClass + "\">");
  else
    ret.append("<ul class=\"subNav\">");
  var i=0;
  while (--subLen) {
    ret.append("<li>");
    var tabName = objSubNav[i].tabName;
    tabName = tabName.replace("Visa","Visa&reg;");
    (objSubNav[i].tabName==selSubTab) ? ret.append("<a class=\"sel\" href=\"" + ETRADE + objSubNav[i].url + "\">" + tabName + "</a>") : ret.append("<a href=\"" + ETRADE + objSubNav[i].url + "\">" + tabName + "</a>");
    ret.append("</li>");
    i++;
  }
  ret.append("</ul>");
  return ret.getBuffer();
}

function getRefURL(mainTab,selSubTab) {
  var ret="";
  var a;
  (mainTab=="BANKING") ? a = mainNav[6].subNav : a = mainNav[7].subNav;
  var len = a.length-1;
  if (selSubTab==null || selSubTab=="" || selSubTab=="MORTGAGES & HOME EQUITY") {
    (mainTab=="BANKING") ? ret = "/e/t/banking/banking" : ret = "/e/t/mortgageshomeequity/mortgageshomeequity";
  } else {
    for (var i=0;i<len;i++) {
      if (a[i].tabName==selSubTab) { 
        ret=a[i].url;
        return ret;
      }
    }
  }
  return ret; 
}

function updDisclosures() {
  var disc = document.getElementById("etDisclosures")
  if (document.getElementById("disclosures")) {
    disc.style.marginBottom = "1em";
    disc.innerHTML = document.getElementById("disclosures").innerHTML;
  }
  else {
    disc.style.marginBottom = "0"; 
  } 
}

function brkFrm() {
  var s = self.location.href;
  if (window.top != window.self) {
    window.top.location.href = s;
  }
}

function addLoadEvt(func) {
  var oldfunc = window.onload;
  if (typeof window.onload != "function") {
    window.onload = func;
  } else {
    window.onload = function() {
      oldfunc();
      func();
    }
  }
}

function strBuffer() {
  this.buffer = [];
}
strBuffer.prototype.append = function append(str) {
  this.buffer.push(str);
  return this;
}
strBuffer.prototype.getBuffer = function getBufText() {
  return this.buffer.join("");
}

function doQS(frm,act,el) {
  with (frm) {
    if (frm.elements[el].value != "" && frm.elements[el].value != null) {
      if (act.indexOf("/search/prospect") >= 0)
           action = SEARCH + act;  // redirect to clone instance
      else
           action = act;
      method="post";
      submit();
    }
  }
}
