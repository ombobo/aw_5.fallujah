private["_vehicle","_counter","_entries","_tempGetHitArray"];
_vehicle = _this select 0;
_counter = 0;
_entries = count (_vehicle getVariable ["selections",[]]);
_tempGetHitArray = [];
while {_counter < _entries} do{
	_tempGetHitArray set [_counter,0];
	_counter = _counter + 1;
};
_vehicle setVariable ["gethit", _tempGetHitArray, true];