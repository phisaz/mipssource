var FlashVers = null,
	agt=navigator.userAgent.toLowerCase(),
	isMac=(agt.indexOf("mac")!=-1),
	dtime,
	utime,
	vmid,
	oMid,
	oIid = null,
	currDat = new Date();

//	Variables below are for Employee Stock Plan (OptionsLink)
var includesptab = "n";
if(getCookie("includesptab")!=""){
	includesptab=getCookie("includesptab").substring(1,getCookie("includesptab").length);
}
// End	of Employee Stock Plan (OptionsLink) variables


function encode(str) {
  var result = "", i = 0;

  for (; i < str.length; i++) {
	if (str.charAt(i) == " ") {
		result += "+";
	} else {
		result += str.charAt(i);
	}
  }

  return escape(result);
}


function etWin(url,windowName,sWidth,sHeight,toolbarYS,locationYS,scrollbarYS,menubarYS,resizeYS,
			  HorizPos,VertPos,server,bUseDefaults){
  var features;
  if(bUseDefaults==null){
	bUseDefaults=true;
  }

  if(!url){
	return;
  }


  //set window name, using window name _blank will execute window resize
  windowName = (bUseDefaults?(windowName?windowName:'ETpopUP'):(windowName?windowName:"_blank") );

  features =(bUseDefaults?"width="+(sWidth?sWidth:400)+",":(sWidth?"width="+sWidth+",":'')	)
		   +(bUseDefaults?"height="+(sHeight?sHeight:400)+",":(sHeight?"height="+sHeight+",":'')  )
		   +(bUseDefaults?"toolbar="+(toolbarYS?toolbarYS:1)+",":(toolbarYS?"toolbar="+toolbarYS+",":'')  )
		   +(bUseDefaults?"location="+(locationYS?locationYS:1)+",":(locationYS?"location="+locationYS+",":'')	)
		   +(bUseDefaults?"scrollbars="+(scrollbarYS?scrollbarYS:1)+",":(scrollbarYS?"scrollbars="+scrollbarYS+",":'')	)
		   +(bUseDefaults?"menubar="+(menubarYS?menubarYS:1)+",":(menubarYS?"menubar="+menubarYS+",":'')  )
		   +(bUseDefaults?"resizable="+(resizeYS?resizeYS:1)+",":(resizeYS?"resizable="+resizeYS+",":'')  )
		   +(bUseDefaults?"top="+(VertPos?VertPos:5)+",":(VertPos?"top="+VertPos+",":'')  )
		   +(bUseDefaults?"left="+(HorizPos?HorizPos:5)+",":(HorizPos?"left="+HorizPos+",":'')	)+"fullscreen=no";

  if(!server || url.substr(0,4) == "http"){
	  server="";
  }

  windowName=removeSpecialChar(windowName, "*");
  windowName=removeSpecialChar(windowName, " ");

  var rtpc = /etrtpcounter_goto/.test( url ), 
	  gxml = url.indexOf("gxml");

  if (rtpc != false &&	gxml != -1){
	var bgxml = url.substring(0, gxml),
		agxml = url.substring(gxml);
	url = bgxml + encode(agxml);
  }

  if(windowName=="_blank"){
	features = "toolbar=1,menubar=1,location=1,scrollbars=1,resizable=1";
  }


  ETpopUp=(features?window.open(server+url,windowName,features):window.open(server+url,windowName) );

  if(windowName=="_blank"){
	if (window.screen) {
	  var aw = screen.availWidth, 
		  ah = screen.availHeight;
	  ETpopUp.moveTo(0, 0);
	  ETpopUp.resizeTo(aw, ah);
	}
  }

  if(window.focus){
	  ETpopUp.focus();
  }
}


function etURL(urlPath,thirdParty){
   this.sHref = arguments.callee.parse(urlPath,thirdParty);
   return this.sHref;
}


etURL.parse = function(urlPath,thirdParty){
		var ref = checkSpeedBump(urlPath),
					url = "";

		if(thirdParty.length < 1){
			var thirdParty = "etrade";
		}


		if(!urlPath){
			 urlPath ="";
		}

		if(!thirdParty){
			url = urlPath+ref;
		} else {
			
			if(urlPath=="" || urlPath.length<1) {
				urlPath ="/";
			}
			
			url = GoToETURL.thirdParty( thirdParty )+urlPath+ref;
		}

  return url;
};


