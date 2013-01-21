/*
Alpha	1
Bravo	2
Charlie	3
Delta	4
Echo	5
Foxtrot	6
Golf	7
Sierra	8
Zulu	9
*/

// ---- Config ---- //
#define __markerCheckRadius 250
#define __refreshRate 3
#define __IndividualMarkers
// -- End Config -- //

FriendlyUnits = [];
HostileUnits = [];
fl_HostileVehicles = [];

private["_AW_WestTotal","_AW_EastTotal","_AW_AllTotal"];
_AW_WestTotal = AW_westUnit1_Cfg + AW_westUnit2_Cfg + AW_westUnit3_Cfg + AW_westUnit4_Cfg;
_AW_EastTotal = AW_eastUnit1_Cfg + AW_eastUnit2_Cfg + AW_eastUnit3_Cfg + AW_eastUnit4_Cfg;
_AW_AllTotal = _AW_WestTotal + _AW_EastTotal;

private["_AW_groupStrings","_AW_allUnitGroups"];

//----- Strings for the unitgroups
_AW_groupStrings = [
	"Alpha", //1
	"Bravo", //2
	"Charlie", //3
	"Delta", //4
	"Echo", //5
	"Foxtrot", //6
	"Golf", //7
	"Sierra", //8
	"Zulu" //9
];

//----- one array for each unitgroup
_AW_allUnitGroups = [
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[],
	[]
];

//----- Create the group markers
{
	_markerName = format["AW_groupMarker_%1",_forEachIndex];
	createMarkerLocal [_markerName, [0, 0, 0]];
	_markerName setMarkerColorLocal "ColorBlack";
	_markerName setMarkerTypeLocal "n_inf";
	_markerName setMarkerSizeLocal [0.8,0.8];
}forEach _AW_groupStrings;

//----- Determine some side specific variables and arrays (like friendly units)
switch(playerSide)do{
	case west:{
		FriendlyUnits = _AW_WestTotal;
		HostileUnits = _AW_EastTotal;
		{
			_marker = _x select 0;
			_vehicle = call compile _marker;
			fl_HostileVehicles set [count fl_HostileVehicles, _marker];
		}forEach AW_eastVehicleArray_Cfg;
	};
	case east:{
		FriendlyUnits = _AW_EastTotal;
		HostileUnits = _AW_WestTotal;
		{
			_marker = _x select 0;
			_vehicle = call compile _marker;
			fl_HostileVehicles set [count fl_HostileVehicles, _marker];
		}forEach AW_westVehicleArray_Cfg;
	};
	//assigns all unit markers to be drawn if in referee slot
	case resistance:{
		FriendlyUnits = _AW_WestTotal + _AW_EastTotal + AW_refereeSlots_Cfg;
	};
};

//----- If Editor
if (isServer && !isDedicated) then{
	{
		_unit = call compile _x;
		if (alive _unit) then{
			[_unit] joinSilent grpNull; 
		};
	}forEach (FriendlyUnits + HostileUnits);
};

_randomizeGroups = {
	{
		if (_x in AW_westUnit1_Cfg) then{
			_unit = call compile _x;
			_unit setVariable ["AW_markerColor", 0];
		};
		
		if (_x in AW_westUnit2_Cfg) then{
			_unit = call compile _x;
			_unit setVariable ["AW_markerColor", 1];
		};
		
		if (_x in AW_westUnit3_Cfg) then{
			_unit = call compile _x;
			_unit setVariable ["AW_markerColor", 2];
		};
		
		if (_x in AW_westUnit4_Cfg) then{
			_unit = call compile _x;
			_unit setVariable ["AW_markerColor", 3];
		};
	}forEach FriendlyUnits;
};

//----- Create individual markers
{
	_markerName = format["AW_infMarker_%1",_forEachIndex];
	createMarkerLocal [_markerName, [0, 0, 0]];
	_markerName setMarkerColorLocal "ColorBlack";
	_markerName setMarkerTypeLocal "n_inf";
	_markerName setMarkerSizeLocal [0.3,0.3];
}forEach FriendlyUnits;

private["_fillUnitGroups","_updateMarkers"];

