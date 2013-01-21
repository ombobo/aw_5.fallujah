waitUntil { !isNull player };
waitUntil { player == player };

//----- TM

AW_Menu_AO = [
	["TM Tools",false],
	["Force Recalculation", [2], "", -5, [["expression", "AW_calcTerritoryNow = 1;publicVariableServer 'AW_calcTerritoryNow'"]], "1", "1"],
	["Force New AO", [3], "", -5, [["expression", "[]execVM 'aw5_score\client\initNewAO.sqf';"]], "1", "1"],
	["Turn active AO Blue", [7], "", -5, [["expression", "AW_bluTotalScore = 99999;publicVariableServer 'AW_bluTotalScore'"]], "1", "1"],
	["Turn active AO Red", [8], "", -5, [["expression", "AW_redTotalScore = 99999;publicVariableServer 'AW_redTotalScore'"]], "1", "1"],
	["End active AO", [9], "", -5, [["expression", "AW_AOScoreLimitTime = 1;publicVariableServer 'AW_AOScoreLimitTime'"]], "1", "1"]
];

AW_Menu_TM = [
	["TM Tools",false],
	["Server Status", [2], "", -5, [["expression", "[]execVM ""core\referee\serverStatus.sqf"";"]], "1", "1"],
	["Teleport", [3], "", -5, [["expression", "[]execVM ""core\referee\teleport.sqf""; taskhint([""Click Map To Teleport"",[1, 0, 0, 1], ""taskfailed""])"]], "1", "1"],
	["Camera.sqs", [4], "", -5, [["expression", "player exec ""camera.sqs"";"]], "1", "1"],
	["Weapon-Check", [5], "", -5, [["expression", "[]execVM 'core\security\checkWeapons.sqf';"]], "1", "1"],
	["AO Menu",[6],"#USER:AW_Menu_AO",-5,[["expression",""]],"1","1"]
];

//----- Markers
	
AW_Menu_Markers = [
	["TM Tools",false],
	//["Infantry Markers",[2],"#USER:AW_InfMarkerMenu",-5,[["expression",""]],"1","1"],
	["Select Infantry-group",[2],"#USER:AW_unitGroupMenu",-5,[["expression",""]],"1","1"],
	["Vehicle Marker-Menu",[3],"#USER:AW_VehicleMarkerMenu",-5,[["expression",""]],"1","1"]
];
	
AW_InfMarkerMenu = [
	["Inf Text",false],
	["No text", [2], "", -5, [["expression", "AW_markerMode = 0;"]], "1", "1"],
	["Health/Damage", [3], "", -5, [["expression", "AW_markerMode = 1;"]], "1", "1"],
	["Unit Name", [4], "", -5, [["expression", "AW_markerMode = 2;"]], "1", "1"],
	["Unit Type", [5], "", -5, [["expression", "AW_markerMode = 3;"]], "1", "1"],
	["Full Names", [6], "", -5, [["expression", "AW_InfNameLenght = 1;AW_UpdateInfName = true;"]], "1", "1"],
	["Short Names", [7], "", -5, [["expression", "AW_InfNameLenght = 2;AW_UpdateInfName = true;"]], "1", "1"],
	["Group Clusters", [8], "", -5, [["expression", "AW_markerMode = 4;"]], "1", "1"]
];
	
AW_VehicleMarkerMenu = [
	["Inf Text",false],
	["Normal", [2], "", -5, [["expression", "AW_VehMarkerOption = 2;"]], "1", "1"],
	["Health/Damage", [3], "", -5, [["expression", "AW_VehMarkerOption = 1;"]], "1", "1"],
	["No text", [4], "", -5, [["expression", "AW_VehMarkerOption = 0;"]], "1", "1"],
	["Show driver", [5], "", -5, [["expression", "AW_ShowDriver = 1;"]], "1", "1"],
	["Dont show driver", [6], "", -5, [["expression", "AW_ShowDriver = 0;"]], "1", "1"]
];
	