etURL.jump = function(urlPath,thirdParty){
	top.location.href = etURL(urlPath,thirdParty);
}

etURL.open = function(urlPath,thirdParty){

   etWin(etURL(urlPath,thirdParty),"_blank",null,null,null,null,null,null,null,null,null,null,0);

}

function skinIt(urlPath,thirdParty){
	var fs = "",
		url = document.URL,
		skinning = url.indexOf("_skinnertab="),
		urlSkin = urlPath.indexOf("?skinname=none&"),
		concated = "",
		qContain = urlPath.indexOf("?");

	if(skinning != -1) {
		var whichTab = eval(skinning+12);
		if(url.charAt(whichTab) == "b") {
			concated = "bank";
		} else {
			if(url.charAt(whichTab) =="m") {
				concated = "mortgage";
			}
			else{
				concated = "invest";
			}
		}
		if((urlSkin != -1) && (concated == "bank")) {
			var e = eval(urlSkin + 15),
				urlLength = urlPath.length,
				front = urlPath.substr(0,urlSkin),
				back = urlPath.substr(e,urlLength);
			if(qContain== -1) {
				urlPath = front+"?"+back;
			}
			else {
				urlPath = front+"&"+back;
			}
		}
		if(qContain== -1) {
			var newURL=urlPath+"?_skinnertab="+concated;
		}
		else {
			var newURL=urlPath+"&_skinnertab="+concated;
		}
		GoToETURL(newURL,thirdParty);
	} else {
		GoToETURL(urlPath,thirdParty);
	}

}


function makeSpeedBumpUrls(){
	for(i=3; i < 8;i++){
		var temp_vals = tab_titles[i].url.split("/");
		var tab_url ="";
		if(temp_vals.length > 4){
			tab_url='/e/t/user/speedbump?target_app='+temp_vals[3]+'&target_page='+temp_vals[4];
		}else{
			tab_url='/e/t/user/speedbump?target_app='+temp_vals[3]+'&target_page=defaultpage';
		}
		tab_titles[i].url=tab_url;
	}
}


function buildSecondLevel(tab_val){
	var cookieVal=getCookie("ghome="),
		tab_html='<ul>',
		current="",
		stylecurrent="",
		seperator="",
		i = 0;

	for(;i<eval(secondnav_titles[tab_val]+"level.length");i++){
		title=eval(secondnav_titles[tab_val]+"level["+i+"].name");
		if(i+1 < eval(secondnav_titles[tab_val]+"level.length")){
			next_title=eval(secondnav_titles[tab_val]+"level["+(i+1)+"].name");
		}else{
			next_title="";
		}
		while(title.match("&nbsp;") || title.match("&amp;")){
			title=title.replace("&nbsp;", " ");
			title=title.replace("&amp;", "&");
		}
		while(next_title.match("&nbsp;") || next_title.match("&amp;")){
			next_title=next_title.replace("&nbsp;", " ");
			next_title=next_title.replace("&amp;", "&");
		}
		if(famSelTab.indexOf('/')!=-1){
			var title_array=famSelTab.split('/');
			if(title == title_array[0] || title == title_array[1]){
				current="id=\"current_secondary\""; seperator="";
			}else{
				current="";
				if((i+1)<eval(secondnav_titles[tab_val]+"level.length")){
					seperator="<li style=\"padding-top:5px;color:#FFFFFF;font-size:14px;\">|</li>";
				}else{
					seperator="";
				}
			}
			if(next_title == title_array[0] || next_title == title_array[1]){
				seperator="";
			}
		}else{
			if(famSelTab == title){
				current="id=\"current_secondary\"";
				seperator="";
			}else{
				current="";
				if((i+1)<eval(secondnav_titles[tab_val]+"level.length")){
					seperator="<li style=\"padding-top:5px;color:#FFFFFF;font-size:14px;\">|</li>";
				}else{
					seperator="";
				}
			}
			if(famSelTab == next_title){
				seperator="";
			}
		}
		if (current!=""){
			stylecurrent="style=\"padding-top:5px;float:left;display:block;\"";
		}else{
			stylecurrent="";
		}
		tab_html+="<li "+current+
			"><div class=\"second_nav\" onclick='javascript:GoToETURL(\""+eval(secondnav_titles[tab_val]+"level["+
			i+"].url")+"\",\""+
			eval(secondnav_titles[tab_val]+"level["+i+"].server")+"\");'><div id=\"urltext\" "+stylecurrent+">";
		if(cookieVal=="visitor:zh_TW:US"){
			tab_html+=eval(secondnav_titles[tab_val]+"level["+i+"].chinesename");
		}else{
			tab_html+=eval(secondnav_titles[tab_val]+"level["+i+"].name");
		}
		tab_html+="</div></div></li>"+seperator;
	}

	tab_html+="</ul>";

	return tab_html;
}


