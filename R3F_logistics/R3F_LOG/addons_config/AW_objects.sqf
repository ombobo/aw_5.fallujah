
/****** TOW WITH VEHICLE ******/

/**
 * List of class names of vehicles which can tow towable objects.
 */
R3F_LOG_CFG_remorqueurs = R3F_LOG_CFG_remorqueurs +
[

];

/**
 * List of class names of towables objects.
 */
R3F_LOG_CFG_objets_remorquables = R3F_LOG_CFG_objets_remorquables +
[

];


/****** LIFT WITH VEHICLE******/

/**
 * List of class names of air vehicles which can lift liftable objects.
 */
R3F_LOG_CFG_heliporteurs = R3F_LOG_CFG_heliporteurs +
[
	"AW_BLU_MH60S",
	"AW_RED_Mi17_CDF"

];

/**
 * List of class names of liftable objects.
 */
R3F_LOG_CFG_objets_heliportables = R3F_LOG_CFG_objets_heliportables +
[
	"AW_BLU_M113_MG",
	"AW_RED_M113_MG",
	"AW_BLU_HMMWV_M998A2_SOV_DES_EP1",
	"AW_RED_LandRover_Special_CZ_EP1",
	"AW_RED_Zodiac",
	"AW_BLU_Zodiac",
	"AW_BLU_RHIB2Turret",
	"AW_RED_RHIB2Turret",
	"AW_BLU_MtvrRepair",
	"AW_BLU_MtvrRefuel",
	"AW_BLU_MtvrReammo",
	"AW_BLU_MTVR",
	"AW_RED_KamazRefuel",
	"AW_RED_KamazReammo",
	"AW_RED_KamazRepair",
	"AW_RED_Kamaz",
	"GAZ_Vodnik_HMG",
	"AW_BLU_LandRover_CZ_EP1",
	"AW_RED_LandRover_CZ_EP1",
	"AW_BLU_LAV25",
	"AW_CV_BLU_LAV25",
	"AW_RED_BTR90",
	"AW_RED_CV_BTR90"
];


/****** LOAD IN VEHICLE  ******/

/*
 * This section use a quantification of the volume and/or weight of the objets.
 * The arbitrary referencial used is : an ammo box of type USSpecialWeaponsBox "weights" 5 units.
 * 
 * 
 * Note : the priority of a declaration of capacity to another corresponds to their order in the tables.
 *   For example : the "Truck" class is in the "Car" class (see http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   If "Truck" is declared with a capacity of 140 before "Car". And if "Car" is declared after "Truck" with a capacity of 40,
 *   Then all the sub-classes in "Truck" will have a capacity of 140. And all the sub-classes of "Car", excepted the ones
 *   in "Truck", will have a capacity of 40.
 */
/**
 * List of class names of (ground or air) vehicles which can transport transportable objects.
 * The second element of the arrays is the load capacity (in relation with the capacity cost of the objects).
 */
R3F_LOG_CFG_transporteurs = R3F_LOG_CFG_transporteurs +[
	
        ["AW_BLU_Kamaz",25],
        ["AW_RED_Kamaz",25],
        ["AW_BLU_MTVR", 25],
        ["AW_RED_MTVR", 25]
];
/**
 * List of class names of transportable objects.
 * The second element of the arrays is the cost capacity (in relation with the capacity of the vehicles).
 */
R3F_LOG_CFG_objets_transportables = R3F_LOG_CFG_objets_transportables + [
	["AW_Blu_Stinger_Pod", 5],
	["AW_Red_Stinger_Pod", 5],
	["AGS_TK_EP1", 5],
	["MK19_TriPod_US_EP1", 5],
	["M2HD_mini_TriPod_US_EP1", 5],
	["M2StaticMG_US_EP1", 5],
	["KORD_high_TK_EP1", 5],
	["KORD_TK_EP1", 5],
	["SPG9_TK_GUE_EP1", 5],
	["SPG9_TK_INS_EP1", 5],	
	["SearchLight_TK_EP1", 5],
	["Searchlight", 5],	
	["Land_fortified_nest_small", 5],
	["Land_fort_bagfence_round", 5]
];
/****** MOVABLE-BY-PLAYER OBJECTS******/
/**
 * List of class names of objects moveable by player.
 */
R3F_LOG_CFG_objets_deplacables = R3F_LOG_CFG_objets_deplacables + [
	"AW_Blu_Stinger_Pod",
	"AW_Red_Stinger_Pod",
	"Land_fortified_nest_small",
	"Land_fort_bagfence_round",
	"AGS_TK_EP1",
	"MK19_TriPod_US_EP1",
	"M2HD_mini_TriPod_US_EP1",
	"M2StaticMG_US_EP1",
	"KORD_TK_EP1",
	"KORD_high_TK_EP1",
	"SPG9_TK_GUE_EP1",
	"SPG9_TK_INS_EP1",
	"SearchLight_TK_EP1",
	"Searchlight"
];