//player sidechat "added";

_this setVariable ["selections", ["wheel_1_1_steering","wheel_1_2_steering","wheel_1_3_steering","wheel_1_4_steering","wheel_2_1_steering","wheel_2_2_steering","wheel_2_3_steering","wheel_2_4_steering","vez","zbran",""], false]; //APC

_this addeventhandler ["HandleDamage",{
	_unit = _this select 0;
	_selection = _this select 1;
	_damage = _this select 2;
	
	_selections = _unit getVariable ["selections", []];
	
	if (_selection in _selections) then{
		_damage = _damage;
	}else{
		_damage = 0;
	};
	_damage
	//diag_log text format["%1, sel: %2, dam: %3",diag_tickTime,_selection,_damage];
}];