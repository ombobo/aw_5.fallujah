_this select 0 addeventhandler ["HandleDamage",{
	//to handle actual damage just return '_this select 2'
	//our own handling below. Passed array for the Eventhandler: [unit, selectionName, damage, source, projectile]
	_unit = _this select 0;
	_selection = _this select 1;
	_damage = _this select 2;
	_source = _this select 3;
	_projectile = _this select 4;
	_newCollateral = 0;
	
	if (_selection == "") then{
		//if (_damage > 1) then {_damage = 1;};
		_newDamage = _damage - damage _unit;
		if (_newDamage > 0.02) then{
			switch (_projectile) do{
				case("AW_Sh_105_HE"):{_newCollateral = 1;};
				case("AW_Sh_120_SABOT"):{_newCollateral = 0.6;};
				case("AW_Sh_125_SABOT"):{_newCollateral = 0.6;};
				case("AW_Sh_120_HE"):{_newCollateral = 1;};
				case("AW_Sh_125_HE"):{_newCollateral = 1;};
				case("AW_M_AT5_AT"):{_newCollateral = 1;};
				case("AW_M_TOW_AT"):{_newCollateral = 1;};
				case("AW_R_M136_AT"):{_newCollateral = 0.6;};
				default{};
			};
		};
		_newCollateral = _newCollateral max _newDamage;
		_newCollateral = _newCollateral min 1;
		switch (faction gunner _source)do{
			case("AW_BLU"):{AW_civDamageByBlu = AW_civDamageByBlu + _newCollateral};
			case("AW_RED"):{AW_civDamageByRed = AW_civDamageByRed + _newCollateral};
			default{};
		};
		//PublicDebugDamMessage = format["total: %1, new: %2",_damage,_newDamage];
		//publicVariable "PublicDebugDamMessage";
		if (!isDedicated) then{
			//player sidechat format["%1 %2 %3 %4",_newDamage,typeOf _unit,_newCollateral,faction gunner _source];
		};
	};
	
	_damage
}];
/*
_this select 0 addeventhandler ["killed",{
	_unit = _this select 0;
	_killer = _this select 1;
	
	if (!isDedicated) then{
		player sidechat format["Destroyed by faction: %1",faction gunner _killer];
	};

	switch (faction gunner _killer)do{
		case("AW_BLU"):{AW_civDamageByBlu = AW_civDamageByBlu + 0.5};
		case("AW_RED"):{AW_civDamageByRed = AW_civDamageByRed + 0.5};
	};
}];
*/
