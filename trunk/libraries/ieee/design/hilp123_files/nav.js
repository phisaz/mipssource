var AkamaiURL = "https://a248.e.akamai.net/n/248/1777/akssr20071127.0/www.etrade.com",
	ACTIVATE = "https://activation.etrade.com",
	BANKUS = "https://bankus.etrade.com",
	BOND = "https://www.bonddesk.com",
	BORROW = "https://lending.etrade.com",
	EDOCS = "https://edoc.etrade.com",
	ETCA = "https://swww.canada.etrade.com",
	ETRADE = "https://us.etrade.com",
	EXPRESS = "https://express.etrade.com",
	FILESVR = "https://achdocs.corp.etradegrp.com",
	OLINK = "https://optionslink.etrade.com",
	SEARCH = "https://search.etrade.com";


GoToETURL.thirdParty = function(sParty) {
	switch(sParty) {
		case "activate": return ACTIVATE;
		case "bankus": return BANKUS;
		case "bond": return BOND;
		case "borrow": return BORROW;
		case "edocs": return EDOCS;
		case "etca": return ETCA;
		case "etrade": return ETRADE;
		case "express": return EXPRESS;
		case "filesvr": return FILESVR;
		case "olink": return OLINK;
		case "search": return SEARCH; 
	}
}


function GoToETURL(urlPath,thirdParty) {
	if(thirdParty == null) {
		thirdParty = "etrade";
	}
	window.top.location.href = etURL.parse(urlPath,thirdParty); 
}


function checkSpeedBump(urlPath)
{
	var isSpeedBump = urlPath.indexOf("/e/t/user/speedbump");
	var refr = "";
	if(isSpeedBump != -1)
	{
		var referrer = document.URL;	
		refr="&hReferrer="+referrer;	
	}
	return refr;
}
