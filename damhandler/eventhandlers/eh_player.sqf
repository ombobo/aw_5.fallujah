_this select 0 addeventhandler ["HandleDamage",{
	
	_unit = _this select 0;
	_selection = _this select 1;
	_damage = _this select 2;
	_source = _this select 3;
	_projectile = _this select 4;

	_selections = _unit getVariable ["selections", []];
	_gethit = _unit getVariable ["gethit", []];
	if !(_selection in _selections) then{
		_selections set [count _selections, _selection];
		_gethit set [count _gethit, 0];
		//player sidechat format["#DEBUG: added to array. array count: %1",count _selections];
	};
	_i = _selections find _selection;
	_olddamage = _gethit select _i;
	_newdamage = _damage - _olddamage;
	
	if (!AW_allowPlayerDamage) then{_newdamage = 0;};
	
	_damage = _olddamage + _newdamage;
	_gethit set [_i, _damage];
	
	//player sidechat format["#DEBUG: dam: %1, newdam: %2, source: %3, proj: %4",_damage,_newdamage,_source,_projectile];
	
	_damage;	
}];

//test script below, that makes the player switch to an unconcious animation for some time when hit by a grenade or some other big explosion

/*
_this select 0 addeventhandler ["HandleDamage",{
	
	//handle actual damage by returning '_this select 2'
	
	//our own handling instead
	_vehicle = _this select 0;
	_area = _this select 1;
	_damage = _this select 2;
	_projectile = _this select 4;
	_newdamage = (_damage - (damage _vehicle));
	
	_returnvalue = _damage;
	
	_unconState = {		
		player sidechat format["#DB: playerisuncon is %1",playerisuncon];
		
		_unconTime = _this select 0;
		_unconTime = _unconTime * 40;
		if (_unconTime > 12) then {_unconTime = 12;};
		
		player sidechat format["#DB: uncontime is %1 with time of %2",_this select 0,_unconTime];
		
		cutText ["","BLACK",1];
		1 fadeSound 0;
		player playMove "AinjPpneMstpSnonWrflDnon";
		
		sleep 3;
		
		cutText ["","BLACK IN",_unconTime - 3];
		_unconTime fadeSound 1;
		
		sleep (_unconTime - 3);
		
		player playMove "aidlppnemstpsraswrfldnon0s";
	};
	
	player sidechat format["###DEBUG: damage to %1 is %2",_area,_newdamage];
	if (_area == "head_hit" && _newdamage > 0.2) then{
		player sidechat "#DB: dam. is over 0.2";
		if (_projectile in AW_uncon_ammo) then{
				handle_uncon = [_newdamage]spawn _unconState;
		};
	};
	
	_returnvalue;
}];
*/