/*
* Created By Jones
* last updated 1/16/2012
*/
private["_creatVehicleMarker","_updateVehicleMarker","_getVehicleArray","_vehicleArray"];
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
* updates the position, direction and status of vehicle on map
* params: N/A
* Return: N/A
*/
_updateVehicleMarker={
	private["_marker","_vehicle"];
	_marker = _this select 0;
	_vehicle = call compile _marker;
	if(alive _vehicle)then{
		_marker setMarkerPosLocal getPos _vehicle;
		_marker SetMarkerDirLocal direction _vehicle;
		switch (AW_markerMode) do{
		case 1:{
			_marker setMarkerTextLocal format ["[%1]D: %2",
				(count crew _vehicle),round(damage _vehicle)
			];
		};
		case 2:{
			if(count crew _vehicle > 0)then{
				_marker setMarkerTextLocal format ["[%1]%2",
					(count crew _vehicle),(name (crew _vehicle select 0))
				];
			}else{
				_marker setMarkerTextLocal format ["[%1]%2",
					(count crew _vehicle),"Empty"
				];
			};	
		};
		case 3:{
			_marker setMarkerTextLocal format ["[%1]%2",(count crew _vehicle), 
				getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")
			];
		};
		default{
			_marker setMarkerTextLocal format ["[%1]",(count crew _vehicle)];
		};
	};	
		_marker setMarkerColorLocal "colorBlack";
	}else{
		_marker setMarkerPosLocal getPos _vehicle;
		_marker setMarkerTextLocal format ["%1 is destroyed",
			getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName")
		];				
		_marker setMarkerColorLocal "colorRed";
	};
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
	_vehicleArray
};

//////////////////////////////////////////////////////////////////////
// Script Start
//////////////////////////////////////////////////////////////////////
_vehicleArray = []call _getVehicleArray;
[_vehicleArray]call _creatVehicleMarker;

while{AW_isGameRunning}do{
	{
		_marker = _x select 0;
		[_marker]call _updateVehicleMarker;
	}forEach _vehicleArray;
};