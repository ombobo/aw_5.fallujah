/*
* Created By Jones
* last updated 1/16/2012
*/
if (isMultiPlayer && isServer) exitWith{};
private["_createUnitNameArray","_selectUnitNameArray","_selectMarkerColor","_selectMarkerColorReferee",
		"_selectMarkerType","_createMarkers","_updateMarker","_selectMarkerText",
		"_setMarker2Unit","_ShortenTheName"
		];
private["_EMPTY_MARKER","_OFFICER_MARKER","_SOLDIER_MARKER","_INJURED_MARKER",
		"_REFRESH_RATE","_ENGINEER_MARKER","_MEDIC_MARKER","_PILOT_MARKER"
		];

//constants
_EMPTY_MARKER = "EMPTY";
_OFFICER_MARKER = "Headquarters";
_PILOT_MARKER = "n_air";
_SOLDIER_MARKER = "mil_arrow";
_ENGINEER_MARKER = "n_maint";
_MEDIC_MARKER = "n_med";
_INJURED_MARKER = "mil_warning";
_REFRESH_RATE = 0.2;

/*
* Desc: returns an array of string representing all the units on one side
* Params: [side,]
* Returns: String array
*/
_createUnitNameArray ={
	private["_side","_result"];
	_side = _this select 0;
	switch (_side) do{
		case west:{_side = "w"};
		case east:{_side = "e"};
	};	
	_result =[];	
	for "_index" from 1 to AW_armySize_Cfg do{
		_unit = format ["%1%2", _side, _index];
		_result set [_index - 1, _unit];
	};
	_result
};

/*
* Desc: builds the unit array to be drawn based on side
* Params: N/A
* Returns: array of unit names
*/
_selectUnitNameArray ={
	private["_result"];
	_result =[];
	switch(playerSide)do{
		case west:{
			_result = [west]call _createUnitNameArray;
		};
		case east:{
			_result = [east]call _createUnitNameArray;
		};
		case resistance:{///assigns all unit markers to be drawn if in referee slot
			private["_westArmy","_eastArmy"];
			_westArmy = [west]call _createUnitNameArray;
			_eastArmy =  [east]call _createUnitNameArray;
			_result = _westArmy + _eastArmy + AW_refereeSlots_Cfg;
		};
	};
	_result
};

/*
* Desc: selects a marker color based on units company
* Params: Marker as string
* Returns: color as string
*/
_selectMarkerColor ={
	private["_unit","_result"];
	_unit =_this select 0;
	_result = "colorYellow";
	switch true do{
		case(_unit in AW_westUnit1_Cfg || _unit in AW_eastUnit1_Cfg):{_result = "colorBlack"};
		case(_unit in AW_westUnit2_Cfg || _unit in AW_eastUnit2_Cfg):{_result = "colorBlue"};
		case(_unit in AW_westUnit3_Cfg || _unit in AW_eastUnit3_Cfg):{_result = "colorGreen"};
		case(_unit in AW_westUnit4_Cfg || _unit in AW_eastUnit4_Cfg):{_result = "colorOrange"};
	};
	_result	
};
/*
* Desc: selects a marker color based on units side
		Used for referee slots
* Params: Marker as string
* Returns: color as string
*/
_selectMarkerColorReferee ={
	private["_unit","_result"];
	_unit =_this select 0;
	_unit = call compile _unit;
	_result = "colorYellow";
	switch true do{
		case(side _unit == west):{_result = "colorBlue"};
		case(side _unit == east):{_result = "colorRed"};
		case(side _unit == resistance):{_result = "colorGreen"};
	};
	_result	
};

/*
* Desc: selects marker type based on unit permission group
* Params: marker  as string
* Returns: marker type as string
*/
_selectMarkerType ={
	private["_unit","_result"];
	_unit = _this select 0;
	_result = _SOLDIER_MARKER;
	switch true do{
		case(_unit in AW_officers_Cfg):{_result = _OFFICER_MARKER;};
		case(_unit in AW_pilots_Cfg):{_result = _PILOT_MARKER;};
		case(_unit in AW_engineers_Cfg):{_result = _ENGINEER_MARKER;};
		case(_unit in AW_medics_Cfg):{_result = _MEDIC_MARKER;};
		};
		_result;
};

/*
* shorten the names of inf.
* included 19.08. by conroy
*/