AW_unitGroupMenu = [
	["Marker Color",false],
	["Alpha", [2], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',0,true];"]], "1", "1"],
	["Bravo", [3], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',1,true];"]], "1", "1"],
	["Charlie", [4], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',2,true];"]], "1", "1"],
	["Delta", [5], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',3,true];"]], "1", "1"],
	["Echo", [6], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',4,true];"]], "1", "1"],
	["Foxtrot", [7], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',5,true];"]], "1", "1"],
	["Golf", [8], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',6,true];"]], "1", "1"],
	["Sierra", [9], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',7,true];"]], "1", "1"],
	["Zulu", [10], "", -5, [["expression", "(vehicle player) setVariable['AW_markerColor',8,true];"]], "1", "1"]
];
	
AW_MoveAOMenu_2 = [
	["TM Tools",false],
	["Move AO to Red Base",[2],"",-5,[["expression","fl_event_moveao = 'blu';PublicVariable 'fl_event_moveao'"]],"1","1"],
	["Move AO to Blu Base",[3],"",-5,[["expression","fl_event_moveao = 'red';PublicVariable 'fl_event_moveao'"]],"1","1"]
];
	
AW_MoveAOMenu_1 = [
	["Inf Text",false],
	["CONFIRM",[2],"#USER:AW_MoveAOMenu_2",-5,[["expression",""]],"1","1"]
];

AW_Menu_ManipAOs_Extra = [
	["Inf Text",false],
	["Dump Arrays to RPT",[2],"",-5,[["expression","[]execVM 'aw5_score\dev\dumpArrays.sqf'"]],"1","1"],
	["Cancel current action",[3],"",-5,[["expression","onMapSingleClick ''"]],"1","1"],
	["Calc Area Size",[4],"",-5,[["expression","[-1]execVM 'aw5_score\dev\calcAreaForAO.sqf'"]],"1","1"],
	["Set AO Neutral",[5],"",-5,[["expression","[-1]execVM 'aw5_score\dev\setAOControl.sqf'"]],"1","1"],
	["Reset Arrays (CAREFUL)",[9],"",-5,[["expression","[]execVM 'aw5_score\dev\resetarrays.sqf'"]],"1","1"]
];
	
AW_Menu_ManipAOs = [
	["Inf Text",false],
	["Update Corner",[2],"",-5,[["expression","[]execVM 'aw5_score\dev\updateCorner.sqf'"]],"1","1"],
	["Remove Corner",[3],"",-5,[["expression","[]execVM 'aw5_score\dev\removeCorner.sqf'"]],"1","1"],
	["Add AO",[4],"",-5,[["expression","[]execVM 'aw5_score\dev\addAO.sqf'"]],"1","1"],
	["Remove AO",[5],"",-5,[["expression","[]execVM 'aw5_score\dev\removeAO.sqf'"]],"1","1"],
	["Recreate Markers",[6],"",-5,[["expression","AW_EH_recreateCornersAndAOs = 1;publicVariableServer 'AW_EH_recreateCornersAndAOs';"]],"1","1"],
	["Set AO Blu",[7],"",-5,[["expression","[1]execVM 'aw5_score\dev\setAOControl.sqf'"]],"1","1"],
	["Set AO Red",[8],"",-5,[["expression","[0]execVM 'aw5_score\dev\setAOControl.sqf'"]],"1","1"],
	["Extra Options",[9],"#USER:AW_Menu_ManipAOs_Extra",-5,[["expression",""]],"1","1"]
];
//----- Settings
AW_Menu_Settings_VD = [
	["Inf Text",false],
	["3000",[2],"",-5,[["expression","setviewdistance 3000;"]],"1","1"],
	["2500",[3],"",-5,[["expression","setviewdistance 2500;"]],"1","1"],
	["2000",[4],"",-5,[["expression","setviewdistance 2000;"]],"1","1"]
];
	
AW_Menu_Settings = [
	["Settings",false],
	["Change viewdistance",[3],"#USER:AW_Menu_Settings_VD",-5,[["expression",""]],"1","1"]
];

//----- Officers
AW_Menu_Officers = [
	["Settings",false],
	["Select next AO", [2], "", -5, [["expression", "[]execVM 'aw5_score\client\chooseNewAO.sqf';"]], "1", "1"]
];
	
BIS_MENU_GroupCommunication = [
	["Tools", false],
	["TM Tools",[2],"#USER:AW_Menu_TM",-5,[["expression",""]],"1","1"],
	["Marker Options",[3],"#USER:AW_Menu_Markers",-5,[["expression",""]],"1","1"],
	["Unflip vehicle",[4],"",-5,[["expression","execVM 'core\fixes\unflipVehicle.sqf';"]],"1","1"],
	//["Move AO",[5],"#USER:AW_MoveAOMenu_1",-5,[["expression",""]],"1","1"],
	["Mission Settings",[5],"#USER:AW_Menu_Settings",-5,[["expression",""]],"1","1"],
	["Officer Tools",[8],"#USER:AW_Menu_Officers",-5,[["expression",""]],"1","1"],
	["Edit AOs (editor mode only)",[9],"#USER:AW_Menu_ManipAOs",-5,[["expression",""]],"1","1"]
	//["Enable Debug",[7],"",-5,[["expression","handle_debug = [1] spawn fl_Debug;"]],"1","1"],
	//["Disable Debug",[8],"",-5,[["expression","[0] spawn fl_Debug;"]],"1","1"],
	//["Score Board",[9],"",-5,[["expression","execVM 'score\scoreBoard\scoreBoard.sqf';"]],"1","1"]
];

//


