/*
* Created By Jones
* last updated 1/16/2012
*/
private["_loadClientScripts","_loadServerScripts"];

/*
* Loads client related scripts
*/
_loadClientScripts ={
	//[]execVM "core\respawn\setUnitSpawnPoints.sqf";
	
	[] call{
		private["_nameString","_nameArray","_i","_j","_ShortNameArray","_ShortNameString"];
		
		_nameString = name player;
		
		_nameArray = toArray(_nameString);
		_ShortNameArray = [];
		
		_NameDivider = toArray("]");
		_i = 0;
		//check where the first letter after the ']' is
		{
			if (_x == _NameDivider select 0) exitWith {_i = _i +1;};
			_i = _i + 1;
		}forEach _nameArray;
		//exit with full name if no ']' was detected
		if (_i != count _nameArray) then{
			//set array with shortened name
			_j = 0;
			for "_x" from _i to ((count _nameArray)-1) do{
				_ShortNameArray set [_j,_nameArray select _x];
				_j = _j + 1;
			};
			_ShortNameString = toString _ShortNameArray;
			AW_playerShortName = _ShortNameString;
		}else{
			AW_playerShortName = _nameString;
		};
	};
	
	AW_playerFullName = name player;
	
	AW_playerMarkerColor = 1;
	(vehicle player) setvariable ["unitname",AW_playerFullName,true];
	(vehicle player) setvariable ["unitShortName",AW_playerShortName,true];
	(vehicle player) setVariable ["AW_markerColor",AW_playerMarkerColor,true];
	
	player addEventHandler ["killed",{
		[(_this select 0),(_this select 1)]execVM "core\respawn\onPlayerKilled.sqf";
	}];
	
	player addEventHandler ["Respawn",{
		[(_this select 0),(_this select 1)]execVM "core\respawn\onPlayerRespawn.sqf";
		(vehicle player) setvariable ["unitname",AW_playerFullName,true];
		(vehicle player) setvariable ["unitShortName",AW_playerShortName,true];
		(vehicle player) setVariable ["AW_markerColor",AW_playerMarkerColor,true];
	}];
};
/*
* loads server related scripts
*/
_loadServerScripts ={
	
};
//single player (Editor mode)
if(!isMultiplayer)exitWith{
	[]call _loadServerScripts;
	[]call _loadClientScripts;
};
//server scripts
if(isServer)then{
	[]call _loadServerScripts;
};
// client scripts
if(!isServer)then{	
	[]call _loadClientScripts;
};
