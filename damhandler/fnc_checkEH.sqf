private["_checkvar","_WarningCode","_vehicle"];

_WarningCode = {
	player sidechat "### Warning: Local Eventhandler for this vehicle is not set correctly ###";
	player sidechat "### Attempting to correct this now ###";
	[AW_RespawningVehicle]call fnc_RenewDamageEventhandler;
	
	sleep 2;
	
	_checkvar = (vehicle player) getVariable "IsEHSet";
	
	if (isNil "_checkvar") then{
		player sidechat "### Eventhandler still not correct, please inform a TM ###";
	}else{
		player sidechat "### Eventhandler fixed, You are good to go ###";
	};
};

_checkvar = "something :D";

while {true} do{
	waitUntil{player == vehicle player || !(local vehicle player)};
	//player sidechat "#DEBUG: Player is now not in a vehicle or the vehicle became local to another machine";
	waitUntil{player != vehicle player && (local vehicle player)};
	_vehicle = vehicle player;
	
	//player sidechat format["###DEBUG: checking EH var for vcl %1. var is %2",vehicle player,(vehicle player) getVariable "IsEHSet"];
	
	_checkvar = (vehicle player) getVariable "IsEHSet";
	if (isNil "_checkvar") then{
		switch (vehicle player) do{
			case (west_ifv): {[]call _WarningCode};
			case (west_mbt): {[]call _WarningCode};
			case (east_ifv): {[]call _WarningCode};
			case (east_mbt): {[]call _WarningCode};
			case (west_cv): {[]call _WarningCode};
			case (east_cv): {[]call _WarningCode};
			case (west_c130j): {[]call _WarningCode};
			case (east_c130j): {[]call _WarningCode};
			default{};
		};
	};
	//request the current gethit array of the vehicle
	//player sidechat "#DEBUG: This vehicle is now local to the player. Requesting GetHit array from the server";
	AW_DH_synced = false;
	AW_DH_requestArray = [player,_vehicle,true];
	PublicVariableServer "AW_DH_requestArray";
	//waitUntil{AW_DH_synced};
	//player sidechat format["local array for vehicle: %1",_vehicle getVariable ["gethit",[]]];
};