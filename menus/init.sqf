if(isMultiPlayer && isServer) exitWith{};
waitUntil {!isNull player };
waitUntil {player == player};

//--- loads referee menu if player is on resistance
if(playerSide == resistance)exitwith{
	[]execVM "menus\adminComsMenu.sqf";
};

//--- load training menu for players if trainign ode is enabled
if(AW_trainingEnabled_Param == 1)exitwith{
	[]execVM "menus\adminComsMenu.sqf";
};

//--- loads officer or soldier menu
if((str player) in AW_officers_Cfg)then{
	[]execVM "menus\officerComsMenu.sqf";
}else{
	[]execVM "menus\soldierComsMenu.sqf";
};
