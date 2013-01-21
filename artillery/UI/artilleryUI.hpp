///-----------------------------------------------------------------------
//IDDs and IDCs
///-----------------------------------------------------------------------
#define IDD_ARTY_CONTROL   9100
#define IDC_ARTY_MAP       9101
#define IDC_AMMO_LIST      9102
#define IDC_DISPERS_LIST   9103
#define IDC_LOAD_LIST      9104

#define IDC_LOAD_SET	   9105
#define IDC_SUPPLY_SET     9106
#define IDC_DISP_SET       9107
#define IDC_AMMO_SET       9108
#define IDC_STATUS_SET     9109
///------------------------------------------------------------------------
class AW_artyDialog {
	idd = IDD_ARTY_CONTROL;
	movingEnable = true; 
	onLoad = "";
	class controlsBackground {
		class AW_listBG : AW_RscPicture {
			idc = -1;
			moving = true;
			x = 0.0; 
			y = 0.0;
			w = 0.9; 
			h = 0.9;
			text = "\ca\ui\data\ui_gameoptions_background_ca.paa";			
		};
	
		class AW_ARTY_SupportPic : AW_RscPicture {
			idc = -1;
			moving = true;
			x = 0.25; 
			y = 0.03;
			w = 0.05; 
			h = 0.05;
			text = "\ca\ui\data\icon_wf_support_artilery_ca.paa";			
		};
	};
	class controls {
		class AW_exitFCC : AW_RscGUIShortcutButton {
			idc = -1;
			colorDisabled[] = {1, 0.4, 0.3, 0.8};
			x = 0.02; 
			y = 0.7;
			w = 0.1; 
			h = 0.05;
			size = 0.025;
			sizeEx = 0.025;
			text = "Exit";
			onButtonClick = "CloseDialog 0";
		};
		///mission setting tags
		class AW_Settings_Status : AW_RscText {
			idc = IDC_STATUS_SET;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.02; 
			y = 0.48;
			w = 0.25; 
			h = 0.035;
			sizeEx = 0.022;
			text = "Status";
		};
		class AW_Settings_AmmoSupply : AW_RscText {
			idc = IDC_SUPPLY_SET;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.02; 
			y = 0.45;
			w = 0.25; 
			h = 0.035;
			sizeEx = 0.022;
			text = "Ammo Supply";
		};
		class AW_Settings_Dispersion : AW_RscText {
			idc = IDC_DISP_SET;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.02; 
			y = 0.42;
			w = 0.25; 
			h = 0.035;
			sizeEx = 0.022;
			text = "Dispersion";
		};
		class AW_Settings_roundsLoaded : AW_RscText {
			idc = IDC_LOAD_SET;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.02; 
			y = 0.38;
			w = 0.25; 
			h = 0.035;
			sizeEx = 0.022;
			text = "Rounds Loaded";
		};
		class AW_Settings_ammoType : AW_RscText {
			idc = IDC_AMMO_SET;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.02; 
			y = 0.35;
			w = 0.25; 
			h = 0.035;
			sizeEx = 0.025;
			text = "Ammo type";
		};
		//execute button
		class AW_executeFM : AW_RscGUIShortcutButton {
			idc = -1;
			colorDisabled[] = {1, 0.4, 0.3, 0.8};
			x = 0.02; 
			y = 0.6;
			w = 0.1; 
			h = 0.05;
			size = 0.025;
			sizeEx = 0.025;
			text = "Fire";
			onButtonClick = "[]spawn AW_Arty_FireMission";
		};
		class AW_FMTitle : AW_RscText {
			idc = -1;
			type = CT_STATIC;
			style = ST_CENTER;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.3; 
			y = 0.04;
			w = 0.3; 
			h = 0.05;
			sizeEx = 0.04;
			text = "Fire Control Center";
		};
		class AW_MapClicklabel : AW_RscText {
			idc = -1;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.37; 
			y = 0.605;
			w = 0.25; 
			h = 0.035;
			sizeEx = 0.02;
			text = "Click Map to set impact coordinates";
		};
		class AW_Disperslabel : AW_RscText {
			idc = -1;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.02; 
			y = 0.17;
			w = 0.2; 
			h = 0.035;
			sizeEx = 0.02;
			text = "Dispersion";
		};
		class AW_Loadlabel : AW_RscText {
			idc = -1;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.02; 
			y = 0.27;
			w = 0.2; 
			h = 0.035;
			sizeEx = 0.02;
			text = "Rounds to Load";
		};
		class AW_Ammolabel : AW_RscText {
			idc = -1;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.02; 
			y = 0.22;
			w = 0.2; 
			h = 0.035;
			sizeEx = 0.02;
			text = "Ammo Type";
		};
		class AW_artyAmmoList : AW_RscComboBox {
			idc = IDC_AMMO_LIST;
			//style = LB_MULTI;
			default = 1;
			x = 0.01; 
			y = 0.25;
			w = 0.2; 
			h = 0.02;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_setAmmoType";
			onLBDblClick = "";
			rowHeight = 0.04;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
		class AW_artyLoadList : AW_RscComboBox {
			idc = IDC_LOAD_LIST;
			//style = LB_MULTI;
			default = 1;
			x = 0.01; 
			y = 0.3;
			w = 0.2; 
			h = 0.02;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_setAmmoLoad";
			onLBDblClick = "";
			rowHeight = 0.04;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
	class AW_artyDispersList : AW_RscComboBox {
			idc = IDC_DISPERS_LIST;
			//style = LB_MULTI;
			default = 1;
			x = 0.01; 
			y = 0.2;
			w = 0.2; 
			h = 0.02;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_setDispersion";
			onLBDblClick = "";
			rowHeight = 0.04;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
	class AW_ArtyMap: AW_RscMap {
			idc = IDC_ARTY_MAP;
			x = 0.25;
			y = 0.11;
			w = 0.59;
			h = 0.5;
			sizeEx=0.1;
			fontLabel = "TahomaB";
			sizeExLabel = 0.045;
			fontGrid = "TahomaB";
			sizeExGrid = 0.042;
			fontUnits = "TahomaB";
			sizeExUnits = 0.042;
			fontNames = "TahomaB";
			sizeExNames = 0.045;
			fontInfo = "TahomaB";
			sizeExInfo = 0.045;
			fontLevel = "TahomaB";
			sizeExLevel = 0.045;
			onMouseButtonDown = "_this execVM""artillery\UI\MapClickScript.sqf""";  
		};
	};	
};