if(side player == resistance||(isServer && isMultiplayer))exitWith{};
private ["_commandVehicleName","_contactTypes",
		"_setMarkerElipse","_setMarkerIcon","_drawContacts",
		"_radarName","_factionColor","_drawFlag"	
		];

_contactTypes = [];
_commandVehicle = nil;
AW_radarRadius_param = 1250;
AW_RadarSettings_param = 1;

//get type
///"BMP2" isKindOf "Tank"

_setMarkerElipse ={
	private["_marker","_color"];
	_marker = _this select 0;
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerBrushLocal "Border";
	_marker setMarkerSizeLocal [AW_radarRadius_param, AW_radarRadius_param];
};

_setMarkerIcon ={
	private["_marker"];
	_marker = _this select 0;
	_marker  setMarkerShapeLocal "ICON";
	_marker  setMarkerTypeLocal "mil_triangle";
	_marker  setMarkerSizeLocal [1, 1];
	_marker  setMarkerTextLocal "";
};

_drawContacts ={
	private["_contactArray","_markerName","_markerCount","_contactDirection","_markerArray","_contactMarker"];
	_contactArray = _this select 0;
	_markerCount = 0;
	_markerArray =[];
	{
		_markerName = format ["radarMark%1",_markerCount];
		_contactDirection = getdir _x;
		if ((side player) != (side _x) && (getPosATL _x select 2)> 35) then{
			_contactMarker = createMarkerLocal [_markerName,getPos _x];
			_contactMarker setMarkerColorLocal "colorRed";
			_contactMarker setMarkerTextLocal Format ["%1",getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName")];
			_contactMarker setMarkerTypeLocal "mil_triangle";
			_contactMarker setMarkerDirLocal _contactDirection;
		};	
		//set marker to array to be deleted
		_markerArray set [_markerCount,_markerName];
		_markerCount = _markerCount + 1;		
	}foreach _contactArray;
	_markerArray
};
switch (playerside) do{
	case west:{
		_commandVehicleName = AW_west_CommandVehicle_cfg;
		_radarName = "AW_westRadar";
		_factionColor = "colorGreen";
	};
	case east:{
		_commandVehicleName = AW_east_CommandVehicle_cfg;
		_radarName = "AW_eastRadar";
		_factionColor = "colorGreen";
	};
	default{};
};
_contactTypes = switch(AW_RadarSettings_param)do{
		case 1:{["air"]};
		case 2:{["tank","car"]};
		case 3:{["air","tank","car"]};
		case 4:{["air","tank","car","man"]};
		default{["air"]};
	};
	
_radarMarker = createMarkerLocal [_radarName, [1,1]];
_radarMarker setMarkerColorLocal _factionColor;
_radarMarker setMarkerShapeLocal "ELLIPSE";
_radarMarker setMarkerBrushLocal "Border";
_radarMarker setMarkerSizeLocal [AW_radarRadius_param, AW_radarRadius_param];
	
[_radarMarker]spawn _setMarkerElipse;
_drawFlag = true;

while {true}do{
	private["_radarArray","_markerArray"];	
	_commandVehicle = call compile _commandVehicleName;
	_radarArray = nearestObjects [getPos _commandVehicle, _contactTypes, AW_radarRadius_param];
	_markerArray = [];
	if(alive _commandVehicle)then{
		_radarMarker setMarkerPosLocal (getPos _commandVehicle);
		_markerArray = [_radarArray]call _drawContacts;
		if(_drawFlag)then{
			[_radarMarker]spawn _setMarkerElipse;
			_drawFlag = false;
		};	
	}else{
		if!(_drawFlag)then{
			[_radarMarker]spawn _setMarkerIcon;
			_drawFlag = true;
		};
	};
	//small delay,
	sleep 0.5;
	{deleteMarker _x}forEach _markerArray;
};
