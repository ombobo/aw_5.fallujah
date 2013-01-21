
AW_setAmmoType = {
	if (AW_FireMission) exitWith {Hint "Wait Until Fire Mission is complete!";};
	_control = _this select 0;
	_index = _this select 1;
	AW_artyAmmoType = _control lbdata _index;
	if ((AW_artyAmmoType == "AW_SmokeShell")||(AW_artyAmmoType == "AW_SmokeShell_Green")||(AW_artyAmmoType == "AW_SmokeShell_Red"))then { AW_artySpawnAlt = 5;};
	if ((AW_artyAmmoType == "F_40mm_White")||(AW_artyAmmoType == "F_40mm_Red")||(AW_artyAmmoType == "F_40mm_Green"))then { AW_artySpawnAlt = 400;};
	ctrlSetText [9108 ,format["Ammo Type %1",AW_artyAmmoType ]];
};
AW_setDispersion = {
	if (AW_FireMission) exitWith {Hint "Wait Until Fire Mission is complete!";};
	_control = _this select 0;
	_index = _this select 1;
	AW_artyDispersion = parseNumber (_control lbdata _index);
	ctrlSetText [9107 ,format["Dispersion %1",(AW_artyDispersion* 2)]];
};
AW_setAmmoLoad = { 
	if (AW_FireMission) exitWith {Hint "Wait Until FIre Mission is complete!";};
	_control = _this select 0;
	_index = _this select 1;
	AW_RoundsLoaded = parseNumber (_control lbdata _index);
	if (side player == west) then 
	{	
		if (AW_RoundsLoaded > AW_westArtyAmmo) exitWith {Hint "Not enough Ammo to support this request!";};
	};
	  if (side player == east) then 
	{	
	if (AW_RoundsLoaded > AW_EastArtyAmmo) exitWith {Hint "Not enough Ammo to support this request!";};
	};
	ctrlSetText [9105 ,format["Rounds Loaded %1",AW_RoundsLoaded ]];
};

AW_Arty_FireMission = {
	private ["_targetpos", "_targetposx", "_targetposy", "_impact","_FMCounter","_TimeToImpact","_NoAmmo","_impactposx","_impactposy"];
	///prevents from being used twice at the same time
	if (AW_FireMission) exitWith {Hint "Fire Mission in Progress";};
	//ammo check
	if (side player == west) then 
	{	
		if (AW_RoundsLoaded > AW_westArtyAmmo) exitWith {_NoAmmo = true;};
	};
	  if (side player == east) then 
	{	
		if (AW_RoundsLoaded > AW_EastArtyAmmo) exitWith {_NoAmmo = true;};
	};
	if (_NoAmmo) exitWith {Hint "Not enough Ammo to support this request!";_NoAmmo = false;};
	///debug purposes
	//hint format ["Ammo %1\nDispersion %2\nAmmo loaded %3\nSpawn Alt %4",AW_artyAmmoType,AW_artyDispersion,AW_RoundsLoaded,AW_artySpawnAlt];
	AW_FireMission = true;
	ctrlSetText  [9109 ,"Fire Support Busy"];
	_FMCounter = 0;
	///determine the time to impact based on distance from base
	if (side player == west) then 
	{
		_targetposx = AW_FM_PositionWest select 0;
		_targetposy = AW_FM_PositionWest  select 1;
		_TimeToImpact = ceil ((((getMarkerPos "respawn_west") distance AW_FM_PositionWest)/400)+10);
		
	};
	if (side player == east) then 
	{
		_targetposx = AW_FM_PositionEast select 0;
		_targetposy = AW_FM_PositionEast  select 1;
		_TimeToImpact = ceil ((((getMarkerPos "respawn_east") distance AW_FM_PositionEast)/400)+10);
		
	};
	if (side player == west) then 
	{	
		[WEST,"HQ"] sideChat format ["Fire Mission impact in %1 Seconds",_TimeToImpact];
		sleep _TimeToImpact;
		[WEST,"HQ"] sideChat "Splash";
	};
	if (side player == east) then 
	{	
		[EAST,"HQ"] sideChat format ["Fire Mission impact in %1 Seconds",_TimeToImpact];
		sleep _TimeToImpact;
		[EAST,"HQ"] sideChat "Splash";
	};
	
	while {_FMCounter < AW_RoundsLoaded} do
	{
		if ((random 100) > 50) then
		{
			_impactposx = _targetposx +(random AW_artyDispersion);
		}else{
			_impactposx = _targetposx -(random AW_artyDispersion);
		};
		if ((random 100) > 50) then
		{
			_impactposy = _targetposy +(random AW_artyDispersion);
		}else{
			_impactposy = _targetposy -(random AW_artyDispersion);
		};	
		_impact = AW_artyAmmoType  createVehicle [_impactposx, _impactposy, AW_artySpawnAlt];	
		_FMCounter = _FMCounter + 1;	
		Sleep 3;
	};
	
	///ammo deductions
	if (side player == west) then 
	{
		[WEST,"HQ"] sideChat "Rounds Complete";
		AW_westArtyAmmo = AW_westArtyAmmo - AW_RoundsLoaded;
		publicVariable "AW_westArtyAmmo";
		ctrlSetText  [9106 ,format["Ammo Supply %1",AW_westArtyAmmo ]];
	};
	if (side player == east) then 
	{
		[EAST,"HQ"] sideChat "Rounds Complete";
		AW_EastArtyAmmo = AW_EastArtyAmmo - AW_RoundsLoaded;
		publicVariable "AW_EastArtyAmmo";
		ctrlSetText [9106 ,format["Ammo Supply %1",AW_EastArtyAmmo ]];
	};
	AW_FireMission = false;
	ctrlSetText  [9109 ,"Fire Support Waiting"];
};
