///-----------------------------------------------------------------------
//IDDs and IDCs
///-----------------------------------------------------------------------
#define IDD_SATVIEW_CONTROL 	12100
#define IDC_SATVIEW_BACKGROUND	12099
#define IDC_SATVIEW_MAP     	12101
#define IDC_FILTERS_LIST      	12102
#define IDC_ZOOM_LEVEL_LIST  	12103
#define IDC_SATVIEW_MAP_BUTTON  12104
/*
* Color defines
*/
#define color_Clear 0,0,0,0
#define color_Black 0,0,0
#define color_White 1,1,1
#define color_Select 0.70, 0.99, 0.65, 1
#define color_Background 0.28, 0.36, 0.26, 1
#define color_Background_Selected  0.36, 0.46, 0.36, 1

/*
* Dialog
*/
class AW_Sat_View_Dialog {
	idd = IDD_SATVIEW_CONTROL;
	movingEnable = true; 
	onLoad = "";
	class controlsBackground {
		class AW_SatView_Background {
			idc = IDC_SATVIEW_BACKGROUND; 
			moving = true;
			type = CT_STATIC; 
			style = ST_LEFT;
			colorBackground[] = {color_Clear};
			colorText[] = {color_Black};
			font = FontM;
			sizeEx = 0.023;
			x = "(SafeZoneW + SafeZoneX) - (1 - 0.35)";
			y = "(SafeZoneH + SafeZoneY) - (1 - 0.0)";
			w = 0.5; 
			h = 0.3;
			text = "";
		}; 

	
	};
	
	class controls{
		class AW_SatView_Filter : AW_RscComboBox {
			idc = IDC_FILTERS_LIST;
			//style = ST_MULTI;
			default = 0;
			x = "(SafeZoneW + SafeZoneX) - (1 - 0.5)";
			y = "(SafeZoneH + SafeZoneY) - (1 - 0.1)";
			w = 0.1; 
			h = 0.025;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_setOpticFilter";
			colorScrollbar[] = {color_Black};
			onLBDblClick = "";
			rowHeight = 0.04;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 1.0;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
		
		class AW_SatView_Zoom : AW_RscComboBox{
			idc = IDC_ZOOM_LEVEL_LIST;
			//style = ST_MULTI;
			default = 0;
			x = "(SafeZoneW + SafeZoneX) - (1 - 0.4)";
			y = "(SafeZoneH + SafeZoneY) - (1 - 0.1)";
			w = 0.1; 
			h = 0.025;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_setSatZoom";
			colorScrollbar[] = {color_Black};
			onLBDblClick = "";
			rowHeight = 0.04;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 1.0;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
		
		class AW_SatView_Map_Button : AW_RscButton {
			idc = IDC_SATVIEW_MAP_BUTTON;
			colorBackground[] = {color_Background};
			colorDisabled[] = {color_Background_Selected};
			x = "(SafeZoneW + SafeZoneX) - (1 - 0.6)";
			y = "(SafeZoneH + SafeZoneY) - (1 - 0.1)";
			w = 0.1; 
			h = 0.025;
			size = 0.02;
			sizeEx = 0.02;
			text = "Hide Map";
			onButtonClick = "call AW_setMapView;";
		};
		
		class AW_SatView_Exit_Button : AW_RscButton {
			idc = -1;
			colorBackground[] = {color_Background};
			colorDisabled[] = {color_Background_Selected};
			x = "(SafeZoneW + SafeZoneX) - (1 - 0.7)";
			y = "(SafeZoneH + SafeZoneY) - (1 - 0.1)";
			w = 0.1; 
			h = 0.025;
			size = 0.02;
			sizeEx = 0.02;
			text = "Exit";
			onButtonClick = "CloseDialog 0";
		};
		
		class AW_SatView_Map: AW_RscMap {
			idc = IDC_SATVIEW_MAP;
			x = "(SafeZoneW + SafeZoneX) -(1 - 0.4)";
			y = "(SafeZoneH + SafeZoneY) -(1 - 0.2)";
			w = 0.4;
			h = 0.4;
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
			//onMouseButtonDown = "_this execVM""C2C\imagery\MapClick.sqf""";  
		};
	};	
};