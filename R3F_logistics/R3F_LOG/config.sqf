/**
 * English and French comments
 * Commentaires anglais et fran�ais
 * 
 * This file contains the configuration variables of the logistics system.
 * Fichier contenant les variables de configuration du syst�me de logistique.
 * 
 * Important note : All the classes names which inherits from the ones used in configuration variables will be also available.
 * Note importante : Tous les noms de classes d�rivant de celles utilis�es dans les variables de configuration seront aussi valables.
 *
 * Usefull links / Liens utiles :
 * - http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles
 * - http://www.armatechsquad.com/ArmA2Class/
 */

/*
 * There are two ways to manage new objects with the logistics system. The first is to add these objects in the
 * folowing appropriate lists. The second is to create a new external file in the /addons_config/ directory,
 * according to the same scheme as the existing ones, and to add a #include at the end of this current file.
 * 
 * Deux moyens existent pour g�rer de nouveaux objets avec le syst�me logistique. Le premier consiste � ajouter
 * ces objets dans les listes appropri�es ci-dessous. Le deuxi�me est de cr�er un fichier externe dans le r�pertoire
 * /addons_config/ selon le m�me sch�ma que ceux qui existent d�j�, et d'ajouter un #include � la fin de ce pr�sent fichier.
 */

/****** TOW WITH VEHICLE / REMORQUER AVEC VEHICULE ******/

/**
 * List of class names of (ground or air) vehicles which can tow towables objects.
 * Liste des noms de classes des v�hicules terrestres pouvant remorquer des objets remorquables.
 */
R3F_LOG_CFG_remorqueurs =
[
	// e.g. : "MyTowingVehicleClassName1", "MyTowingVehicleClassName2"
	/*"Wheeled_APC",
	"HMMWV_Base",
	"TowingTractor",
	"tractor",
	"Kamaz_Base",
	"MTVR",
	"GRAD_Base",
	"Ural_Base",
	"Ural_ZU23_Base",
	"V3S_Civ",
	"UAZ_Base",
	"BRDM2_Base",
	"BTR90_Base",
	"GAZ_Vodnik_HMG",
	"LAV25_Base",
	"MLRS"*/
];

/**
 * List of class names of towables objects.
 * Liste des noms de classes des objets remorquables.
 */
R3F_LOG_CFG_objets_remorquables =
[
	// e.g. : "MyTowableObjectClassName1", "MyTowableObjectClassName2"
	//"Car",
	"StaticCannon",
	"RubberBoat"
];


/****** LIFT WITH VEHICLE / HELIPORTER AVEC VEHICULE ******/

/**
 * List of class names of air vehicles which can lift liftables objects.
 * Liste des noms de classes des v�hicules a�riens pouvant h�liporter des objets h�liportables.
 */
R3F_LOG_CFG_heliporteurs =
[
	// e.g. : "MyLifterVehicleClassName1", "MyLifterVehicleClassName2"
	/*"BAF_Merlin_HC3_D",
	"CH_47F_EP1"*/
];

/**
 * List of class names of liftables objects.
 * Liste des noms de classes des objets h�liportables.
 */
R3F_LOG_CFG_objets_heliportables =
[
	// e.g. : "MyLiftableObjectClassName1", "MyLiftableObjectClassName2"
	/*
	"BAF_Jackal2_BASE_D",
	"StaticCannon",
	"Car",
	"Ship",
	"ReammoBox",
	
	"Land_Misc_Cargo1Ao",
	"Land_Misc_Cargo1B",
	"Land_Misc_Cargo1Bo",
	"Land_Misc_Cargo1C",
	"Land_Misc_Cargo1D",
	"Land_Misc_Cargo1E",
	"Land_Misc_Cargo1F",
	"Land_Misc_Cargo1G",
	"Base_WarfareBContructionSite",
	"Misc_cargo_cont_net1",
	"Misc_cargo_cont_net2",
	"Misc_cargo_cont_net3",
	"Misc_cargo_cont_small",
	"Misc_cargo_cont_small2",
	"Misc_cargo_cont_tiny",
	"Land_Misc_Cargo1E_EP1"
	*/
];


