private["_vehicle","_newdamage"];
//0 = vehicle, 1 = damage
_vehicle = _this select 0;
_newdamage = _this select 1;
//diag_log format["###DEBUG: assigning %1 damage to vehicle %2",_newdamage,_vehicle];
_vehicle setVariable ["vcldam", ((_vehicle getVariable "vcldam") + _newdamage), true];

//PublicDebugMessage = format["#DEBUG: assigning %1 damage to vehicle %2",_newdamage,_vehicle];
//publicVariable "PublicDebugMessage";