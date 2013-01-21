/////////////////////////////////////////////////////////////
// Config file
// used to configure the map objects in to the maps scripts
// and to change settings to map script behaviors
/////////////////////////////////////////////////////////////

//player weapons and magazines
AW_playerWeapons = weapons player;
AW_playerMagazines = magazines player;

///////////////////////////////////
// ---- INTRO CONFIGURATION ---- //
///////////////////////////////////

//list of ingame music can be found @ http://community.bistudio.com/wiki/Arma_2:_Music#top
//music track to be played
AW_introSong_Cfg =  "Track11_Large_Scale_Assault";
//large white text center screen
AW_introTitle_Cfg = "Arma Wargames";
//text wave one lower right side of the screen
AW_introWave1Line1_Cfg = "Campaign Five";
AW_introWave1Line2_Cfg = "Battle 1";
AW_introWave1Line3_Cfg = "Operation Magic 8";
//text wave 2
AW_introWave2Line1_Cfg = "Follow Orders";
AW_introWave2Line2_Cfg = "Stay with your unit";
AW_introWave2Line3_Cfg = "Follow the ROE";
//large text middle of screen when intro is done, cneter screen large white text
AW_introEndText_Cfg = "Charlie don't surf!";
//textwave during respawn 
AW_repawnTextLine1_Cfg = "You have been Killed!";
AW_repawnTextLine2_Cfg = "Report to your squad leader";
AW_repawnTextLine3_Cfg = "for further orders";

///////////////////////////
// ---- Army Config ---- //
///////////////////////////

//----- Number of units per side
AW_armySize_Cfg = 47;
/*
* Base markers (safe-zone)
* Each entry is  a markername that represents a protections area.
* These markers must be an elipse that are the same size on both axis
*/
AW_westBases_Cfg =["west_mainBaseMarker","west_FSA_Marker"]; 
AW_eastBases_Cfg =["east_mainBaseMarker","east_FSA_Marker"]; 
//list of weapons classes that can use the tangent and elevation hint
AW_TandEHint_Cfg =["AGS_TK_EP1","MK19_TriPod_US_EP1"];

///////////////////////////
// ---- Unit Groups ---- //
///////////////////////////

AW_westUnit1_Cfg = ["w_a1","w_a2","w_a3","w_a4","w_a5","w_a6","w_a7","w_a8","w_a9","w_a10","w_a11","w_a12","w_a13","w_a14","w_a15","w_a16","w_a17"];
AW_westUnit2_Cfg = ["w_b1","w_b2","w_b3","w_b4","w_b5","w_b6","w_b7","w_b8","w_b9","w_b10"];
AW_westUnit3_Cfg = ["w_c1","w_c2","w_c3","w_c4","w_c5","w_c6","w_c7","w_c8","w_c9","w_c10"];
AW_westUnit4_Cfg = ["w_d1","w_d2","w_d3","w_d4","w_d5","w_d6","w_d7","w_d8","w_d9","w_d10"];

AW_eastUnit1_Cfg = ["e_a1","e_a2","e_a3","e_a4","e_a5","e_a6","e_a7","e_a8","e_a9","e_a10","e_a11","e_a12","e_a13","e_a14","e_a15","e_a16","e_a17"];
AW_eastUnit2_Cfg = ["e_b1","e_b2","e_b3","e_b4","e_b5","e_b6","e_b7","e_b8","e_b9","e_b10"];
AW_eastUnit3_Cfg = ["e_c1","e_c2","e_c3","e_c4","e_c5","e_c6","e_c7","e_c8","e_c9","e_c10"];
AW_eastUnit4_Cfg = ["e_d1","e_d2","e_d3","e_d4","e_d5","e_d6","e_d7","e_d8","e_d9","e_d10"];

AW_allWest = AW_westUnit1_Cfg + AW_westUnit2_Cfg + AW_westUnit3_Cfg + AW_westUnit4_Cfg;
AW_allEast = AW_eastUnit1_Cfg + AW_eastUnit2_Cfg + AW_eastUnit3_Cfg + AW_eastUnit4_Cfg;

AW_allUnits_Cfg = AW_westUnit1_Cfg + AW_westUnit2_Cfg + AW_westUnit3_Cfg + AW_westUnit4_Cfg + AW_eastUnit1_Cfg + AW_eastUnit2_Cfg + AW_eastUnit3_Cfg + AW_eastUnit4_Cfg;

AW_refereeSlots_Cfg =["r1","r2","r3","r4","r5","r6"];

/////////////////////////////////
// ---- Class Permissions ---- //
/////////////////////////////////

AW_officers_Cfg = ["w_a1","w_a2","w_b1","w_c1","w_d1","e_a1","e_a2","e_b1","e_c1","e_d1"];
AW_pilots_Cfg = ["w_a3","w_a4","w_a5","e_a3","e_a4","e_a6"];
AW_engineers_Cfg = ["w_a7","w_a8","w_a9","e_a7","e_a8","e_a9"];
AW_medics_Cfg = ["w_b2","w_c2","w_d2","e_b2","e_c2","e_d2"];
AW_crewmen_Cfg = ["w_a10","w_a11","w_a12","w_a13","e_a10","e_a11","e_a12","e_a13"];

