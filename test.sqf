if (isServer) then{
	//--- Both Crates
	{
		_x addMagazineCargoGlobal ["AW_M136",40];
		_x addMagazineCargoGlobal ["PipeBomb",10];
	}forEach[west_crate_1,west_crate_2,east_crate_1,east_crate_2];
	
	//--- BluFor Crate
	{
		_x addWeaponCargoGlobal ["LeeEnfield",10];
	}forEach[west_crate_1,west_crate_2];
	
	//--- RedFor Crate
	{
		_x addWeaponCargoGlobal ["LeeEnfield",10];
	}forEach[east_crate_1,east_crate_2];
};