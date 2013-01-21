/*
* Created By Jones
* last updated 1/16/2012
*/
private["_creatVehicleMarker","_updateVehicleMarker","_getVehicleArray","_vehicleArray","_marker","_unit","_ShortenTheName","_SelectCrewName","_ShowDriver"];
/*
* Creates all the markers for the vehicles defined
* params: Array of configs gathered by the function "_getVehicleArray"
* Return: N/A
*/
_creatVehicleMarker ={
	private["_vehicleArray"];
	_vehicleArray = _this select 0;
	{
		_name = _x select 0;
		_type = _x select 2;
		createMarkerLocal [_name, [0, 0, 0]];	
		_name setMarkerColorLocal "colorBlack";
		_name setMarkerTypeLocal _type;
	}foreach _vehicleArray;	
};

/*
* creates an array of vehicles to be marked on map based on players side
* params: N/A
* Return: an array of config entries defined in config.sqf in the root mission folder
*/
_getVehicleArray={
	private["_vehicleArray"];
	_vehicleArray =[];
	switch(playerSide)do{
		case west:{_vehicleArray = AW_westVehicleArray_Cfg;};
		case east:{_vehicleArray = AW_eastVehicleArray_Cfg;};
		case resistance:{_vehicleArray = AW_eastVehicleArray_Cfg + AW_westVehicleArray_Cfg};
	};
	if (AW_markerMode_Param == 3) then{_vehicleArray = AW_westVehicleArray_Cfg + AW_eastVehicleArray_Cfg;};
	_vehicleArray
};

/*
* shorten the names of crew
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
* Check if players name should be full lenght or shortened
*/
_SelectCrewName ={
	private["_result","_name"];
	_result = "string";
	_name = _this select 0;
	switch (AW_InfNameLenght) do{
		case (1):{
			_result = _name; //long names
		};
		case (2):{
			_result = [_name]call _ShortenTheName;
		};
		case (3):{
			_result = [_name]call _ShortenTheName;
		};
		default{};
	};
	
	_result = format["(%1)",_result];
	_result
};

/*
* Check if driver or other crew should be shown
*/
_ShowDriver ={
	private["_vehicle","_result"];
	_vehicle = _this select 0;
	_result = "string";
	
	switch (AW_ShowDriver) do{
		case (1):{
			_result = [name (crew _vehicle select 0)]call _SelectCrewName; //driver name
		};
		case (0):{
			_result = "";
		};
		default{};
	};
	
	_result
};

/*
* updates the position, direction and status of vehicle on map
* params: N/A
* Return: N/A
*/
_updateVehicleMarker={
	private["_marker","_vehiclename","_vehicle"];
	
	{
		_marker = _x select 0;
		_vehicle = call compile _marker;
		
		if (count _x > 6) then{
			_vehiclename = _x select 6;
		}
		else{
			_vehiclename = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
		};
		
		if(alive _vehicle)then{
			_marker setMarkerPosLocal getPos _vehicle;
			_marker SetMarkerDirLocal direction _vehicle;
			switch (AW_VehMarkerOption) do{
				case(0):{//no text
					_marker setMarkerTextLocal format [""];
				};
				case(1):{//show damage
					_marker setMarkerTextLocal format ["%1|[%2]%3 %4",1-((round((damage _vehicle)*10))/10),count crew _vehicle,_vehiclename,[_vehicle]call _ShowDriver];
				};
				case(2):{//normal
					if(count crew _vehicle > 0) then{
						_marker setMarkerTextLocal format ["[%1]%2 %3", count crew _vehicle,_vehiclename,[_vehicle]call _ShowDriver];
					}else{
						_marker setMarkerTextLocal format ["[%1]%2", count crew _vehicle,_vehiclename];
					};
				};
				default{};
			};
			_marker setMarkerColorLocal "colorBlack";
		}else{
			_marker setMarkerPosLocal getPos _vehicle;
			_marker setMarkerTextLocal format ["%1 is destroyed",_vehiclename];				
			_marker setMarkerColorLocal "colorRed";
		};
	}forEach _vehicleArray;
};

//////////////////////////////////////////////////////////////////////
// Script Start
//////////////////////////////////////////////////////////////////////
_vehicleArray = []call _getVehicleArray;
[_vehicleArray]call _creatVehicleMarker;

AW_VehMarkerOption = 2;
AW_ShowDriver = 0;

while{AW_isGameRunning}do{
	[] call _updateVehicleMarker;
	sleep 0.01515;
};