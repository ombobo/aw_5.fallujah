private["_passedArray","_objectClassString","_newPos","_distanceFromPlayer","_cost","_distance","_calculatedDistance"];

_passedArray = _this select 3;

_objectClassString = _passedArray select 0;
_distanceFromPlayer = _passedArray select 1;
_cost = _passedArray select 2;

if (faction player == "AW_BLU" && _cost > [] call AW_GetRessourcePoints) exitWith{player sidechat "#Info: Not enough ressources for this object.";};
if (faction player == "AW_RED" && _cost > [] call AW_GetRessourcePoints) exitWith{player sidechat "#Info: Not enough ressources for this object.";};

//player sidechat format["###Debug: additional: %1,%2,%3",_objectClassString,_distanceFromPlayer,_cost];
	
_xPos = (getPos player select 0) + (_distanceFromPlayer * (cos ((direction player - 90) * (-1))));
_yPos = (getPos player select 1) + (_distanceFromPlayer * (sin ((direction player - 90) * (-1))));
_newPos = [_xPos,_yPos,0];
//_distance = _newPos distance CommandVehicle;

_distance = 999;
{
	_calculatedDistance = _newPos distance _x;
	if (_calculatedDistance < _distance) then {_distance = _calculatedDistance}
}forEach [AW_friendlyCV]+AW_friendlySupplyTrucks;

//exit the script and dont place an object if trying to place it too far away from the CV
if (_distance > AW_distanceToBuild) exitWith {player sidechat "You are too far from your CV"};

ObjName = createVehicle [_objectClassString, [_xPos,_yPos,0], [], 0, "CAN_COLLIDE"];

ObjName setDir direction player;
ObjName setPos _newPos;

switch (faction player)do{
	case ("AW_BLU"):{
		AW_NewFortificationWest = ["WEST",ObjName,_cost,AW_FM_BuildingFrom];PublicVariableServer "AW_NewFortificationWest";
		ObjName setVariable ["sideValue", 0, true];
		//player sidechat format["#DEBUG: objname: %1, sidevalue %2",ObjName,0];
	};
	case ("AW_RED"):{
		AW_NewFortificationEast = ["EAST",ObjName,_cost,AW_FM_BuildingFrom];PublicVariableServer "AW_NewFortificationEast";
		ObjName setVariable ["sideValue", 1, true];
	};
	default {};
};

if (isServer) then {
	switch (faction player)do{
		case ("AW_BLU"):{
			AW_NewFortificationWest call AW_Fortification_To_Array;
			switch (AW_NewFortificationWest select 3)do{
				case (0):{AW_West_Ressources = AW_West_Ressources - (AW_NewFortificationWest select 2);};
				case (1):{AW_West_RessourcesTrucks = AW_West_RessourcesTrucks - (AW_NewFortificationWest select 2);};
				default {};
			};
		};
		case ("AW_RED"):{
			AW_NewFortificationEast call AW_Fortification_To_Array;
			switch (AW_NewFortificationEast select 3)do{
				case (0):{AW_East_Ressources = AW_East_Ressources - (AW_NewFortificationEast select 2);};
				case (1):{AW_East_RessourcesTrucks = AW_East_RessourcesTrucks - (AW_NewFortificationEast select 2);};
				default {};
			};
		};
		default {};
	};
};

sleep 0.1;

AW_KillFortificationSpawning = true;