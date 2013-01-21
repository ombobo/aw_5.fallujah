_this select 0 addeventhandler ["HandleDamage",{
	_unit = _this select 0;
	_selection = _this select 1;
	_damage = _this select 2;
	_source = _this select 3;
	_projectile = _this select 4;
	
	player sidechat format["%1, %2, %3",_unit,_selection,_damage];
}];