/****** LOAD IN VEHICLE / CHARGER DANS LE VEHICULE ******/

/*
 * This section use a quantification of the volume and/or weight of the objets.
 * The arbitrary referencial used is : an ammo box of type USVehicleBox "weights" 12 units.
 * Note : the priority of a declaration of capacity to another corresponds to their order in the tables.
 *   For example : the "Truck" class is in the "Car" class (see http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles).
 *   If "Truck" is declared with a capacity of 140 before "Car". And if "Car" is declared after "Truck" with a capacity of 40,
 *   Then all the sub-classes in "Truck" will have a capacity of 140. And all the sub-classes of "Car", excepted the ones
 *   in "Truck", will have a capacity of 40.
 */

/**
 * List of class names of (ground or air) vehicles which can transport transportables objects.
 * The second element of the arrays is the load capacity (in relation with the capacity cost of the objects).
 */
R3F_LOG_CFG_transporteurs =
[
	// e.g. : ["MyTransporterClassName1", itsCapacity], ["MyTransporterClassName2", itsCapacity]
	/*["BAF_Jackal2_BASE_D", 15],
	["CH_47F_EP1", 50],
	["ATV_US_EP1", 10],
	["hilux1_civil_1_open", 10],
	["HMMWV_Base", 12],
	["Ikarus", 40],
	["Lada_base", 6],
	["SkodaBase", 6],
	["TowingTractor", 5],
	["tractor", 2],
	["Motorcycle", 1],
	["KamazRefuel", 5],
	["Kamaz_Base", 40],
	["MtvrRefuel", 5],
	["MTVR", 40],
	["GRAD_Base", 2],
	["Ural_Base", 40],
	["ACE_Truck5tMG", 40],
	["V3S_Civ", 25],
	["UAZ_Base", 10],
	["VWGolf", 6],
	["BRDM2_Base", 25],
	["BTR90_Base", 25],
	["GAZ_Vodnik_HMG", 25],
	["LAV25_Base", 25],
	["AAV", 10],
	["BMP2_Base", 8],
	["BMP3", 8],	
	["Mi17_base", 50],
	["Mi24_Base", 40],
	["UH1Y", 15],
	["UH60_Base", 25],
	["C130J", 150],
	["MV22", 90],	
	["RHIB", 12],
	["RubberBoat", 5],
	["Fishing_Boat", 18],
	["Smallboat_1", 6],	
	["Land_Misc_Cargo1E_EP1", 100],
	["Land_Misc_Cargo1Ao", 100],
	["Land_Misc_Cargo1B", 100],
	["Land_Misc_Cargo1Bo", 100],
	["Land_Misc_Cargo1C", 100],
	["Land_Misc_Cargo1D", 100],
	["Land_Misc_Cargo1E", 100],
	["Land_Misc_Cargo1F", 100],
	["Land_Misc_Cargo1G", 100],
	["Base_WarfareBContructionSite", 50],
	["Misc_cargo_cont_net1", 9],
	["Misc_cargo_cont_net2", 18],
	["Misc_cargo_cont_net3", 30],
	["Misc_cargo_cont_small", 20],
	["Misc_cargo_cont_small2", 16],
	["Misc_cargo_cont_tiny", 12]
	*/
];

/**
 * List of class names of transportables objects.
 * The second element of the arrays is the cost capacity (in relation with the capacity of the vehicles).
 */
