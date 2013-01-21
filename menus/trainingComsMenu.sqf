waitUntil{!isNull player};
waitUntil{player == player};

AW_menu1 = [
	["TM Tools",false],
	["Server Status", [2], "", -5, [["expression", "[]execVM ""core\referee\serverStatus.sqf"";"]], "1", "1"],
	["Teleport", [3], "", -5, [["expression", "[]execVM ""core\referee\teleport.sqf""; taskhint([""Click Map To Teleport"",[1, 0, 0, 1], ""taskfailed""])"]], "1", "1"],
	["Camera.sqs", [4], "", -5, [["expression", "player exec ""camera.sqs"";"]], "1", "1"]
	];
	
AW_MarkerMenu = [
	["TM Tools",false],
	["Infantry Markers",[2],"#USER:AW_InfMarkerMenu",-5,[["expression",""]],"1","1"],
	["Vehicle Markers",[3],"#USER:AW_VehicleMarkerMenu",-5,[["expression",""]],"1","1"],
	["Select own markercolor",[4],"#USER:AW_MarkerColorMenu",-5,[["expression",""]],"1","1"]
	];
	
AW_InfMarkerMenu = [
	["Inf Text",false],
	["No text", [2], "", -5, [["expression", "AW_markerMode = 0;"]], "1", "1"],
	["Health/Damage", [3], "", -5, [["expression", "AW_markerMode = 1;"]], "1", "1"],
	["Unit Name", [4], "", -5, [["expression", "AW_markerMode = 2;"]], "1", "1"],
	["Unit Type", [5], "", -5, [["expression", "AW_markerMode = 3;"]], "1", "1"],
	["Full Names", [6], "", -5, [["expression", "AW_InfNameLenght = 1;AW_UpdateInfName = true;"]], "1", "1"],
	["Short Names", [7], "", -5, [["expression", "AW_InfNameLenght = 2;AW_UpdateInfName = true;"]], "1", "1"]
	];
	
AW_VehicleMarkerMenu = [
	["Inf Text",false],
	["No text", [2], "", -5, [["expression", "AW_VehMarkerOption = 0;"]], "1", "1"],
	["Health/Damage", [3], "", -5, [["expression", "AW_VehMarkerOption = 1;"]], "1", "1"],
	["Normal", [4], "", -5, [["expression", "AW_VehMarkerOption = 2;"]], "1", "1"],
	["Show driver", [9], "", -5, [["expression", "AW_ShowDriver = 1;"]], "1", "1"],
	["Dont show driver", [10], "", -5, [["expression", "AW_ShowDriver = 0;"]], "1", "1"]
	];
	
AW_MarkerColorMenu = [
	["Marker Color",false],
	["Black", [2], "", -5, [["expression", "AW_playerMarkerColor = 1; (vehicle player) setVariable['AW_markerColor',1,true];"]], "1", "1"],
	["Blue", [3], "", -5, [["expression", "AW_playerMarkerColor = 2; (vehicle player) setVariable['AW_markerColor',2,true];"]], "1", "1"],
	["Green", [4], "", -5, [["expression", "AW_playerMarkerColor = 3; (vehicle player) setVariable['AW_markerColor',3,true];"]], "1", "1"],
	["Orange", [5], "", -5, [["expression", "AW_playerMarkerColor = 4; (vehicle player) setVariable['AW_markerColor',4,true];"]], "1", "1"],
	["Brown", [6], "", -5, [["expression", "AW_playerMarkerColor = 5; (vehicle player) setVariable['AW_markerColor',5,true];"]], "1", "1"]
	];
	
AW_MoveAOMenu = [
	["TM Tools",false],
	["Move AO to Red Base",[8],"",-5,[["expression","fl_event_moveao = 'blu';PublicVariable 'fl_event_moveao'"]],"1","1"],
	["Move AO to Blu Base",[9],"",-5,[["expression","fl_event_moveao = 'red';PublicVariable 'fl_event_moveao'"]],"1","1"]
	];
	
BIS_MENU_GroupCommunication = [
	["Tools", false],
	["TM Tools",[2],"#USER:AW_menu1",-5,[["expression",""]],"1","1"],
	["Marker Options",[3],"#USER:AW_MarkerMenu",-5,[["expression",""]],"1","1"],
	["Artillery",[4],"",-5,[["expression","execVM 'artillery\UI\openArtyUI.sqf';"]],"1","1"],
	["Unflip vehicle",[5],"",-5,[["expression","execVM 'core\fixes\unflipVehicle.sqf';"]],"1","1"],
	["Move AO",[6],"#USER:AW_MoveAOMenu",-5,[["expression",""]],"1","1"],
	["Enable Debug",[7],"",-5,[["expression","handle_debug = [1] spawn fl_Debug;fl_DebugValue = 1;"]],"1","1"],
	["Disable Debug",[8],"",-5,[["expression","[0] spawn fl_Debug;fl_DebugValue = 0;"]],"1","1"]
	];
	
	