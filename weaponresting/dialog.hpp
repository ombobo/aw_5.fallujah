///-----------------------------------------------------------------------
//IDDs and IDCs
///-----------------------------------------------------------------------
//#define IDD_WEAPONRESTING_CONTROL   12100

//


class AW_RestingIcon{
	idd = 71712 ;
	//onLoad = "uiNamespace setVariable [""AW_leaderDisplay"", _this select 0];";
	movingEnable = false;
	duration = 2;
	fadein = 0;
	fadeout = 1;
	name = "resting_icon";
	controlsBackground[] = {};
	controls[] = {"AW_restingIconPic"};
	

	class AW_restingIconPic : AW_RscPicture {
		idc = -1; 
		type = 0;
		style = 48;
		//colorBackground[] = { };
		//colorText[] = { };
		//font = FontM;
		//sizeEx = 0.023;
		x = safezoneX + safezoneW - 0.5;
		y = safezoneY + safezoneH - 0.20;
		w = 0.20;
		h = 0.20;
		text = "weaponresting\weaponrestingicon.paa";
	}; 
};