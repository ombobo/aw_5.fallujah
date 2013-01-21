//add the eventhandler which triggers where the vehicle is local
_this select 0 addeventhandler ["HandleDamage",{
	//to handle actual damage just return '_this select 2'
	//our own handling below. Passed array for the Eventhandler: [unit, selectionName, damage, source, projectile]
	_unit = _this select 0;
	_selection = _this select 1;
	_damage = _this select 2;
	_projectile = _this select 4;
	
	//diag_log _selection;
	
	#define __projectilecfg configFile >> "cfgAmmo" >> _projectile //similar from ACE :P
	
	_damageLimit = 0.6; //Damage to any part will be capped at this value. Only applies for certain selections.
	_multiplier = 1; //want to half the incoming damage ? Just set this to 0.5, and so on.
	
	//adjust the vehicle variables and update their values, which keep track of the damage and the part of the vehicle hit
	_selections = _unit getVariable ["selections", []];
	_gethit = _unit getVariable ["gethit", []];
	if (_selection in _selections) then{
		_i = _selections find _selection;
		
		_olddamage = _gethit select _i;
		_newdamage = (_damage - _olddamage) * _multiplier;
		_uncapped = _newdamage;
		
		_shortNum = {
			_short = _this select 0;
			_short = (round (_short * 10000)) / 10000;
			_short;
		};
		
		_capDamageFunction = {
			_capValue = _this select 0;
			if (_newdamage > _capValue) then{
				_newdamage = _capValue;
			};
		};
		
		_checkRelDir = {
				_return = [_this select 0,_this select 1]call BIS_fnc_relativeDirTo;
				if (_return < 0) then{_return = _return + 360;};
				//player sidechat format["#DEBUG: relDir %1",_return]; //DEBUG comment this out
				_return;
		};
		
		//order of cases is important here!
		switch(true)do{
			//case (_selection == ""):{_newdamage = 0;};
			///M136 - AT
			case (_projectile == "AW_R_M136_AT"):{
				if (_selection == "") then{
					[_damageLimit]call _capDamageFunction;
				};
			};
			///IFV missile
			case (_projectile == "AW_M_AT5_AT" || _projectile == "AW_M_TOW_AT"):{
				if (_selection == "" && (_newdamage > 0.9)) then{
					_newdamage = 0.9;
				};
			};
			///BulletBase (IFV cannon, small arms) //ignore the damage if the caliber value is 1 or below (762x51 for example has a value of 1. Vehicel AP and HE is usualy above)
			case (_projectile isKindOf "BulletBase"):{
				_caliber = getNumber(__projectilecfg >> "caliber");
				switch(true)do{
					case (_caliber <= 1):{_newdamage = 0;};
					case (_selection == ""):{
						if (_newdamage > 0.02) then{_newdamage = 0.02;}; //cap new damage at 2% for hull and engine (T90 turret hit sometimes produces high engine damage)
					};
					case (_selection == "vez" || _selection == "zbran"):{
						if (_newdamage > 0.05) then{_newdamage = 0.05;};
					};
					default {};
				};
			};
			///Tank Shells
			case (_projectile == "AW_Sh_120_SABOT" || _projectile == "AW_Sh_125_SABOT"):{
				if ((_selection == "") && (_newdamage > 0.85)) then{
					_newdamage = 0.85;
				};
			};
			case (_projectile == "AW_Sh_120_HE" || _projectile == "AW_Sh_125_HE"):{
				if ((_selection == "") && (_newdamage > 0.5)) then{
					_newdamage = 0.5;
				};
			};
			///Arty
			case (_projectile == "AW_Sh_105_HE"):{
				if ((_selection == "") && (_newdamage > 0.85)) then{
					_newdamage = 0.85;
				};
			};
			///Satchel
			case (_projectile == "PipeBomb"):{
					if (_selection == "") then{
					_newdamage = _newdamage * 4;
				};
			};
			///Mine
			case (_projectile == "Mine"):{
					if (_selection == "") then{
					_newdamage = _newdamage * 5;
				};
			};
			default {};
		};
		
		if (!isServer && alive _unit) then{
			//if (_newdamage > 0.5) then{AW_DH_syncNow = true};
			_unit setVariable ["AW_DH_lastHit", diag_tickTime, false];
			_unit setVariable ["AW_DH_synced", false, false];
			if !(_unit in AW_DH_localVehicles) then{
				AW_DH_localVehicles set [count AW_DH_localVehicles,_unit];
				//diag_log format["#debug: added %1 to loacl vehicles",_unit];
			};
		};
		
		_damage = _olddamage + _newdamage;
		if (_damage > 1) then{
			_damage = 1;
			if (_selection == "" && alive _unit) then{
				_unit setDamage 1;
			};
		};
		_gethit set [_i, _damage];
	}else{
		_damage = 0;
	};
	
	
	_damage;
	
}]; //addeventhandler end