R3F_LOG_CFG_objets_transportables =
[
	// e.g. : ["MyTransportableObjectClassName1", itsCost], ["MyTransportableObjectClassName2", itsCost]
/*
	["Land_Pneu", 2],
	["Land_fort_bagfence_corner", 3],
	["Land_fort_bagfence_round", 3],
	["Fort_RazorWire", 3],
	["Hedgehog_EP1", 3],
	["Land_fortified_nest_small_EP1", 6],
	["Land_fort_artillery_nest_EP1", 12],
	["Land_fortified_nest_big_EP1", 12],
	//["MASH_EP1", 5],
	["Land_CamoNet_NATO_EP1", 4],
	["Land_CamoNetB_NATO_EP1", 5],
	["Land_CamoNetVar_NATO_EP1", 3],
	["ATV_US_EP1", 25],
	["SatPhone", 20], 
	["StaticAAWeapon", 7],
	["StaticATWeapon", 5],
	["StaticGrenadeLauncher", 3],
	["StaticMGWeapon", 3],
	["StaticMortar", 3],
	["StaticSEARCHLight", 2],
	["KORD_Base", 5],
	["M2StaticMG_base", 5],
	["Motorcycle", 5],
	["Truck", 140],
	["Car", 100],	
	["RubberBoat", 22],	
	["FlagCarrierSmall", 0.1],	
	["RoadBarrier_light", 1],
	["Hedgehog", 1],
	["Land_fortified_nest_small", 5],
	["Land_fortified_nest_big", 10],
	["Land_Fort_Watchtower", 15],
	["Fort_Barracks_USMC", 15],
	["Land_fort_rampart", 10],
	["Land_fort_artillery_nest", 15],
	["Land_fort_bagfence_round", 2],
	["Fort_Barricade", 55],
	["Land_CamoNet_NATO", 4],
	["Land_fort_bagfence_corner", 2],
	["Fort_RazorWire", 1],	
	["Land_HBarrier1", 1],
	["Land_HBarrier3", 3],
	["Land_HBarrier5", 5],
	["Land_HBarrier_large", 5],
	["Base_WarfareBBarrier5x", 5],
	["Land_Misc_deerstand", 10],	
	["Land_Misc_Cargo1Ao", 55],
	["Land_Misc_Cargo1B", 55],
	["Land_Misc_Cargo1Bo", 55],
	["Land_Misc_Cargo1C", 55],
	["Land_Misc_Cargo1D", 55],
	["Land_Misc_Cargo1E", 55],
	["Land_Misc_Cargo1F", 55],
	["Land_Misc_Cargo1G", 55],
	["Base_WarfareBContructionSite", 55],
	["Misc_cargo_cont_net1", 13],
	["Misc_cargo_cont_net2", 23],
	["Misc_cargo_cont_net3", 35],
	["Misc_cargo_cont_small", 25],
	["Misc_cargo_cont_small2", 20],
	["Misc_cargo_cont_tiny", 15],	
	["ACamp", 1.5],
	["Camp", 8],
	["CampEast", 8],
	["MASH", 8],
	["SpecialWeaponsBox", 3],
	["GuerillaCacheBox", 2],
	["LocalBasicWeaponsBox", 4],
	["LocalBasicAmmunitionBox", 2],
	["RULaunchersBox", 3],
	["RUOrdnanceBox", 3],
	["RUBasicWeaponsBox", 5],
	["RUSpecialWeaponsBox", 6],
	["RUVehicleBox", 16],
	["RUBasicAmmunitionBox", 2],
	["USLaunchersBox", 3],
	["USOrdnanceBox", 3],
	["USBasicWeaponsBox", 5],
	["USSpecialWeaponsBox", 6],
	["USVehicleBox", 16],
	["USBasicAmmunitionBox", 2],	
	["TargetE", 1],
	["TargetEpopUp", 1],
	["TargetPopUpTarget", 1],	
	["FoldChair", 0.5],
	["FoldTable", 0.5],
	["Barrels", 6],
	["Wooden_barrels", 6],
	["BarrelBase", 2],
	["Fuel_can", 1],
	["Notice_board", 0.5],
	["Pallets_comlumn", 2],
	["Unwrapped_sleeping_bag", 2],
	["Wheel_barrow", 2],
	["RoadCone", 0.2],
	["Sign_1L_Border", 0.2],
	["Sign_Danger", 0.2],
	["Suitcase", 0.2],
	["SmallTable", 0.2]
	["Sign_Checkpoint_US_EP1", 1],
	["Land_fort_rampart_EP1", 10],
	["Land_Fort_Watchtower_EP1", 20],
	["Land_fortified_nest_small_EP1", 5],
	["Land_fortified_nest_big_EP1", 10],
	["Sign_Checkpoint_US_EP1", 1],
	["Sign_Checkpoint_US_EP1", 1],
	["USBasicWeapons_EP1", 5],
	["USBasicAmmunitionBox_EP1", 5],
	["USLaunchers_EP1", 5],
	["USOrdnanceBox_EP1", 5],
	["USVehicleBox_EP1", 10],
	["USSpecialWeapons_EP1", 10]	
*/
];

