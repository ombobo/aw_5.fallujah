#define IDD_SATVIEW_CONTROL 	12100
#define IDC_SATVIEW_BACKGROUND	12099
#define IDC_SATVIEW_MAP     	12101
#define IDC_FILTERS_LIST      	12102
#define IDC_ZOOM_LEVEL_LIST  	12103
#define IDC_SATVIEW_MAP_BUTTON  12104

/*
* Changes optic filters. Params are passed from dialiog control
*/
AW_setOpticFilter = {
	private["_control","_index"];
	_control = _this select 0;
	_index = _this select 1;
	switch (_index)do{
		case 0:{false setCamUseTi 0; false setCamUseTi 1; camUseNVG false;};
		case 1:{false setCamUseTi 0; false setCamUseTi 1; camUseNVG true;}; 
		case 2 :{false setCamUseTi 1; camUseNVG false; true setCamUseTi 0;}; 
		case 3:{false setCamUseTi 0; camUseNVG false; true setCamUseTi 1;};
		default {false setCamUseTi 0; false setCamUseTi 1; camUseNVG false;};	
	};
};

/*
* Changes the altitude of the sat cam. Value is passed from dialog control
*/

AW_setSatZoom = {
	private["_control","_index","_currentPos","_newPos"];
	_control = _this select 0;
	_index = _this select 1;	
	_currentPos = getPos AW_Sat_Camera;
	AW_SatView_Z_Pos = call compile (_control lbdata _index);
	_newPos = [_currentPos select 0, _currentPos select 1, AW_SatView_Z_Pos];
	AW_Sat_Camera camSetPos _newPos;	
	AW_Sat_Camera camCommit 3;
};

/*
* Hides and shows minimap. Activated by dialog button.
*/
AW_setMapView = {
	if(ctrlVisible IDC_SATVIEW_MAP)then{
		ctrlShow [IDC_SATVIEW_MAP, false];
		ctrlSetText [IDC_SATVIEW_MAP_BUTTON, "Show Map"];
	}else{
		ctrlShow [IDC_SATVIEW_MAP, true];
		ctrlSetText [IDC_SATVIEW_MAP_BUTTON, "Hide Map"];
	};
};