/*
* Created By Jones
* last updated 1/16/2012
*/

///total value of all vehicles destroyed per side
AW_westWarExpenditure = 0;
AW_eastWarExpenditure = 0;
publicVariable "AW_westWarExpenditure";
publicVariable "AW_eastWarExpenditure";

/*
* Vehicle Destruction public events
*/
AW_CancelDestructionArray = [];

"aw_action_DestructionInfo" addPublicVariableEventHandler{
	if (isServer) then{
		[aw_action_DestructionInfo] spawn AW_fnc_InitiateSelfDestruction;
	};
};

"aw_action_CancelDestructionInfo" addPublicVariableEventHandler{
	if (isServer) then{
		[aw_action_CancelDestructionInfo] spawn AW_fnc_CancelSelfDestruction;
	};
};
/*
* vehicle respawn function
* param 0: side
* param 1: int, value of vehicle
* returns: N/A
*/
AW_Func_addCostGlobal ={
	private["_side","_value"];
	_side = _this select 0;
	_value = _this select 1;
	
	switch(_side)do{
		case west:{
			AW_westWarExpenditure = AW_westWarExpenditure + _value;
			publicVariable "AW_westWarExpenditure";
			};
		case east:{
			AW_eastWarExpenditure = AW_eastWarExpenditure + _value;
			publicVariable "AW_eastWarExpenditure";
		};
		default{};
	};
};

AW_Func_crewCheck ={
	private[];
	_vehicle = _this select 0;
	_checkType = _this select 1;
	switch(_checkType)do{
		case 1:{_vehicle addEventHandler ["GetIn", {_this execVM "core\vehicleManager\pilotChecker.sqf"}];};
		case 2:{_vehicle addEventHandler ["GetIn", {_this execVM "core\vehicleManager\crewChecker.sqf"}];};
		default{};
	};
};


/*
* vehicle respawn function
* param: vehicle config entry, found in config.sqf in the root folder
* returns: N/A
*/
_vehicleRespawner ={
	if (!isServer) exitWith {};
	private["_config","_vehicle","_spawnPos","_direction",
			"_type","_vehicleName","_respawnTime","_side",
			"_value","_checkType"];
	_config = _this select 0;
	_vehicleName = _config select 0;
	_respawnTime = _config select 1;
	_side = _config select 3;
	_value = _config select 4;
	_checkType = _config select 5;
	
	_vehicle = call compile _vehicleName;
	_spawnPos = getpos _vehicle;
	_direction = direction _vehicle;
	_type = typeOf _vehicle;
	
	while{AW_isGameRunning}do{
		if(_checkType > 0)then{[_vehicle,_checkType]call AW_Func_crewCheck;};
		if (_vehicleName in ["west_CV","east_CV"]) then {_vehicle setVariable ["IsDeployed", 0, true];};
		//diag_log "#debug (vehicleManager\server.sqf)";
		//diag_log format["#DEBUG: vehiclename is %1, vehicle is %2 (vehicleManager\server.sqf)",_vehicleName,_vehicle];
		waitUntil {!alive _vehicle};
		[_side,_value]call AW_Func_addCostGlobal;
		if(AW_trainingEnabled_Param != 1)then{
			sleep _respawnTime;
		}else{
			sleep 30;
		};	
		deleteVehicle _vehicle;
		_vehicle = _type createVehicle _spawnPos;
		_vehicle setVehicleVarName _vehicleName;
		_vehicle call Compile Format ["%1=_this; PublicVariable ""%1""",_vehicleName];	
		_vehicle setdir _direction;
		_vehicle setpos _spawnPos;
		
		//make the server tell clients to reassign eventhandler for the new vehicle and also let it do itself, so it's running on both again
		//also set the damage variable again on the new vehicle
		AW_RespawningVehicle = call compile _vehicleName;
		PublicVariable "AW_RespawningVehicle";
		[AW_RespawningVehicle]call fnc_RenewDamageEventhandler;
		//reassign the mpkilled EH
		//[AW_RespawningVehicle]call fnc_RenewMPKilledEventhandler; //WIP
		//Var and VarEventhandler for the CV/MHQ
		//[AW_RespawningVehicle]call fnc_RenewDamageEventhandler;
	};
};

//apply respawn to all vehicles
{[_x]spawn _vehicleRespawner;}forEach AW_westVehicleArray_Cfg;
{[_x]spawn _vehicleRespawner;}forEach AW_eastVehicleArray_Cfg;