/****** MOVABLE-BY-PLAYER OBJECTS / OBJETS DEPLACABLES PAR LE JOUEUR ******/

/**
 * List of class names of objects moveables by player.
 * Liste des noms de classes des objets transportables par le joueur.
 */
R3F_LOG_CFG_objets_deplacables =
[
	// e.g. : "MyMovableObjectClassName1", "MyMovableObjectClassName2"
	/*
	"Land_Pneu",
	"SatPhone", 
	"StaticWeapon",
	"RubberBoat",
	"FlagCarrierSmall",
	"Land_BagFenceCorner",
	"RoadBarrier_light",
	"Hedgehog",
	"Land_fortified_nest_small",
	"Land_fortified_nest_big",
	"Land_Fort_Watchtower",
	"Fort_Barracks_USMC",
	"Land_fort_rampart",
	"Land_fort_artillery_nest",	
	"Land_fort_bagfence_corner",
	"Land_fort_bagfence_round",
	"Fort_Barricade",
	"Land_CamoNet_NATO",
	"Fort_RazorWire",
	"Hedgehog_EP1",
	"Camp_base",
	"ReammoBox",	
	"TargetE",
	"TargetEpopUp",
	"TargetPopUpTarget",	
	//"ACRE_OE_303",
	//"Land_Misc_deerstand",	
	"FoldChair",
	"FoldTable",
	"BarrelBase",
	"Fuel_can",
	"Notice_board",
	"Pallets_comlumn",
	"Unwrapped_sleeping_bag",
	"Wheel_barrow",
	"RoadCone",
	"Sign_1L_Border",
	"Sign_Danger",
	"Suitcase",
	"SmallTable",
	"Land_HBarrier1",
	"Land_HBarrier3",
	"Land_HBarrier5",
	"Base_WarfareBBarrier5x",
	"Land_HBarrier_large",
	//"MASH",	
	"Sign_Checkpoint_US_EP1",
	"Land_fort_rampart_EP1",
	"Land_Fort_Watchtower_EP1",
	"Land_fortified_nest_small_EP1",
	"Land_fort_artillery_nest_EP1",
	"Land_fortified_nest_big_EP1",
	///"MASH_EP1",
	"Land_CamoNet_NATO_EP1",
	"Land_CamoNetB_NATO_EP1",
	"Land_CamoNetVar_NATO_EP1",
	"Sign_Checkpoint_US_EP1",
	"Sign_Checkpoint_US_EP1",
	"USBasicWeapons_EP1",
	"USBasicAmmunitionBox_EP1",
	"USLaunchers_EP1",
	"USOrdnanceBox_EP1",
	"USVehicleBox_EP1",
	"USSpecialWeapons_EP1"
*/
];

/*
 * List of files adding objects in the arrays of logistics configuration (e.g. R3F_LOG_CFG_remorqueurs)
 * Add an include to the new file here if you want to use the logistics with a new addon.
 */
#include "addons_config\AW_objects.sqf"