_fillUnitGroups = {
	private["_unit","_unitGroup","_unitGroupNumber"];
	
	{
		_x resize 0;
	}forEach _AW_allUnitGroups;
	
	{
		_unit = call compile _x;
		if (alive _unit) then{
			_unitGroupNumber = _unit getVariable ["AW_markerColor",-1];
			if (_unitGroupNumber != -1) then{
				_unitGroup = _AW_allUnitGroups select _unitGroupNumber;
				_unitGroup set [count _unitGroup,_unit];
			};
		};
	}forEach FriendlyUnits;
};

_updateMarkers = {
	private["_unitGroup","_markerName"];
	private["_unitPos","_xPosTotal","_yPosTotal"];
	private["_checkRadius","_closestUnit","_UnitCount","_newUnitCount","_groupVar"];
	
	_unitPos = [];
	
	{
		_xPosTotal = 0;
		_yPosTotal = 0;
		
		_UnitCount = 1; //initialize to 1, as 0 would create a 0-division error, when the _center array is calculated
		_unitGroup = _x;
		_markerName = format["AW_groupMarker_%1",_forEachIndex];
		
		if ({_x == vehicle _x} count _unitGroup > 0) then{
			_closestUnit = _unitGroup select 0; //to avoid errors in case everyone is in a vehicle
			
			{
				_newUnitCount = {_x in _unitGroup} count (getPosATL _x nearEntities ["Man",__markerCheckRadius]); //21
				//_newUnitCount = count (getPosATL _x nearEntities ["Man",__markerCheckRadius]); //48
				//_groupVar = _x getVariable ["AW_markerColor",-1];
				//_newUnitCount = {_x getVariable ["AW_markerColor",-1] == _groupVar} count (getPosATL _x nearEntities ["Man",__markerCheckRadius]); //15
				/*
				_newUnitCount = 0;
				{
					if (_x in _unitGroup) then{
						_newUnitCount = _newUnitCount + 1;
					};
				}forEach (getPosATL _x nearEntities ["Man",__markerCheckRadius]);
				*/ //15
				if (_newUnitCount >= _UnitCount) then{
					_UnitCount = _newUnitCount;
					_closestUnit = _x;
				};
			}forEach _unitGroup;
			
			{
				if (_x in _unitGroup) then{
					_unitPos = getPosASL _x;
					_xPosTotal = _xPosTotal + (_unitPos select 0);
					_yPosTotal = _yPosTotal + (_unitPos select 1);
				};
			}forEach (getPosATL _closestUnit nearEntities ["Man",__markerCheckRadius]);
			
			_markerName setmarkerPosLocal [_xPosTotal / _UnitCount,_yPosTotal / _UnitCount];
			_markerName setmarkerTextLocal format["[%1]%2",_UnitCount,_AW_groupStrings select _forEachIndex];
		}else{
			_markerName setmarkerPosLocal [0,0];
		};
	}forEach _AW_allUnitGroups;
};

_nextSecond = floor diag_tickTime + 1;
_iCount = 0;

//[] call _fillUnitGroups;
//[] call _updateMarkers;

while{true}do{
	_initTime = diag_tickTime;
	/*
	if (diag_tickTime > _nextSecond) then{
		_nextSecond = floor diag_tickTime + 1;
		player sidechat format["iter: %1",_iCount];
		_iCount = 0;
	};
	_iCount = _iCount + 1;
	*/
	[] call _fillUnitGroups;
	[] call _updateMarkers;
	
	#ifdef __IndividualMarkers
	{
		_unit = call compile _x;
		if (alive _unit && vehicle _unit == _unit) then{
			_markerName = format["AW_infMarker_%1",_forEachIndex];
			_markerName setmarkerPosLocal getPosASL _unit;
			_markerName setmarkerAlphaLocal 0.5;
			//_markerName setmarkerTextLocal format["%1",_unit getVariable ["AW_markerColor",-1]];
		}else{
			_markerName setmarkerAlphaLocal 0;
		};
	}forEach FriendlyUnits;
	#endif
	//player sidechat format["updated: %1",diag_tickTime - _initTime];
	//player sidechat "--------------";
	sleep __refreshRate;
};