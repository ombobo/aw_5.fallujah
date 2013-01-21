///-----------------------------------------------------------------------
//IDDs and IDCs
///-----------------------------------------------------------------------
#define IDD_FORTIFICATION_CONTROL   10100
#define IDC_FORTIFICATION_LIST      10101
#define IDC_SUPPLY_STATUS   		10102
#define IDC_COST_STATUS				10103 //this shit doesnt work for some reason
#define IDC_FORTIFICATION_LIST2     10202
#define IDC_FORTIFICATION_LIST3     10203
#define IDC_FORTIFICATION_LIST4     10204
#define IDC_FORTIFICATION_TOOLBOX1	10301
#define IDC_FORTIFICATION_TOOLBOX2	10302

///------------------------------------------------------------------------
class AW_fortification_manager_dialog {
	idd = IDD_FORTIFICATION_CONTROL;
	movingEnable = true; 
	onLoad = "";
	class controlsBackground {
		class AW_listBG : AW_RscPicture {
			idc = -1;
			moving = true;
			x = 0.0; 
			y = 0.0;
			w = 1.0; 
			h = 1.0;
			text = "\ca\ui\data\ui_gameoptions_background_ca.paa";			
		};	
	};
	class controls {
		class AW_Title : AW_RscText {
			idc = -1;
			type = CT_STATIC;
			style = ST_CENTER;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.001; 
			y = 0.01;
			w = 0.3; 
			h = 0.05;
			sizeEx = 0.04;
			text = "Fortification Manager";
		};
		class AW_Category_Label : AW_RscText {
			idc = -1;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.1; 
			y = 0.15;
			w = 0.4; 
			h = 0.04;
			sizeEx = 0.04;
			text = "Category";
		};
		class AW_Equipment_Label : AW_RscText {
			idc = -1;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.5; 
			y = 0.15;
			w = 0.4; 
			h = 0.04;
			sizeEx = 0.04;
			text = "Object";
		};
		class AW_Supply_Status : AW_RscText {
			idc = IDC_SUPPLY_STATUS;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.1; 
			y = 0.6;
			w = 0.25; 
			h = 0.035;
			sizeEx = 0.04;
			text = "Supply Points:";
		};	
	
		class AW_Cost_Label : AW_RscText {
			idc = 10103;
			type = CT_STATIC;
			style = ST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.5;
			y = 0.6;
			w = 0.25; 
			h = 0.035;
			sizeEx = 0.04;
			text = "Equipment Cost";
		};

		class AW_fortification_List : AW_RscComboBox {
			idc = IDC_FORTIFICATION_LIST;
			//style = LB_MULTI;
			default = 1;
			x = 0.1; 
			y = 0.2;
			w = 0.2; 
			h = 0.04;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_Update_Second_List";
			onLBDblClick = "";
			rowHeight = 0.06;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
		
		class AW_fortification_List2 : AW_RscComboBox {
			idc = IDC_FORTIFICATION_LIST2;
			//style = LB_MULTI;
			default = 1;
			x = 0.5; 
			y = 0.2;
			w = 0.2; 
			h = 0.04;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_Upadate_Selection_Dialog";
			onLBDblClick = "";
			rowHeight = 0.06;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
		/*
		class AW_fortification_List3 : AW_RscComboBox {
			idc = IDC_FORTIFICATION_LIST3;
			//style = LB_MULTI;
			default = 1;
			x = 0.01; 
			y = 0.2;
			w = 0.15; 
			h = 0.025;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_Upadate_Selection_Dialog";
			onLBDblClick = "";
			rowHeight = 0.04;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
		class AW_fortification_List4 : AW_RscComboBox {
			idc = IDC_FORTIFICATION_LIST4;
			//style = LB_MULTI;
			default = 1;
			x = 0.01; 
			y = 0.25;
			w = 0.15; 
			h = 0.025;
			//lineSpacing = 0;
			onLBSelChanged = "_this call AW_Upadate_Selection_Dialog";
			onLBDblClick = "";
			rowHeight = 0.04;
			soundSelect[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};
		*/
		/*
		class AW_Toolbox1 : AW_RscText {
			idc = IDC_FORTIFICATION_TOOLBOX1;
			type = CT_TOOLBOX; //defined constant (6)
			style = ST_LEFT; //defined constant (2)
			
			x = 0.1;
			y = 0.2;
			w = 0.2;
			h = 0.15;
			
			colorText[] = {1, 1, 1, 1}; color[] = {0, 0, 0, 1}; // seems nothing to change, but define it to avoid error!
			colorTextSelect[] = {1, 0, 0, 1};
			colorSelect[] = {0, 0, 1, 1};
			colorTextDisable[] = {0.4, 0.4, 0.4, 1};
			colorDisable[] = {0.4, 0.4, 0.4, 1};
			coloSelectedBg[] = {0,0,0,0};
			
			rows = 3;
			columns = 2;
			strings[] = {"Entry 1","Entry 2","Entry 3","Entry 4","Entry 5","Entry 6"};
			values[] = {1,1,0,1,0,0};
			
			onToolBoxSelChanged = "hint format[""Toolbox change:\n%1\nEntry#:%2"",(_this select 0),(_this select 1)];"
		};
		class AW_Toolbox2 : AW_RscText {
			idc = IDC_FORTIFICATION_TOOLBOX2;
			type = CT_TOOLBOX; //defined constant (6)
			style = ST_LEFT; //defined constant (2)
			
			x = 0.1;
			y = 0.2;
			w = 0.2;
			h = 0.15;
			
			colorText[] = {1, 1, 1, 1}; color[] = {0, 0, 0, 1}; // seems nothing to change, but define it to avoid error!
			colorTextSelect[] = {1, 0, 0, 1};
			colorSelect[] = {0, 0, 1, 1};
			colorTextDisable[] = {0.4, 0.4, 0.4, 1};
			colorDisable[] = {0.4, 0.4, 0.4, 1};
			coloSelectedBg[] = {0,0,0,0};
			
			rows = 3;
			columns = 2;
			strings[] = {"Entry 1","Entry 2","Entry 3","Entry 4","Entry 5","Entry 6"};
			values[] = {1,1,0,1,0,0};
			
			onToolBoxSelChanged = "hint format[""Toolbox change:\n%1\nEntry#:%2"",(_this select 0),(_this select 1)];"
		};
		*/
		class AW_Purchase : AW_RscGUIShortcutButton {
			idc = -1;
			colorDisabled[] = {1, 0.4, 0.3, 0.8};
			style = ST_TITLE;
			x = 0.54; 
			y = 0.705;
			w = 0.4; 
			h = 0.17;
			size = 0.08;
			sizeEx = 0.08;
			text = "Purchase";
			onButtonClick = "[]spawn AW_Purchase_Button_Click_Event;CloseDialog 0;";
		};
		class AW_exit_Button : AW_RscGUIShortcutButton {
			idc = -1;
			colorDisabled[] = {1, 0.4, 0.3, 0.8};
			x = 0.001; 
			y = 0.745;
			w = 0.25; 
			h = 0.12;
			size = 0.08;
			sizeEx = 0.08;
			text = "Exit";
			onButtonClick = "CloseDialog 0";
		};	
		class AW_deconstruct_Button : AW_RscGUIShortcutButton {
			idc = -1;
			colorDisabled[] = {1, 0.4, 0.3, 0.8};
			x = 0.32; 
			y = 0.745;
			w = 0.12; 
			h = 0.12;
			size = 0.08;
			sizeEx = 0.08;
			text = "X";
			onButtonClick = "[]spawn AW_Deconstruct_Button_Click_Event;CloseDialog 0;";
		};	
	};	
};