function makeNav(){
	var cookieVal=getCookie("ghome="),
		userT = userType.toLowerCase(),
		tab_html;

	if (userT != "visitor") {
		userT = "customer";
		is_customer=true;
	} else {
		is_customer=false;
	}
	if(includesptab=='y' && is_customer){
		is_esp_customer=true;
	}else{
		is_esp_customer=false;
	}

	var width_reg="107px",
		margin_style="margin-right:1px;",
		padding_style="",
		current="",
		stylename="",
		style_tag="style=\"padding-top:3px;padding-bottom:2px;\"",
		curr_tab_index = tabSelect(famTab);
	if (curr_tab_index==1 && is_customer){
		curr_tab_index=2;
	}
	if(typeof(static_tab)=="undefined"){
		var static_tab=false;
	}
	if(static_tab==true){
		curr_tab_index = 10;
	}
	if(curr_tab_index == 8 || curr_tab_index == 9){
		makeSpeedBumpUrls();
		stylename="_nonbrokerage";
	}

	var tab_html='<div id="navigation"><ul>';
	for(i=1;i<tab_titles.length;i++){
		if(is_customer && i==1){
			i=2;
		}
		if(is_customer && i!=2){
			width_reg="109px;";
		}
		if(!is_customer && i==1){
			width_reg="106px;";
		}else{
			width_reg="108px;";
		}
		if(!is_customer && i==2){
			i=3;
		}
		if(is_esp_customer){
			if(i!=2){
				width_reg="97px;";
			}
		}
		if(!is_esp_customer && i==6){
			i=7;
		}
		if(i==9){
			margin_style="";
		}
		if(curr_tab_index == i || curr_tab_index==10){
			current="id=\"current"+stylename+"\"";
		}else{
			current="";
		}
		if(i==1 || i==2){
			style_tag="style=\"padding-top:10px;padding-bottom:9px;\"";
			if(is_esp_customer){
				width_reg="74px";
			}else{
				width_reg="106px;";
			}
		}else{
			style_tag="style=\"padding-top:3px;padding-bottom:2px;\"";
		}
		tab_html+="<li "+current+" style='width:"+width_reg+";"+margin_style+"'><div class=\"mainnav\" "+
			padding_style+" onclick=\"GoToETURL('"+tab_titles[i].url+"', '"+
			tab_titles[i].server+"');\"><div class=\"tab_titles\" "+style_tag+">";
		if(cookieVal=="visitor:zh_TW:US"){
			tab_html+=tab_titles[i].chinesename;
		}else{
			tab_html+=tab_titles[i].name;
		}
		tab_html+="</div></div></li>";
	}
	tab_html+="</ul></div><div style=\"clear:both;\">";
	if(curr_tab_index!=10){
		tab_html+="<div style=\"float:left;\"><img src=\""+AkamaiURL+"/images/left_secondary"+stylename+
			"_sliver.gif\" alt=\"\" height=\"27\" border=\"0\"/></div><div id=\"second_navigation"+
			stylename+"\">"+buildSecondLevel(tabSelect(famTab))+"</div><div style=\"float:right;\"><img src=\""+
			AkamaiURL+"/images/right_secondary"+stylename+
			"_sliver.gif\" alt=\"\" height=\"27\" border=\"0\"/></div>";
	}else{
		tab_html+="<div style=\"float:left;\"><img src=\""+AkamaiURL+"/images/left_secondary"+
			stylename+
			"_sliver.gif\" alt=\"\" height=\"27\" border=\"0\"/></div><div id=\"second_navigation_nolink\">" +
			"&nbsp;</div><div style=\"float:right;\"><img src=\""+
			AkamaiURL+"/images/right_secondary"+stylename+"_sliver.gif\" alt=\"\" height=\"27\" border=\"0\"/></div>";
	}

	tab_html+="</div><div style=\"clear:both;line-height:1px;\">&nbsp;</div>";

	document.write(tab_html);
}


