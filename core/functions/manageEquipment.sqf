private["_AW_addWeapon"];

_AW_addWeapon = {
	{
		player addweapon _x;
	}forEach _this;
};

//player sidechat format["%1",weapons player];

//--- Nightvision
if ("NVGoggles" in weapons player) then{player removeWeapon "NVGoggles"};

//--- Binos
if !("Binocular" in weapons player) then{
	player addweapon "Binocular";;
};

switch (typeOf player) do{
	//--- BluFor
	
	//case("AW_BLU_W_Engineer"):{["NVGoggles"] call _AW_addWeapon;};
	//case("AW_BLU_W_Crew"):{["NVGoggles"] call _AW_addWeapon;};
	case("AW_BLU_W_Pilot"):{["NVGoggles"] call _AW_addWeapon;};
	
	//--- RedFor
	
	//case("AW_RED_W_Engineer"):{["NVGoggles"] call _AW_addWeapon;};
	//case("AW_RED_W_Crew"):{["NVGoggles"] call _AW_addWeapon;};
	case("AW_RED_W_Pilot"):{["NVGoggles"] call _AW_addWeapon;};
	//--- has wrong nades
	case("AW_RED_W_GL"):{
		{
			if (_x == "1Rnd_HE_GP25") then {
				player removeMagazine "1Rnd_HE_GP25";
				player addMagazine "1Rnd_HE_M203";
			};
			if (_x == "1Rnd_SMOKE_GP25") then {
				player removeMagazine "1Rnd_SMOKE_GP25";
				player addMagazine "1Rnd_Smoke_M203";
			};
		}forEach magazines player;
	};
	default{};
};

//player sidechat format["%1",weapons player];