AW_builders_Cfg = AW_officers_Cfg + AW_engineers_Cfg + ["w_b6","w_c6","w_d6","e_b6","e_c6","e_d6"] + AW_refereeSlots_Cfg;

//marker types
// b_armor, b_air, b_maint, b_mech_inf, b_motor_inf,b_empty,b_med
//n_armor, n_air, n_maint, n_mech_inf, n_motor_inf,n_empty,n_med
//o_armor, o_air, o_maint, o_mech_inf, o_motor_inf,o_empty,o_med,o_mech_inf
/*
 Each entry in the vehilce array is an array of 5 parameters
 parameter 0.	String -Vehicle name as named in editor
 parameter 1.	Interger - respawn time
 parameter 2.	String- marker type for the vehicle's map marker
 parameter 3.	Side the vehicle belongs to(config override)
 parameter 4.	Integer, the value of the vehicle to be added to the global cost when destroyed
 parameter 5.	Crew enforcement. 0=disabled, 1= pilots slot required. 2 =crewman slot required
 parameter 6.	Short name string for optional map markers
*/

//needed ?
AW_westVehicleArray_Cfg = [];
AW_eastVehicleArray_Cfg = [];

AW_westVehicleArray_Cfg =[
	["west_air_1",180,"b_air",west,0.5,1,"UH60_A"],
	["west_air_2",180,"b_air",west,0.5,1,"UH60_B"],
	["west_apc_1",180,"b_armor",west,0.5,0,"LAV"],
	["west_ifv_1",180,"b_armor",west,0.5,0,"M2A2"],
	["west_cv",60,"b_hq",west,0,0,"HQ"],
	["west_sov",180,"b_motor_inf",west,0,0,"SOV"],
	["west_ammo",30,"b_maint",west,0,0,"Ammo"],
	["west_fuel",30,"b_maint",west,0,0,"Fuel"],
	["west_repair",30,"b_maint",west,0,0,"Repair"], 
	["west_supply_1",30,"b_med",west,0,0,"Supply"],
	["west_supply_2",30,"b_med",west,0,0,"Supply"],
	["west_supply_3",30,"b_med",west,0,0,"Supply"],
	["west_offroad_1",180,"b_motor_inf",west,0,0,"Offroad"],
	["west_offroad_2",180,"b_motor_inf",west,0,0,"Offroad"]
];
AW_eastVehicleArray_Cfg =[
	["east_air_1",180,"o_air",east,0.5,1,"Mi17_A"],
	["east_air_2",180,"o_air",east,0.5,1,"Mi17_B"],
	["east_apc_1",180,"o_armor",east,0.5,0,"BTR"],
	["east_ifv_1",180,"o_armor",east,0.5,0,"BMP2"],
	["east_cv",60,"o_hq",east,0,0,"HQ"],
	["east_sov",180,"o_motor_inf",east,0,0,"SOV"],
	["east_ammo",30,"o_maint",east,0,0,"Ammo"],
	["east_fuel",30,"o_maint",east,0,0,"Fuel"],
	["east_repair",30,"o_maint",east,0,0,"Repair"], 
	["east_supply_1",30,"o_med",east,0,0,"Supply"],
	["east_supply_2",30,"o_med",east,0,0,"Supply"],
	["east_supply_3",30,"o_med",east,0,0,"Supply"],
	["east_offroad_1",180,"o_motor_inf",east,0,0,"Offroad"],
	["east_offroad_2",180,"o_motor_inf",east,0,0,"Offroad"]
];

//----- Command Vehicles & Scoring/Supply Trucks
AW_west_CommandVehicle_cfg = "west_cv";
AW_east_CommandVehicle_cfg = "east_cv";

AW_west_ScoringTrucks = [west_supply_1,west_supply_2,west_supply_3];
AW_east_ScoringTrucks = [east_supply_1,east_supply_2,east_supply_3];
AW_all_ScoringTrucks = AW_west_ScoringTrucks + AW_east_ScoringTrucks;

//AW_bluScoringAssets = ["west_cv","west_supply_1","west_supply_2","west_supply_3"];
//AW_redScoringAssets = ["east_cv","east_supply_1","east_supply_2","east_supply_3"];

//----- Determine friendly CV. Should be used as a string in the future and then call-compiled on demand so the friendlyCV doesnt need to be updated all the time.
switch (faction player)do{
	case ("AW_BLU"):{AW_friendlyCV = west_cv; AW_friendlySupplyTrucks = AW_west_ScoringTrucks;};
	case ("AW_RED"):{AW_friendlyCV = east_cv; AW_friendlySupplyTrucks = AW_east_ScoringTrucks;};
	default {};
};

//----- Service vehicles (not used atm?)
AW_service_vehicles = [
	"AW_BLU_MtvrReammo",
	"AW_BLU_MtvrRefuel",
	"AW_BLU_MtvrRepair",
	"AW_RED_KamazRepair",
	"AW_RED_KamazReammo",
	"AW_RED_KamazRefuel"
];

//----- Ammo that can trigger unconciousnes (WIP - unused atm)
AW_uncon_ammo = [
	"GrenadeHandTimedWest",
	"PipeBomb",
	"G_30mm_HE",
	"AW_R_M136_AT"
];