function tabSelect(famTab){
	var famTablower = famTab.toLowerCase();
	if(famTablower.indexOf("home") > -1 && famTablower.indexOf("equity") < 0) {
		return "1";
	}
	if(famTablower.indexOf("accounts")>-1) {
		return "2";
	}
	if(famTablower.indexOf("invest")>-1 || famTablower.indexOf("trading")>-1) {
		return "3";
	}
	if(famTablower.indexOf("quotes")>-1) {
		return "4";
	}
	if(famTablower.indexOf("mutual")>-1) {
		if(document.cookie.indexOf('xborder')>-1){
			return "4";
		} else {
			return "5";
		}
	}
	if(famTablower.indexOf("employee")>-1) {
		return "6";
	}
	if(famTablower.indexOf("retirement")>-1 || famTablower.indexOf("plan")>-1) {
		return "7";
	}
	if(famTablower.indexOf("bank")>-1) {
		return "8";
	}
	if(famTablower.indexOf("mortgages")>-1 || famTablower.indexOf("borrow")>-1){
		return "9";
	}
	if(famTablower.indexOf("chinese")>-1) {
		return "chinese";
	}
	if(famTablower.indexOf("none")>-1) {
		return "10";
	}

	return "1";
}

function openNewMT(urlName){
	window.open(urlName,'MarketTrader',
				'personalbar=no,status=no,scrollbars=yes,resizable=yes,toolbar=no,menubar=no,width=720,height=520');
}


var fromMTFlag = false;

function check_frommarkettrader(){
	if(fromMTFlag)	{
		window.focus();
	}
}


var casterFlag = false;

function open_marketcaster_window(){
	newwin = window.open("", "MarketCasterWindow",
						 "personalbar=no,toolbar=no,status=no,scrollbars=no,resizable=yes," +
						 "menubar=no,width=860,height=600");
	if(newwin.opener == null){
		newwin.opener = window;
	}
	window.focus();
	window.location = ("/e/t/applogic/MarketCaster?" + get_reload_val());
}


function get_reload_val(){
	return new Date().getTime() + "";
}


// Function to help remove char's that are killing popups
function removeSpecialChar(str, pattern){
	while (str.indexOf(pattern)!= -1){
		str=str.substring(0,str.indexOf(pattern))+str.substring(str.indexOf(pattern)+1,str.length);
	}
	return str;
}


function openHelp(freshurl){
	web_Server = ETRADE; // Can we 'var' these -- they are global now.
	fresh_url = web_Server + freshurl;
	leftPos = 0;

	if(screen){
		leftPos = screen.width-280
	}
	SmallWin=window.open(fresh_url, 'HelpWindow',
						 'scrollbars=yes,resizable=yes,toolbar=no,height=688,width=270,left='+leftPos+',top=0');
	if(window.focus){
		SmallWin.focus();
	}
	if(SmallWin.opener == null) {
		SmallWin.opener = window;
		SmallWin.opener.name = "newPUMain";
	}
}


function symbolSearch(type){
	var url;
	if(type != null && type.toLowerCase() != "us") {
		url = '/e/t/gmc/gtsymbolsearch?searchtype=2';
	} else {
		url = '/e/t/applogic/lookup?ntag=Symbol&symPre=&lookup_start_value=';
	}
	var open_it=etWin(url,'Lookup','400','340','no','yes','yes','yes','yes',5,5,'');
}


