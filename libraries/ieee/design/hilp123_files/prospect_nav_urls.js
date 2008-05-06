var mainNav = [], navLen;


function TabData( p_sName, p_sUrl, p_sServer, p_sClass ) {
	this.tabName = p_sName;
	this.url = p_sUrl;
	this.server = p_sServer;
	this.brdClass = p_sClass;
}


( function() { // Init 'mainNav'.


	function getSafe( p_aAny, p_iI ) {
		return ( p_aAny.length > p_iI ? p_aAny[ p_iI ] : "" );
	}


	var sP = "prospect",
		sB = "grnBorder",
        O_NAV = {
            S_H : "/e/t/welcome/whychooseetrade",
            S_I : "/e/t/investingandtrading",
            S_A : "/e/t/activetrading",
            S_T : "/e/t/toolsandresearch",
            S_R : "/e/t/retirementplanning",
            S_E : "/e/t/adviceeducation",
            S_B : "/e/t/banking",
            S_M : "/e/t/mortgageshomeequity",
            S_P : "/e/t/pricingandrates",
            S_W : "/e/t/welcome"
        },
		aMNs = [
			[ "WHY CHOOSE E*TRADE\?", O_NAV.S_H, sP ],
			[ "INVESTING & TRADING", O_NAV.S_I, sP ],
			[ "ACTIVE TRADING", O_NAV.S_A, sP ],
			[ "TOOLS & RESEARCH", O_NAV.S_T, sP ],
			[ "RETIREMENT PLANNING", O_NAV.S_R, sP ],
			[ "ADVICE & EDUCATION", O_NAV.S_E, sP ],
			[ "BANKING", O_NAV.S_B, sP, sB ],
			[ "MORTGAGES & HOME EQUITY", O_NAV.S_M, sP, sB ],
			[ "PRICING & RATES", O_NAV.S_P, sP ]
		],			  
		aM = mainNav,
		Td = TabData,	  
		i = aMNs.length - 1,
		aNv = null;
						  
	do {		  
		aNv = aMNs[ i ];
		aM[ i ] = new Td( aNv[ 0 ], aNv[ 1 ], aNv[ 2 ], getSafe( aNv, 3 ) );
	} while( i-- );

	//Welcome
	aM[ 0 ].subNav = [];
	
	//Investing &amp; Trading
    aM[ 1 ].subNav = [
		new Td( "Stocks", O_NAV.S_I + "/stocks", sP ),
		new Td( "Options", O_NAV.S_I + "/options", sP ),
		new Td( "Mutual Funds & ETFs", O_NAV.S_I + "/mutualfundsandetfs?fundfamily=0&fund_fee_code=0", sP ),
		new Td( "Global Trading", O_NAV.S_I + "/globaltrading", sP ),
		new Td( "Bonds & Fixed Income", O_NAV.S_I + "/bondsandfixedincome", sP ),
		new Td( "Cash Management", O_NAV.S_I + "/cashmanagement", sP ),
		new Td( "Account Management", O_NAV.S_I + "/accountmanagement", sP ),
		new Td( "Low Pricing & Margin Rates", O_NAV.S_I + "/pricingandmarginrates", sP )
		];

	//Active Trading
	aM[ 2 ].subNav = [
		new Td( "Power E*TRADE Pro", O_NAV.S_A + "/poweretradepro", sP ),
		new Td( "Advanced Trading Tools", O_NAV.S_A + "/advancedtradingtools", sP ),
		new Td( "Execution Quality",
			   O_NAV.S_A + "/apptemplate?gxml=scard.html&rightrail=disable&_skinnertab=activetrading" + 
			   "&_skinnerfamily=Execution%20Quality",
			   sP ),
		new Td( "Options Trading", O_NAV.S_A + "/optionstrading", sP ),
		new Td( "Futures Trading", O_NAV.S_A + "/futurestrading", sP ),
		new Td( "Low Pricing & Margin Rates", O_NAV.S_A + "/activetradingpricing", sP )
		];

	//Tools & Research
	aM[ 3 ].subNav = [
		new Td( "Quotes & Advanced Charting", O_NAV.S_T + "/quotesandcharting", sP ),
		new Td( "Free Independent Research", O_NAV.S_T + "/independentresearch", sP ),
		new Td( "Stock & Fund Screeners", O_NAV.S_T + "/stockandfundscreeners", sP ),
		new Td( "Investing Tools", O_NAV.S_T + "/investingtools", sP ),
		new Td( "Intelligent Cash Optimizer", O_NAV.S_T + "/optimizeyourcashanddebt", sP ),
		new Td( "2 Trading Platforms", O_NAV.S_T + "/tradingplatforms", sP )
		];

	//Retirement Planning
	aM[ 4 ].subNav = [
		new Td( "Rollover IRAs", O_NAV.S_R + "/rolloverira", sP ),
		new Td( "Traditional & Roth IRAs", O_NAV.S_R + "/traditionalandrothira", sP ),
		new Td( "Small Business Plans", O_NAV.S_R + "/smallbusinessplans", sP ),
		new Td( "Tools & Research", O_NAV.S_R + "/toolsandresearch", sP ),
		new Td( "Advice & Education", O_NAV.S_R + "/adviceandeducation", sP ),
		new Td( "Free Portfolio Reviews", O_NAV.S_R + "/freeportfolioreviews", sP )
		];
		
	//Advice & Education
	aM[ 5 ].subNav = [
		new Td( "3 Flexible Levels of Advice", O_NAV.S_E + "/threelevelsofadvice", sP ),
		new Td( "Invest On Your Own", O_NAV.S_E + "/investonyourown", sP ),
		new Td( "Advice When You Need It", O_NAV.S_E + "/advicewhenyouneedit", sP ),
		new Td( "Full Portfolio Management", O_NAV.S_E + "/fullportfoliomanagement", sP ),
		new Td( "Seminars & Education", O_NAV.S_E + "/onlinewebinarsandeducation", sP ),
		new Td( "Local Branches", O_NAV.S_E + "/localcenters", sP )
		];

	//Banking
	aM[ 6 ].subNav = [
		new Td( "High-Yield Savings & CDs", O_NAV.S_B + "/savings", sP ),
		new Td( "High-Yield Checking", O_NAV.S_B + "/checking", sP ),
		new Td( "Rewards Visa Card", O_NAV.S_B + "/rewardscard", sP ),
		new Td( "Advanced Banking Features", O_NAV.S_B + "/bankingfeatures", sP ),
		new Td( "Free Quick Transfers", O_NAV.S_B + "/quicktransfer", sP ),
		new Td( "ATM Fee Refunds", O_NAV.S_B + "/noatmfees", sP, sB )
		];
		
	//Mortgages & Home Equity
	aM[ 7 ].subNav = [
		new Td( "Low Home Equity Rates", O_NAV.S_M + "/homeequityrates", sP ),
		new Td( "Low Mortgage Rates", O_NAV.S_M + "/mortagerates", sP ),
		new Td( "Dedicated Mortgage Advisors", O_NAV.S_M + "/loanconsultants", sP )
		];

	//Pricing & Rates
	aM[ 8 ].subNav = [
		new Td( "Low Commissions", O_NAV.S_P + "/commissions", sP ),
		new Td( "Low Margin Rates", O_NAV.S_P + "/marginrates", sP ),
		new Td( "High Bank Rates", O_NAV.S_P + "/bankrates", sP ),
		new Td( "Low Mortgage Rates", O_NAV.S_P + "/lowlendingrates", sP ),
		new Td( "Low Credit Card Rates", O_NAV.S_P + "/creditcardrates", sP ),
		new Td( "Special Offers", O_NAV.S_P + "/specialoffers", sP )
		];

    navLen = aM.length;
} )();

