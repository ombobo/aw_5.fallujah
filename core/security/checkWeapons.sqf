private["_unit","_side","_checkScript","_weaponsToCheck","_unitType","_ATBlu","_ATRed","_HMGBlu","_HMGRed","_LMGBlu","_LMGRed","_SniperBlu","_SniperRed"];

_checkScript = {
	private["_excludedWeapons"];
	
	_excludedWeapons = _this;
	
	//player sidechat format["Debug: checking %1",_unit];
	
	{
		if (_x in _weaponsToCheck && !(_x in _excludedWeapons)) then{
			player sidechat format["#Info: %1 uses restricted weapon %2",name _unit,_x];
		};
		
		switch(_x)do{
			case("AW_M136"):{
				switch(_side)do{
					case(WEST):{_ATBlu = _ATBlu + 1;};
					case(EAST):{_ATRed = _ATRed + 1;};
				};
			};
			case("AW_M60A4_EP1"):{_HMGBlu = _HMGBlu + 1;};
			case("AW_PK"):{_HMGRed = _HMGRed + 1;};
			case("AW_M249_EP1"):{_LMGBlu = _LMGBlu + 1;};
			case("AW_MG36"):{_LMGRed = _LMGRed + 1;};
			case("AW_M110_NVG_EP1"):{
				switch(_side)do{
					case(WEST):{_SniperBlu = _SniperBlu + 1;};
					case(EAST):{_SniperRed = _SniperRed + 1;};
				};
			};
		};
		
	}forEach [primaryWeapon _unit,secondaryWeapon _unit];
};

_weaponsToCheck = ["AW_M136","AW_M60A4_EP1","AW_M249_EP1","AW_PK","AW_MG36","AW_M110_NVG_EP1"];

_ATBlu = 0;
_ATRed = 0;
_HMGBlu = 0;
_HMGRed = 0;
_LMGBlu = 0;
_LMGRed = 0;
_SniperBlu = 0;
_SniperRed = 0;

{
	_unit = call compile _x;
	if (alive _unit) then{
		_side = side _unit;
		_unitType = typeOf _unit;
		switch (_unitType) do{
			//AT
			case("AW_BLU_W_AT"):{["AW_M136"] call _checkScript};
			case("AW_RED_W_AT"):{["AW_M136"] call _checkScript};
			//HMG
			case("AW_BLU_W_HMG"):{["AW_M60A4_EP1"] call _checkScript};
			case("AW_RED_W_HMG"):{["AW_PK"] call _checkScript};
			//LMG
			case("AW_BLU_W_LMG"):{["AW_M249_EP1"] call _checkScript};
			case("AW_RED_W_LMG"):{["AW_MG36"] call _checkScript};
			//Sniper
			case("AW_BLU_W_Sniper"):{["AW_M110_NVG_EP1"] call _checkScript};
			case("AW_RED_W_Sniper"):{["AW_M110_NVG_EP1"] call _checkScript};
			default{[] call _checkScript};
		};
	};
	sleep 0.01;
}forEach AW_allUnits_Cfg;

hint format["Blu | Red" + "\n" + "AT: %1 | %2" + "\n" + "HMG: %3 | %4" + "\n" + "LMG: %5 | %6" + "\n" + "Sniper: %7 | %8",_ATBlu,_ATRed,_HMGBlu,_HMGRed,_LMGBlu,_LMGRed,_SniperBlu,_SniperRed];