function FindFlashVers(){
	var noFlash = false,
		fv=0;

	if (navigator.plugins != null && navigator.plugins.length > 0){
		var flashPlugin = navigator.plugins['Shockwave Flash'];
		if (typeof flashPlugin =='object'){
			for (var i=0; i < navigator.plugins.length; i++) {
				if (navigator.plugins[i].name.toLowerCase().indexOf("shockwave flash") >= 0) {
					var fullVer = navigator.plugins[i].description.substring(
							navigator.plugins[i].description.toLowerCase().lastIndexOf("flash ") + 6,
							navigator.plugins[i].description.length);
					var fv = fullVer.charAt(0);

					if(!isNaN(fv)){
						if(fv>FlashVers){
							FlashVers = fv
						}
					}
				}
			}
		}
	}else if (typeof window.clipboardData != "undefined" ){
		var oAX,
			i = 5;
		for (; i<20; i++) {
			try {
				oAX = new ActiveXObject( "ShockwaveFlash.ShockwaveFlash." + i );
				FlashVers = i;
			} catch ( oE ) {
				break;
			}
		}
	}
	if(isNaN(FlashVers)|| FlashVers ==0){
		FlashVers = "noFlash";
	}

	return FlashVers;
}


// cookie functions
function getExp(nodays){
	var UTCstring;
	Today = new Date(); // global -- make local?
	diff=Date.parse(Today);
	Today.setTime(diff+nodays*24*60*60*1000);
	UTCstring = Today.toUTCString();

	return UTCstring;
}


function getCookie(cookiename){
	var cookiestring=""+document.cookie;
	var index1=cookiestring.indexOf(cookiename);
	if (index1==-1 || cookiename=="") {
		return "";
	}
	var index2=cookiestring.indexOf(';',index1);
	if (index2==-1) {
		index2=cookiestring.length;
	}

	return unescape(cookiestring.substring(index1+cookiename.length,index2));
}


function setGhomeCookie(locale, country, cust_type){
	var LOC,
		CONTENTS,
		cookiestring;

	CONTENTS=cust_type+":"+locale+":"+country;
	cookiestring="ghome="+CONTENTS+";DOMAIN=.etrade.com;PATH=/;EXPIRES="+getExp(12000);document.cookie=cookiestring;
	setCountryLocaleCookie(locale, country);
}


function setCountryLocaleCookie(locale, country){
	var cookiestring;

	cookiestring=country+"_locale="+locale+";DOMAIN=.etrade.com;PATH=/;EXPIRES="+getExp(12000);
	document.cookie=cookiestring;
}


function cookieThenRedirect(x){
	switch( x ) {
		case "us_english": setGhomeCookie("en_US","US","visitor");
			this.location.href = ETRADE+"/e/t/home";
			break;
		case "xborder": set_site('xborder');
			setGhomeCookie("in_US","US","visitor");
			this.location.href = "/e/t/home";
			break;
		case "us_chinese": setGhomeCookie("zh_TW","US","visitor");
			this.location.href = ETRADE+"/e/t/home";
			break;
	}
}


function set_site(x) {
	var cookiestring,
		site="";

	switch (x) {
		case "site04": site="site04:serena2";
			break;
		case "serena": site="site04:serena2";
			break;
		case "xborder": site="xborder:serena2";
			break;
		default: site="site04:serena2";
	}
	cookiestring="et_site="+site+";DOMAIN=.etrade.com;PATH=/;EXPIRES="+getExp(12000);
	document.cookie=cookiestring;
	document.location.href=document.location.href;
}

function setRC() {
	var tz = (new Date().getTimezoneOffset()/60)*(-1);
	var ul = (typeof(navigator.userLanguage)!="undefined")?navigator.userLanguage:((typeof(navigator.language)!="undefined")?navigator.language:"");
	var ulcookiestring="UserLanguage="+ul+";DOMAIN=.etrade.com;PATH=/;EXPIRES="+getExp(12000);
        var tzcookiestring="TimeZone="+tz+";DOMAIN=.etrade.com;PATH=/;EXPIRES="+getExp(12000);
	document.cookie=ulcookiestring;
	document.cookie=tzcookiestring;
}

function postIntoITW (symbol){
	tWin = window.open('/e/t/pfm/pfmwledit?addinvto.x=x&symbollist='+symbol, "",
					   "innerWidth=1, innerHeight=1,width=1,height=1,titlebar=0,personalbar=0,toolbar=0," +
					   "location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0");
	alert ("" + symbol + " has been added into your investments to watch");
	tWin.close();
}


