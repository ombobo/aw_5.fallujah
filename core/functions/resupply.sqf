private["_unit","_delay","_direction","_position","_type","_range"];
if (!isServer) exitWith {};
_unit = _this select 0;
_delay = if(count _this > 1)then{_this select 1}else{60};
if (_delay < 0)then{_delay = 0};
_range = 200;
_direction = getDir _unit;
_position = getPosASL _unit;
_type = typeOf _unit;

while {true}do{	
	waitUntil{getPosASL _unit distance _position > _range};
	sleep _delay;
	_unit = _type createVehicle _position;
	_unit setPosASL _position;
	_unit setDir _direction;	
};