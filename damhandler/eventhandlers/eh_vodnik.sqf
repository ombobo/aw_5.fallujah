//NEEDS TO BE REWORKED TO ACTUALLY WORK INGAME
//SETVARIABLES

_this select 0 addeventhandler ["HandleDamage",{
	
	//handle actual damage by returning '_this select 2'
	
	//our own handling instead
	_vehicle = _this select 0;
	_area = _this select 1;
	_damage = _this select 2;
	_projectile = _this select 4;
	
	_returnvalue = 0;
	
	
	//check if projectile is in the list of special projectiles
	switch(_projectile)do{
		case ("PipeBomb"):{_returnvalue = _damage;}; //take actual satchel damage and apply damage to all hit parts. Not just the hull (distance is important here)
		case ("G_30mm_HE"):{_returnvalue = _damage;};
		case ("Mine"):{_returnvalue = _damage;};
		default {}; //otherwise do nothing
	};
	
	switch(true)do{
		case (_area == "" && ((_damage - (damage _vehicle)) > 0.001)):{
			switch(_projectile)do{
				case ("AWB_25mm_APDS_RED"):{[_vehicle,0.01667]call fnc_IncreaseDamage;};
				case ("AWB_25mm_APDS_GREEN"):{[_vehicle,0.01667]call fnc_IncreaseDamage;};
				case ("AW_B_25mm_HEI_RED"):{[_vehicle,0.0125]call fnc_IncreaseDamage;};
				case ("AW_B_25mm_HEI_GREEN"):{[_vehicle,0.0125]call fnc_IncreaseDamage;};
				case ("AW_R_M136_AT"):{if ((_damage - (damage _vehicle)) < 0.25) then{[_vehicle,_damage]call fnc_IncreaseDamage;}else{[_vehicle,0.55]call fnc_IncreaseDamage;};};
				default {_returnvalue = _damage;}; //experimental, lets all non specified ammo pass through normally
			};
			///DEBUG
			//PublicDebugMessage = format["#DEBUG: vcl %1 receiving %2 dam. | dam. now at %3",_vehicle,(_returnvalue - damage _vehicle),_returnvalue];
			//publicVariable "PublicDebugMessage";
			//if (!isServer) then{player sidechat format["#DEBUG: vcl %1 receiving %2 dam. | dam. now at %3",_vehicle,(_returnvalue - damage _vehicle),_returnvalue];};
		};
		case (_area == "wheel_1_1_steering"):{_returnvalue = _damage;};
		case (_area == "wheel_1_2_steering"):{_returnvalue = _damage;};
		case (_area == "wheel_2_1_steering"):{_returnvalue = _damage;};
		case (_area == "wheel_2_2_steering"):{_returnvalue = _damage;};
		default {};
	};
	
	/*
	//check if damage is over 0.1% to ignore any projectile, that is passing through and hitting the vehicle a second time
	switch(true)do{
		case (_area == "" && ((_damage - (damage _vehicle)) > 0.001)):{
			switch(true)do{
				case (_projectile == "AWB_25mm_APDS_RED"):{_returnvalue = (damage _vehicle) + 0.01667;};
				case (_projectile == "AWB_25mm_APDS_GREEN"):{_returnvalue = (damage _vehicle) + 0.01667;};
				case (_projectile == "AW_B_25mm_HEI_RED"):{_returnvalue = (damage _vehicle) + 0.0125;};
				case (_projectile == "AW_B_25mm_HEI_GREEN"):{_returnvalue = (damage _vehicle) + 0.0125;};
				case (_projectile == "AW_R_M136_AT"):{if ((_damage - (damage _vehicle)) < 0.25) then{_returnvalue = _damage;}else{_returnvalue = (damage _vehicle) + 0.55;};};
				default {_returnvalue = _damage;}; //experimental, lets all non specified ammo pass through normally
			};
			///DEBUG
			//PublicDebugMessage = format["#DEBUG: vcl %1 receiving %2 dam. | dam. now at %3",_vehicle,(_returnvalue - damage _vehicle),_returnvalue];
			//publicVariable "PublicDebugMessage";
			//if (!isServer) then{player sidechat format["#DEBUG: vcl %1 receiving %2 dam. | dam. now at %3",_vehicle,(_returnvalue - damage _vehicle),_returnvalue];};
		};
		case (_area == "wheel_1_1_steering"):{_returnvalue = _damage;};
		case (_area == "wheel_1_2_steering"):{_returnvalue = _damage;};
		case (_area == "wheel_2_1_steering"):{_returnvalue = _damage;};
		case (_area == "wheel_2_2_steering"):{_returnvalue = _damage;};
		default {};
	};
	*/
	
	_returnvalue;
	
}]; // addeventhandler end