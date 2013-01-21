/*
* Fortification List'
* param 0: Display name (String)
*  param 1: Class name (String)
*  param 2: Preview Class name (String)
*  param 3: Cost (int)
*/

//AW fortification manager is building from 0=CV, 1=Truck, is -1 at init
AW_FM_BuildingFrom = -1;

AW_fortification_run = compile preprocessFileLineNumbers "fortification_manager\run.sqf";
AW_fortification_run_supply = compile preprocessFileLineNumbers "fortification_manager\run_supply.sqf";

//Displayname,ClassName,PreviewName,Costs
//leave PreviewName empty to use the normal class as local preview (works just fine, but wont look as professional)
AW_Fortification_List =[
	["Razor Wire","Fort_RazorWire","",1],
	["Bagfence Long","Land_fort_bagfence_long","Land_fort_bagfence_longPreview",1],
	["Bagfence Round","Land_fort_bagfence_round","Land_fort_bagfence_roundPreview",1],
	["Artillery Nest","Land_fort_artillery_nest","Land_fort_artillery_nestPreview",6],
	["Fort Rampart","Land_fort_rampart","Land_fort_rampartPreview",6],
	["Fortified Nest (small)","Land_fortified_nest_small","Land_fortified_nest_smallPreview",4],
	["Fortified Nest (big)","Land_fortified_nest_big_EP1","",15],
	["Bunker Tower","Land_Fort_Watchtower_EP1","",15],
	["HBarrier Large","Land_HBarrier_large","Land_HBarrier_largePreview",6],
	["HBarrier (1)","Land_HBarrier1","Land_HBarrier1Preview",1],
	["HBarrier (3)","Land_HBarrier3","Land_HBarrier3ePreview",3],
	["HBarrier (5)","Land_HBarrier5","Land_HBarrier5Preview",4],
	//["WF Barrier (5)","USMC_WarfareBBarrier5x","",4],
	//["WF Barrier (10)","USMC_WarfareBBarrier10x","Base_WarfareBBarrier10xPreview",8],
	["Concrete Wall","Concrete_Wall_EP1","",3],
	["Hedgehog","Hedgehog","",2],
	["Envelope Small","Fort_EnvelopeSmall","",1],
	["Envelope Big","Fort_EnvelopeBig","",1]	
];

AW_Utility_List =[
	["Searchlight","SearchLight_CDF","",2],
	["Field-Hospital","GUE_WarfareBFieldhHospital","",6],
	["MASH","MASH","",10],
	["Helipad (Military)","HeliH","",2],
	["Parachute Target","PARACHUTE_TARGET","",2],
	["Fire Barrel","Land_Fire_barrel","",2]
];

AW_Cover_List =[
	["Camo Net NATO (open)","Land_CamoNetVar_NATO","",1],
	["Camo Net NATO (half-open)","Land_CamoNet_NATO","",1],
	["Camo Net NATO (open desert)","Land_CamoNetVar_NATO_EP1","",1],
	["Camo Net EAST (open)","Land_CamoNetVar_EAST","",1],
	["Camo Net EAST (half-open)","Land_CamoNet_EAST","",1],
	["Camo Net EAST (open desert)","Land_CamoNetVar_EAST_EP1","",1]
];

AW_Defenses_List =[
	["M240 Nest","USMC_WarfareBMGNest_M240","",8],
	["M119","AW_M119","",15],
	["ZU23","AW_ZU23_CDF","",15]
];

AW_Defenses_List_Trucks =[
	["M240 Nest","USMC_WarfareBMGNest_M240","",8]
];

AW_Fortification_Names = ["Fortifications","Utility","Cover / Nets","Defenses"]; //displayed names for the groups below
AW_Fortification_Data = [AW_Fortification_List,AW_Utility_List,AW_Cover_List,AW_Defenses_List];
AW_Fortification_Data_Trucks = [AW_Fortification_List,AW_Utility_List,AW_Cover_List,AW_Defenses_List_Trucks];

AW_Selected_Fortification = ""; //defualt value
AW_Selected_Fortification_Cost = 5;
AW_Selected_SubCategory = [];

AW_distanceToBuild = 75; //max distance for fortifications from a base object
if (AW_trainingEnabled_Param == 1) then{
	AW_timeTillRefund = 1; //time in seconds till ressources are refunded
}else{
	AW_timeTillRefund = 600;
};


AW_Player_Constructing = false;

//these only hold the most recent new object
AW_NewFortificationsWest = [];
AW_NewFortificationsEast = [];
//go immediately to this
//these hold several new objects until they are merged into the main array and get resized to 0
AW_FortificationTempArrayWest = [];
AW_FortificationTempArrayEast = [];
//go to this in intervals
//main Fortification array
AW_FortificationArrayWest = [];
AW_FortificationArrayEast = [];

if (isnil ("AW_West_Ressources")) then {AW_West_Ressources = 25;};
if (isnil ("AW_West_RessourcesTrucks")) then {AW_West_RessourcesTrucks = 25;};

if (isnil ("AW_East_Ressources")) then {AW_East_Ressources = 25;};
if (isnil ("AW_East_RessourcesTrucks")) then {AW_East_RessourcesTrucks = 25;};

//arrays below not needed ?
AW_RefundArrayWest = [];
AW_RefundArrayEast = [];

if (isServer) then{
	"AW_NewFortificationWest" addPublicVariableEventHandler {
		AW_NewFortificationWest call AW_Fortification_To_Array;
		switch (AW_NewFortificationWest select 3)do{
			case (0):{
				AW_West_Ressources = AW_West_Ressources - (AW_NewFortificationWest select 2);
				publicVariable "AW_West_Ressources";
			};
			case (1):{
				AW_West_RessourcesTrucks = AW_West_RessourcesTrucks - (AW_NewFortificationWest select 2);
				publicVariable "AW_West_RessourcesTrucks";
			};
			default {};
		};
	};

	"AW_NewFortificationEast" addPublicVariableEventHandler {
		AW_NewFortificationEast call AW_Fortification_To_Array;
		switch (AW_NewFortificationEast select 3)do{
			case (0):{
				AW_East_Ressources = AW_East_Ressources - (AW_NewFortificationEast select 2);
				publicVariable "AW_East_Ressources";
			};
			case (1):{
				AW_East_RessourcesTrucks = AW_East_RessourcesTrucks - (AW_NewFortificationEast select 2);
				publicVariable "AW_East_RessourcesTrucks";
			};
			default {};
		};
	};
};

switch (faction player)do{
	case ("AW_BLU"):{CommandVehicle = west_CV};
	case ("AW_RED"):{CommandVehicle = east_CV};
	case ("AW_TM"):{CommandVehicle = ind_CV};
	default {CommandVehicle = ind_CV};
};
//functions
handle_fortification_functions = []execVM "fortification_manager\functions.sqf";

waitUntil{scriptDone handle_fortification_functions};
if (isServer) then {
	[] spawn AW_Check_Fortifications;
	//[] spawn AW_Refund_Ressources;
};