function brkFrm() {
  var s = self.location.href;

  if (window.top != window.self) {
	window.top.location.href = s;
  }
}

function safeOnload() {
  if(typeof window.addEventListener != 'undefined') {
	window.addEventListener('load', safeOnloadFunc, false); //.. gecko, safari, konqueror and standard
  } else if(typeof document.addEventListener != 'undefined') {		//.. opera 7
	document.addEventListener('load', safeOnloadFunc, false);
  } else if(typeof window.attachEvent != 'undefined') {		//.. win/ie
	window.attachEvent('onload', safeOnloadFunc);
  } else { //.. mac/ie5 and anything else that gets this far
	if(typeof window.onload == 'function') {
		var existing = onload;
		window.onload = function() {
			existing();
			safeOnloadFunc();
		};
	} else {
		window.onload = safeOnloadFunc;
	}
  }
}


function checkboxValue( checkval ) {
	return !( checkval == "" || checkval == "Quotes" || checkval == "Search" );
}


function setServer( form, site, txtfld ) {
	var oForm = eval( form ),
		fval = oForm[ txtfld ].value;

	if( checkboxValue( fval ) ) {
		var st = oForm.action;
		oForm.action = site + st.substring( st.indexOf( "/e/t/" ), st.length );
		return true;
   }

   return false;
}


function setSearchServer( form, site, txtfld, skinnertab, skinnerfamily ) {
	var oForm = eval( form ),
		fval = oForm[ txtfld ].value;

	if( checkboxValue( fval ) ) {
		var st = oForm.action,
			e = site + st.substring( st.indexOf( "/e/t/" ), st.length);

		e += "?_skinnertab=" + skinnertab + "&_skinnerfamily=" + skinnerfamily;

		oForm.action = e;

		return true;
	}

	return false;
}


function writeAlert(techPage,sym,alt_prod,alt_quote) {
	var qsVars = "sym=" + sym + "&alt_prod=" + alt_prod + "&alt_quote=" + alt_quote + "&skinname=none",
		alertWidth = "545";

	if (FindFlashVers() >= 6) {
		var alertSrc = "/e/t/invest/flash_oneclickalert?" + qsVars,
			alertHt = "43";
		document.write("<br>");
	} else {
		var alertSrc = "/e/t/invest/oneclickalert?" + qsVars,
			alertHt = "60";
		if (techPage == true) { // Techn. Page is wider than others
			alertWidth = "585";
		}
	}

	document.write("<iframe align='center' width='" + alertWidth + "' height='" + alertHt +
				   "' frameborder='0' marginheight='0' marginwidth='0' scrolling='no' src='" +
				   alertSrc + "'></iframe>");
}


function bd(uu){
	var Q=document.URL,
		q=Q.toUpperCase(),
		sRoot;

	if(q.search("BONDDESK.C")!=-1){
		sRoot = "/etrade/owa/pkg_static.home?p_custom=BASE,";
		if(uu==1){
			GoToETURL( sRoot + "GOTOURL_EQ_pkg_order_bond.output%3Fp_action_subset%3DBS","bond");
		}if(uu==2){
			GoToETURL( sRoot + "GOTOURL_EQ_pkg_quickpick.output","bond");
		}if(uu==3){
			GoToETURL( sRoot + "GOTOURL_EQ_pkg_static.resultSet%3Fp_src1%3Dpkg_query_bond.output","bond");
		}
	}else{
		sRoot = "/e/t/applogic/bondbridge?bdest=";
		if(uu==1){
			GoToETURL( sRoot + "TICKET&traxui=F_FN","");
		}if(uu==2){
			GoToETURL( sRoot + "QUICKPICK&traxui=F_FN","");
		}if(uu==3){
			GoToETURL( sRoot + "QUERY&traxui=F_FN","");
		}
	}
}

var isMac=navigator.userAgent.indexOf("Mac")!=-1;

if (isMac){
  var style_node = document.createElement("link");
  style_node.setAttribute("rel", "stylesheet");
  style_node.setAttribute("type", "text/css");
  style_node.setAttribute("href", AkamaiURL + "/stylesheet/mac.css");
  document.getElementsByTagName("head")[0].appendChild(style_node);
}