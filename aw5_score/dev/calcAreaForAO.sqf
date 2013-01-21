//--- handle = AW_handle_calcArea
_passedAO = _this select 0;

if (_passedAO == -1)exitWith{
	AW_AOSizes = [];
	AW_BluTerrain = 0;
	AW_RedTerrain = 0;
	
	diag_log AW_c5_AOcontrol;
	
	{
		AW_handle_calcArea = [_x select 0] spawn script_calcArea;
		waitUntil{scriptDone AW_handle_calcArea;};
	}forEach AW_c5_AOArray;
	
	player sidechat format["Blu: %1 | Red: %2",AW_BluTerrain,AW_RedTerrain];
	
	/*
	{
		if (typeName _x == "ARRAY") then{
			_controledAO = _x select 0;
			_controlingSide = _x select 1;
			{
				if (_controledAO == _x select 0) exitWith{
					switch(_controlingSide)do{
						case(0):{AW_RedTerrain = AW_RedTerrain + (_x select 1)};
						case(1):{AW_BluTerrain = AW_BluTerrain + (_x select 1)};
					};
				};
			}forEach AW_AOSizes;
		};
	}forEach AW_c5_AOcontrol;
	*/
};

//----- Local script to get angles of corners
_getBorderAngles = {
	private["_center","_pos1","_pos2","_dir1","_dir2","_angleDegr","_angleDir"];		
		//--- Angle center
		_center = markerPos format["AW_AOCorner_%1",_this select 0];
		_borderAnglesCenter set [count _borderAnglesCenter,_center];
		
		//--- Angle degrees
		_pos1 = markerPos format["AW_AOCorner_%1",_this select 1];
		_pos2 = markerPos format["AW_AOCorner_%1",_this select 2];
		
		_dir1 = [_center,_pos1]call BIS_fnc_dirTo;
		if (_dir1 < 0) then{_dir1 = _dir1 + 360;};
		_dir2 = [_center,_pos2]call BIS_fnc_dirTo;
		if (_dir2 < 0) then{_dir2 = _dir2 + 360;};
		
		//diag_log _dir1;
		//diag_log _dir2;
		
		_angleDegr = _dir1 - _dir2;
		if (_angleDegr < 0) then{_angleDegr = _angleDegr + 360;};
		_borderAnglesWidth set [count _borderAnglesWidth,_angleDegr];
		
		//--- Angle direction
		if (_dir2 > _dir1) then {
			_dir2 = _dir2 - 360;
		};
		_angleDir = (_dir1 + _dir2) / 2;
		if (_angleDir < 0) then{_angleDir = _angleDir + 360;};
		_borderAnglesDir set [count _borderAnglesDir,_angleDir];
};

//----- Local script to check a markers position-validity
_checkForValidArea = {
	private["_inSector","_markerCheckPos","_return"];
	
	_inSector = true;
	_return = true;
	_markerCheckPos = _this select 0;
	{
		//diag_log _x;
		_return = [_x,_borderAnglesDir select _forEachIndex,_borderAnglesWidth select _forEachIndex,_markerCheckPos] call BIS_fnc_inAngleSector;
		//diag_log format["%1,%2,%3,%4",_return,_x,_borderAnglesDir select _forEachIndex,_borderAnglesWidth select _forEachIndex];
		if !(_return) exitWith{_inSector = false;};
	}forEach _borderAnglesCenter;
	//diag_log _markerCheckPos;
	_inSector
};

//----- Set the bounding box for territory markers
_pos_x_min = 99999;
_pos_x_max = 0;
_pos_y_min = 99999;
_pos_y_max = 0;
{
	if((_x select 0) == _passedAO)exitWith{
		{
			_cornerMarkerName = format["AW_AOCorner_%1",_x];
			
			_marker_x = markerPos _cornerMarkerName select 0;
			_marker_y = markerPos _cornerMarkerName select 1;
			
			_pos_x_min = _pos_x_min min _marker_x;
			_pos_x_max = _pos_x_max max _marker_x;
			
			_pos_y_min = _pos_y_min min _marker_y;
			_pos_y_max = _pos_y_max max _marker_y;
		}forEach (_x select 1);
	};
}forEach AW_c5_AOArray;

