if (!isServer) exitWith {};
_object = _this select 0;
_spawnPos = getpos _object;
_direction = direction _object;
_type = typeOf _object;
waitUntil {not alive _object};
deleteVehicle _object;
_object =_type createVehicle _spawnPos;
_object setdir _direction;
_object setpos _spawnPos;
[_object,_delay] execVM "server\objectRespawn.sqf";


