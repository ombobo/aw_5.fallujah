private["_vehicle","_checkvar"];


_setEHTest = {
	[_vehicle]call fnc_RenewEHTest;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
};

_setEHVodnik = {
	[_vehicle]call fnc_RenewEHVodnik;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
};

_setEHMBT = {
	[_vehicle]call fnc_RenewEHMBT;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
	_vehicle setVariable ["selections", ["motor","telo","NEtelo","pas_l","pas_p","vez","zbran",""], false];
	if (isServer) then{[_vehicle] call fnc_resetGetHitArray;};
};

_setEHIFV = {
	[_vehicle]call fnc_RenewEHIFV;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
	_vehicle setVariable ["selections", ["motor","telo","NEtelo","pas_l","pas_p","vez","zbran",""], false];
	if (isServer) then{[_vehicle] call fnc_resetGetHitArray;};
};

_setEHMBTTEST = {
	[_vehicle]call fnc_RenewEHMBTTEST;
	//[_vehicle]call fnc_RenewEHMBT;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
	_vehicle setVariable ["selections", ["motor","telo","NEtelo","pas_l","pas_p","vez","zbran",""], false];
	if (isServer) then{[_vehicle] call fnc_resetGetHitArray;};
};

_setEHIFVTEST = {
	[_vehicle]call fnc_RenewEHIFVTEST;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
};

_setEHC130 = {
	[_vehicle]call fnc_RenewEHC130;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
};

_setEHAPC = {
	[_vehicle]call fnc_RenewEHAPC;
	_vehicle setVariable ["IsEHSet", 1, false];
	_vehicle setVariable ["selections", ["wheel_1_1_steering","wheel_1_2_steering","wheel_1_3_steering","wheel_1_4_steering","wheel_2_1_steering","wheel_2_2_steering","wheel_2_3_steering","wheel_2_4_steering","vez","zbran",""], false]; //APC
	if (isServer) then{[_vehicle] call fnc_resetGetHitArray;};
};

_setEHCV = {
	[_vehicle]call fnc_RenewEHCV;
	[_vehicle]call fnc_RenewEHAPC;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
	//_vehicle setVariable ["selections", ["motor","telo","NEtelo","pas_l","pas_p","vez","zbran",""], false]; //IFV
	_vehicle setVariable ["selections", ["wheel_1_1_steering","wheel_1_2_steering","wheel_1_3_steering","wheel_1_4_steering","wheel_2_1_steering","wheel_2_2_steering","wheel_2_3_steering","wheel_2_4_steering","vez","zbran",""], false]; //APC
	if (isServer) then{[_vehicle] call fnc_resetGetHitArray;};
	if (isServer) then {
		_vehicle setVariable ["IsDeployed", 0, true];
		_vehicle setVariable ["DeployTime", -1, true];
	};
};

_setEHPlayer = {
	[_vehicle]call fnc_RenewEHPlayer;
	_vehicle setVariable ["IsEHSet", 1, false];
	_vehicle setVariable ["selections", [], false];
	_vehicle setVariable ["gethit", [], false];
};

_setEHMHQ = {
	[_vehicle]call fnc_RenewEHMHQ;
	//player sidechat format["#DEBUG: setting EH for %1",_vehicle];
	_vehicle setVariable ["IsEHSet", 1, false];
};

_vehicle = _this select 0;
_checkvar = _vehicle getVariable "IsEHSet";

if ((alive _vehicle) && (isNil "_checkvar"))then{
	switch (_vehicle) do{
		case (player): {AW_EH_player = []call _setEHPlayer};
		
		case (west_apc_1): {AW_EH_west_apc = []call _setEHAPC};
		case (west_apc_2): {AW_EH_west_apc = []call _setEHAPC};
		case (east_apc_1): {AW_EH_east_apc = []call _setEHAPC};
		case (east_apc_2): {AW_EH_east_apc = []call _setEHAPC};
		
		case (west_ifv_1): {AW_EH_west_ifv = []call _setEHIFV};
		case (west_ifv_2): {AW_EH_west_ifv = []call _setEHIFV};
		case (east_ifv_1): {AW_EH_east_ifv = []call _setEHIFV};
		case (east_ifv_2): {AW_EH_east_ifv = []call _setEHIFV};
		
		case (west_cv): {AW_EH_west_cv = []call _setEHCV};
		case (east_cv): {AW_EH_east_cv = []call _setEHCV};
		default{};
	};
	
	if (isServer) then{
		_vehicle addeventhandler ["Fired",{
			_vehicle = _this select 0;
			_hasFired = _vehicle getVariable ["hasFired", 0];
			if (_hasFired == 0) then{_vehicle setVariable ["hasFired", 1, true];};		
		}];
	};
};

//player sidechat format["#DEBUG: IsEHSet for vcl %1 is %2",_vehicle,(_vehicle getVariable "IsEHSet")];
//diag_log format["#DEBUG: IsEHSet for vcl %1 is %2",_vehicle,(_vehicle getVariable "IsEHSet")];