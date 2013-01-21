private["_vcl","_velocity","_chute"];

player sidechat format["z: %1",getpos player select 2];

_vcl = vehicle player;

player allowDamage false;
player action ["Eject", vehicle player];
unAssignVehicle player;


sleep 0.05;

player allowDamage true;

sleep 1;

if (player == vehicle player) then {
	diag_log "#DEBUG: your parachute bugged. An extra one will be created.";
	_velocity = velocity player;
	player allowDamage false;
	switch(playerSide)do{
		case (West):{_chute = createVehicle ["ParachuteWest", getpos player, [], 0, "NONE"];player moveInDriver _chute;};
		case (East):{_chute = createVehicle ["ParachuteEast", getpos player, [], 0, "NONE"];player moveInDriver _chute;};
		default {_chute = createVehicle ["ParachuteWest", getpos player, [], 0, "NONE"];player moveInDriver _chute;};
	};
	vehicle player setVelocity _velocity;
	player allowDamage true;
	
	sleep 2;

	//if (vehicle player != _chute) then {deleteVehicle _chute};
	waitUntil{vehicle player != _chute};
	sleep 2;
	if (alive _chute) then {deleteVehicle _chute;};
};
//diag_log "#DEBUG: para script done (parafix.sqf)";