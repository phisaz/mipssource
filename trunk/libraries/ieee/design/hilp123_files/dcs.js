var gImages=new Array;
var gIndex=0;
var DCS=new Object();
var WT=new Object();
var DCSext=new Object();

var gDomain="dcs.etrade.com";
var gDcsId="";

if (gDcsId==""){
	var gTagPath=gDomain;
}
else{
	var gTagPath=gDomain+"/"+gDcsId;
}
function getParameter(parameterName)
{
queryString = document.URL.toUpperCase();
 var parameterName = parameterName + "=";
 if ( queryString.length > 0 )
 {
  begin = queryString.indexOf ( parameterName );
  if ( begin != -1 && (queryString.substring ( begin -1, begin ) == '?' || queryString.substring ( begin -1, begin ) == '&'))
  {
   begin += parameterName.length;
   end = queryString.indexOf ( "&" , begin );
   if ( end == -1 )
   {
    end = queryString.length
   }
  return unescape ( queryString.substring ( begin, end ) );
  }
 return "false";
 }
}

var isCampaign = false;
function CheckUrlValues()
{
	var urlSearchAry = new Array("SC","TB","SOURCE","P","CUSTOMERID");
	for (i=0; i<urlSearchAry.length;i++)
	{
		var val = getParameter(urlSearchAry[i]);
		if(val != "false")
		{
			isCampaign = true;
			return val
		} 
	}
	if(!isCampaign)
	{
		return "no_mc";
	}
}

function getcookie(cookiename) 
{
 var cookiestring=""+document.cookie;
 var index1=cookiestring.indexOf(cookiename);
 if (index1==-1 || cookiename=="") return "";
 var index2=cookiestring.indexOf(';',index1);
 if (index2==-1) index2=cookiestring.length;
 return unescape(cookiestring.substring(index1+cookiename.length+1,index2));

}

function dcsVar(){
	var dCurrent=new Date();
	var urlTest = CheckUrlValues();
	if(urlTest != "no_mc")
	{
		WT.mc_n = urlTest;
	} 
	
	if(typeof userType == "string")
	{
		if(userType.toUpperCase != "VISITOR")
		{
			DCSext.login="LoggedIn";
		}
	}
	
	DCSext.WTRS_ID = getcookie("WRC_ID");
	
	WT.tz=dCurrent.getTimezoneOffset()/60*-1;
	WT.bh=dCurrent.getHours();
	WT.ul=navigator.appName=="Netscape"?navigator.language:navigator.userLanguage;
	if (typeof(screen)=="object"){
		WT.cd=screen.colorDepth;
		WT.sr=screen.width+"x"+screen.height;
	}
	if (typeof(navigator.javaEnabled())=="boolean"){
		WT.jo=navigator.javaEnabled()?"Yes":"No";
	}
	WT.ti=document.title;
	WT.js="Yes";
	if (typeof(gVersion)!="undefined"){
		WT.jv=gVersion;
	}
	WT.sp="";
	DCS.dcsuri=window.location.pathname;
	DCS.dcsqry=window.location.search;
	if ((window.document.referrer!="")&&(window.document.referrer!="-")){
		if (!(navigator.appName=="Microsoft Internet Explorer"&&parseInt(navigator.appVersion)<4)){
			DCS.dcsref=window.document.referrer;
		}
	}
	DCS.dcssip=window.location.hostname;
	DCS.dcsdat=dCurrent.getTime();
}

function A(N,V){
	return "&"+N+"="+escape(V);
}

function dcsCreateImage(dcsSrc){
	if (document.images){
		gImages[gIndex]=new Image;
		gImages[gIndex].src=dcsSrc;
		gIndex++;
	}
	else{
		document.write('<IMG BORDER="0" NAME="DCSIMG" WIDTH="1" HEIGHT="1" SRC="'+dcsSrc+'">');
	}
}

function dcsMeta(){
	var myDocumentElements;
	if (document.all){
		myDocumentElements=document.all.tags("meta");
	}
	else if (document.documentElement){
		myDocumentElements=document.getElementsByTagName("meta");
	}
	if (typeof(myDocumentElements)!="undefined"){
		for (var i=1;i<=myDocumentElements.length;i++){
			myMeta=myDocumentElements.item(i-1);
			if (myMeta.name){
				if (myMeta.name.indexOf('WT.')==0){
					WT[myMeta.name.substring(3)]=myMeta.content;
				}
				else if (myMeta.name.indexOf('DCSext.')==0){
					DCSext[myMeta.name.substring(7)]=myMeta.content;
				}
				else if (myMeta.name.indexOf('DCS.')==0){
					DCS[myMeta.name.substring(4)]=myMeta.content;
				}
			}
		}
	}
}

function dcsMultiTrack(){
	for (var i=0;i<arguments.length;i++){
		if (arguments[i].indexOf('WT.')==0){
				WT[arguments[i].substring(3)]=arguments[i+1];
				i++;
		}
		if (arguments[i].indexOf('DCS.')==0){
				DCS[arguments[i].substring(4)]=arguments[i+1];
				i++;
		}
		if (arguments[i].indexOf('DCSext.')==0){
				DCSext[arguments[i].substring(7)]=arguments[i+1];
				i++;
		}
	}
	var dCurrent=new Date();
	DCS.dcsdat=dCurrent.getTime();
	dcsTag(gTagPath);	
}

function dcsTag(TagImage){
	var P="http"+(window.location.protocol.indexOf('https:')==0?'s':'')+"://"+TagImage+"/dcs.gif?";
	for (N in DCS){
		if (DCS[N]) {
			P+=A(N,DCS[N]);
		}
	}
	for (N in WT){
		if (WT[N]) {
			P+=A("WT."+N,WT[N]);
		}
	}
	for (N in DCSext){
		if (DCSext[N]) {
			P+=A(N,DCSext[N]);
		}
	}
	if (P.length>2048&&navigator.userAgent.indexOf('MSIE')>=0){
		P=P.substring(0,2040)+"&WT.tu=1";
	}
	dcsCreateImage(P);
}

dcsVar();
dcsMeta();
dcsTag(gTagPath);
