/*
* Created By Jones
* last updated 1/16/2012
*/

1 fadeSound 1;

//player setPos getMarkerPos AW_PlayerSpawnPoint;
AW_casualtyFlag = side player;
publicVariable "AW_casualtyFlag";
[]execVM "core\functions\spawnCamera.sqf"; 

if(side player == side AW_playerKiller)then{
	AW_deathMessage_Cfg = format["Killed by friendly fire: %1",(name AW_playerKiller)];
}else{
	AW_deathMessage_Cfg = "Better Luck Next Time.";
};

titleText[AW_deathMessage_Cfg,"BLACK IN", 7]; 
[AW_repawnTextLine1_Cfg,AW_repawnTextLine2_Cfg,AW_repawnTextLine3_Cfg]call BIS_fnc_infoText;
removeAllWeapons player;
{player addMagazine _x;} forEach AW_playerMagazines;
{player addWeapon _x;} forEach AW_playerWeapons;
player selectWeapon (primaryWeapon player);

player setVariable ["selections", [],false];
player setVariable ["gethit", [], false];