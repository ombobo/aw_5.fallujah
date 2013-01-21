//NEEDS TO BE REWORKED TO ACTUALLY WORK INGAME
//SETVARIABLES

_this select 0 addeventhandler ["HandleDamage",{
	
	_unit = _this select 0;
	_selections = _unit getVariable ["selections", []];
	_gethit = _unit getVariable ["gethit", []];
	_selection = _this select 1;
	if !(_selection in _selections) then
	{
		_selections set [count _selections, _selection];
		_gethit set [count _gethit, 0];
	};
	_i = _selections find _selection;
	_olddamage = _gethit select _i;
	_damage = _olddamage + ((_this select 2) - _olddamage) * 1;
	_gethit set [_i, _damage];
	_damage;
}]; // addeventhandler end