"marker_map" setMarkerPosLocal [(_pos_x_min + _pos_x_max) / 2,(_pos_y_min + _pos_y_max) / 2];
"marker_map" setMarkerSizeLocal [(_pos_x_max - _pos_x_min) / 2,(_pos_y_max - _pos_y_min) / 2];

//----- Get territory bounding box position and size values
_marker_map_pos = markerPos "marker_map";
_marker_map_pos_x = _marker_map_pos select 0;
_marker_map_pos_y = _marker_map_pos select 1;
_marker_map_size_x = getMarkerSize "marker_map" select 0;
_marker_map_size_y = getMarkerSize "marker_map" select 1;

//----- Create Array of Corner-angles
_borderAnglesCenter = [];
_borderAnglesWidth = [];
_borderAnglesDir = [];

{
	if((_x select 0) == _passedAO)then{
		_AW_AOCorners = _x select 1;
		{
			switch(true)do{
				case(_forEachIndex == 0):{
					[_AW_AOCorners select _forEachIndex,_AW_AOCorners select ((count _AW_AOCorners) - 1),_AW_AOCorners select (_forEachIndex + 1)] call _getBorderAngles;
				};
				case(_forEachIndex == ((count _AW_AOCorners) - 1)):{
					[_AW_AOCorners select _forEachIndex,_AW_AOCorners select (_forEachIndex - 1),_AW_AOCorners select 0] call _getBorderAngles;
				};
				default{
					[_AW_AOCorners select _forEachIndex,_AW_AOCorners select (_forEachIndex - 1),_AW_AOCorners select (_forEachIndex + 1)] call _getBorderAngles;
				};
			};
		}forEach _AW_AOCorners;
	};
}forEach AW_c5_AOArray;

//----- Start Hint script
if !(isDedicated) then{
	AW_showMarkerCounter = [] spawn {
		while {true}do{
			if (scriptDone AW_handle_calcArea) exitWith{};
			hintSilent format["(re)Creating territory\n%1",AW_territoryCount];
			sleep 0.02;
		};
	};
};

//----- Starting to (re)create territory markers
//----- Defines the size of each individual territory marker. Has a huge impact on calculation speed !!! (75 is usually a good value)
_markerSteps = AW_territorySteps;
//----- Create territory rectangle markers
_i = 0;
_j = 0;
_markerCounter = 0;
AW_territoryCount = _markerCounter;
while{_j < _marker_map_size_y * 2}do{
	_i = 0;
	while{_i < _marker_map_size_x * 2}do{		
		_newMarkerPos = [_marker_map_pos_x - _marker_map_size_x + _i,_marker_map_pos_y - _marker_map_size_y + _j];
		//diag_log format["checking markerpos %1",_newMarkerPos];
		if (!(surfaceIsWater _newMarkerPos) && ([_newMarkerPos] call _checkForValidArea)) then{
			
			AW_territoryCount = _markerCounter;
			_markerCounter = _markerCounter + 1;
		};
		_i = _i + _markerSteps;
	};
	_j = _j + _markerSteps;
};

_areaSquareMeters = _markerCounter * (_markerSteps * _markerSteps);

_AOMarkerName = format['AW_AO_%1',_passedAO];
_AOMarkerName setmarkerText format['%1',[_areaSquareMeters / 1000000,2] call BIS_fnc_cutDecimals];

_AOMarkerName setMarkerColor "ColorGreen";
{
	if (typeName _x == "ARRAY") then{
		if ((_x select 0) == _passedAO) exitWith{
			switch(_x select 1)do{
				case(-1):{_AOMarkerName setMarkerColor "ColorGreen";};
				case(0):{
					_AOMarkerName setMarkerColor "ColorRed";
					AW_RedTerrain = AW_RedTerrain + ([_areaSquareMeters / 1000000,2] call BIS_fnc_cutDecimals);
				};
				case(1):{
					_AOMarkerName setMarkerColor "ColorBlue";
					AW_BluTerrain = AW_BluTerrain + ([_areaSquareMeters / 1000000,2] call BIS_fnc_cutDecimals);
				};
			};
		};
	};
}forEach AW_c5_AOcontrol;

//AW_AOSizes set[count AW_AOSizes,[_passedAO,[_areaSquareMeters / 1000000,2] call BIS_fnc_cutDecimals]];