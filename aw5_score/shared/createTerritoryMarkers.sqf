//handle = AW_handle_initializeAO
_passedAO = _this select 0;

//diag_log "starting createTerritorymarkers.sqf";

//kill the calc script so we can start recreating the AO immediately
//(it will only be initiated anyway if the server has done its calculations, which is the only important thing)
terminate AW_handle_calculateTerritory;

//reset controlled territory count for both sides as we are creating new ones now.
//they will be set correctly again the next time control is calculated
AW_bluTerritories = 0;
AW_redTerritories = 0;
AW_bluTotalScore = 0;
AW_redTotalScore = 0;
//----- Delete old territory markers
for "_i" from 0 to AW_territoryCount do{
	_AW_territoryMarkerName = format["AW_marker_territory_%1",_i];
	deleteMarkerLocal _AW_territoryMarkerName;
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

//diag_log "CTM setting bounding box";
//diag_log _passedAO;
//AOArray;
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

//diag_log "CTM get bounding box pos and size";
//----- Get territory bounding box position and size values
_marker_map_pos = markerPos "marker_map";
_marker_map_pos_x = _marker_map_pos select 0;
_marker_map_pos_y = _marker_map_pos select 1;
_marker_map_size_x = getMarkerSize "marker_map" select 0;
_marker_map_size_y = getMarkerSize "marker_map" select 1;

//diag_log "CTM create array of angles";
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

//diag_log format["_borderAnglesCenter %1",_borderAnglesCenter];
//diag_log format["_borderAnglesWidth %1",_borderAnglesWidth];
//diag_log format["_borderAnglesDir %1",_borderAnglesDir];

//diag_log "CTM start hint";
//----- Start Hint script
if !(isDedicated) then{
	AW_showMarkerCounter = [] spawn {
		while {true}do{
			if (scriptDone AW_handle_initializeAO) exitWith{};
			hintSilent format["(re)Creating territory\n%1",AW_territoryCount];
			sleep 0.02;
		};
	};
};

//diag_log "CTM start creating markers";
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
			_markerName = format["AW_marker_territory_%1",_markerCounter];
			_markerCounter = _markerCounter + 1;
			
			_markerName = createMarkerLocal [_markerName, _newMarkerPos];
			if (!isDedicated) then{
				_markerName setMarkerShapeLocal "RECTANGLE";
				_markerName setMarkerBrushLocal "Solid";
				_markerName setMarkerSizeLocal [_markerSteps / 2 - 0,_markerSteps / 2 - 0];
			};
		};
		_i = _i + _markerSteps;
	};
	_j = _j + _markerSteps;
};

_areaSquareMeters = _markerCounter * (_markerSteps * _markerSteps);

if (AW_AOScoreLimitSetting == -1) then{
	AW_AOScoreLimitTime = [_areaSquareMeters / 1000,0] call BIS_fnc_cutDecimals;
	AW_AOScoreLimitTime = AW_AOScoreLimitTime max (15 * 60);
	AW_AOScoreLimitTime = AW_AOScoreLimitTime min (40 * 60);
};

if !(isDedicated) then{
	AW_chatLogic globalChat format["Area of operations #%1 initialized",_passedAO];
	AW_chatLogic globalChat format["Size: %1 Km^2",[_areaSquareMeters / 1000000,2] call BIS_fnc_cutDecimals];
	AW_chatLogic globalChat format["Min. Capture Time: %1 Minutes",AW_AOScoreLimitTime / 60];
};

//AW_territoryCount = _markerCounter;

//----- Terminate hint script (should terminate itself now automatically, when the script ends)
/*
if (!isDedicated) then{
	terminate AW_showMarkerCounter;
};
*/