_ShortenTheName ={
	private["_nameString","_nameArray","_NameDivider","_i","_j","_ShortNameArray","_ShortNameString"];
	_nameString = _this select 0;
	_nameArray = toArray(_nameString);
	_ShortNameArray = [];
	
	switch (AW_InfNameLenght) do{
		case (2):{
			_NameDivider = toArray("-");
		};
		case (3):{
			_NameDivider = toArray("]");
		};
		default{};
	};
	
	_i = 0;
	//check where the first letter after the '-' is
	{
		if (_x == _NameDivider select 0) exitWith {_i = _i +1;};
		_i = _i +1;
	}forEach _nameArray;
	//exit with full name if no '-' was detected
	if (_i == count _nameArray) exitWith {_nameString};
	//set array with shortened name
	_j = 0;
	for "_x" from _i to ((count _nameArray)-1) do
	{
		_ShortNameArray set [_j,_nameArray select _x];
		_j = _j + 1;
	};
	_ShortNameString = toString _ShortNameArray;
	//return
	_ShortNameString
};

/*
* Desc:  assigns marker text 
* Params: N/A
* Returns:  N/A
*/
_selectMarkerText ={
	private["_marker","_unit","_unitname"];
	_marker = _this select 0;
	_unit = call compile _marker;
	
	switch (AW_InfNameLenght) do{
		case (1):{
			_unitname = name _unit; //long names
		};
		case (2):{
			_unitname = [name _unit]call _ShortenTheName;
		};
		case (3):{
			_unitname = [name _unit]call _ShortenTheName;
		};
		default{};
	};
	
	switch (AW_markerMode) do{
		case 1:{
			_marker setMarkerTextLocal format ["D:%1|%2",(round((damage _unit)*10))/10,_unitname];
		};
		case 2:{
			_marker setMarkerTextLocal format ["%1", _unitname];
		};
		case 3:{
			_marker setMarkerTextLocal format ["%1|%2",getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "displayName"),_unitname];
		};
		default{_marker setMarkerTextLocal "";};
	};
};
/*
* Desc: Creates all the markers defined in anarray of strings
* Params: array of strings (marker names)
* Returns: N/A
*/
_createMarkers ={
	private["_markerGroupArray","_marker_Color"];
	_markerGroupArray = _this select 0;
	
	{
		if(playerSide == resistance)then{
			_marker_Color = [_x]call _selectMarkerColorReferee;
		}else{
			_marker_Color = "colorBlue";
		};																																															
		createMarkerLocal [_x, [0, 0, 0]];	
		_x setMarkerColorLocal _marker_Color;
		_x setMarkerTypeLocal _EMPTY_MARKER;
		_x setMarkerSizeLocal [0.6,0.6];
	}forEach _markerGroupArray;		
};
/*
* Desc:  Sets the marker position and diretion of passed unit
* Params:  marker as string, _unit as object
* Returns: N/A
*/
_setMarker2Unit ={
	private["_marker","_unit"];
	_marker = _this select 0;
	_unit = _this select 1;
	_marker SetMarkerPosLocal GetPos _unit;	
	_marker SetMarkerDirLocal direction _unit;
};
/*
* Desc:  updates marker based on asscoiated unit's state
* Params:  marker as string
* Returns: N/A
*/
_updateMarker = {
	private["_marker","_unit","_vehicle","_marker_Type"];
	_marker = _this select 0;
	_unit = call compile _marker;		
	_vehicle = vehicle _unit;
	if (alive player) then{
		if (alive _unit) then{	
			if (_vehicle != _unit) then {
				_marker_Type = _EMPTY_MARKER;
			}else {
				_marker_Type = [_marker]call _selectMarkerType;	
				[_marker]call _selectMarkerText;
				[_marker, _unit]call _setMarker2Unit;
			};			
		}else {
			_marker_Type = _EMPTY_MARKER; 
		};		
	};
	_marker SetMarkerTypeLocal _marker_Type;
};

/////////////////////////////////////////////////////////////////////
// SCRIPT START
/////////////////////////////////////////////////////////////////////
AW_markerMode = 2;
AW_InfNameLenght = 1; //Lenght defaults to full

private["_markerGroup"];

_markerGroup = []call _selectUnitNameArray;
[_markerGroup]call _createMarkers;

while{AW_isGameRunning}do{
	{
		[_x]call _updateMarker;		
	}forEach _markerGroup;	
	
	sleep _REFRESH_RATE;
};




