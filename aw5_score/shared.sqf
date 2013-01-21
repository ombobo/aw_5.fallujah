// handle: AW_handle_sharedInit

//private["_handle"];

_handle_ao_config = [] execVM "aw5_score\ao_config.sqf";
waitUntil{scriptDone _handle_ao_config};

_handle_createAOs = [] execVM "aw5_score\shared\createAOs.sqf";
waitUntil{scriptDone _handle_createAOs};

AW_script_initializeAO = compile preprocessFileLineNumbers "aw5_score\shared\createTerritoryMarkers.sqf";
AW_script_recalculateTerritory = compile preprocessFileLineNumbers "aw5_score\shared\recalculateTerritory.sqf";

//----- Set Territory bounding box alpha to 0
"marker_map" setmarkerAlphaLocal 0; //rename

//----- Initialize required variables and set them to default values if necessary
if (isNil "AW_activeAOArray") then {AW_activeAOArray = [AW_startAO_0,AW_startAO_1,AW_startAO_2];};
if (isNil "AW_territoryCount") then{AW_territoryCount = 9999;};
if (isNil "AW_sideToPickAO") then{AW_sideToPickAO = -1;};

diag_log "shared.sqf initAO starting";
AW_handle_initializeAO = [AW_activeAO] spawn AW_script_initializeAO;
waitUntil{scriptDone AW_handle_initializeAO};
diag_log "shared.sqf initAO done";


//---- Dont start calculating indpeendently! Let the server tell clients when to recalc.

//AW_handle_calculateTerritory = [] spawn AW_script_recalculateTerritory;
//waitUntil{scriptDone AW_handle_calculateTerritory};
