///intro screen IDs
#define IDD_LEADER_ICON				71710
#define IDC_LEADER_ICON_TXT			71711
#define IDC_RESTING_ICON			71712


class RscTitles{
	class AW_leaderIcon{
		idd = IDD_LEADER_ICON ;
		onLoad = "uiNamespace setVariable [""AW_leaderDisplay"", _this select 0];";
		movingEnable = false;
		duration = 100000;
		fadein = 1;
		fadeout = 1;
		name = "intro";
		controlsBackground[] = {};
		controls[] = {"AW_leaderIconTxt"};
		
		class AW_leaderIconTxt: AW_RscText{
			idc = IDC_LEADER_ICON_TXT;
			lineSpacing = 0.95;
			colorBackground[]={0,0,0,0};
			colorText[]={0,0,0.8,0.7};
			size=0.57;
			sizeEx = 0.05;
			x = 0.0;
			y = 0.0;
			w = 0.900000;
			h = 0.700000;
			text = "1";
		};
	};
	
	class AW_RestingIcon{
		idd = IDC_RESTING_ICON ;
		onLoad = "uiNamespace setVariable [""AW_leaderDisplay"", _this select 0];";
		movingEnable = false;
		duration = 2;
		fadein = 0;
		fadeout = 1;
		name = "resting_icon";
		controlsBackground[] = {};
		controls[] = {"AW_restingIconPic"};
		

		class AW_restingIconPic : AW_RscPicture {
			idc = -1; 
			type = CT_STATIC;
			style = ST_PICTURE;
			//colorBackground[] = { };
			//colorText[] = { };
			//font = FontM;
			//sizeEx = 0.023;
			x = safezoneX + safezoneW - 0.5;
			y = safezoneY + safezoneH - 0.20;
			w = 0.20;
			h = 0.20;
			text = "\AW_Mod_cfg\weaponrestingicon.paa";
		}; 
	};
	
};
