private["_AW_Loop_VehicleNameFixScript"];

_AW_Loop_VehicleNameFixScript = {
	while{true} do{
		AW_west_ScoringTrucks = [west_supply_1,west_supply_2,west_supply_3];
		AW_east_ScoringTrucks = [east_supply_1,east_supply_2,east_supply_3];
		AW_all_ScoringTrucks = AW_west_ScoringTrucks + AW_east_ScoringTrucks;
		if (!isDedicated) then{
			switch (faction player)do{
				case ("AW_BLU"):{AW_friendlyCV = west_cv; AW_friendlySupplyTrucks = AW_west_ScoringTrucks;};
				case ("AW_RED"):{AW_friendlyCV = east_cv; AW_friendlySupplyTrucks = AW_east_ScoringTrucks;};
				default {};
			};
		};
		sleep 10;
	};
};
sleep 0.1;
//
diag_log text "|========== starting shared loop 1 (_AW_Loop_VehicleNameFixScript)";
[] spawn _AW_Loop_VehicleNameFixScript;