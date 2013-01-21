/*
* Created By Jones
* last updated 1/16/2012
*/
private["_cameraScript"];
waitUntil {!isNull player};
_cameraScript =[]execVm "core\functions\spawnCamera.sqf";
playmusic AW_introSong_Cfg;
player enableSimulation false;

sleep 30;//wait 30 second until text is displayed, this give the player enough time to get out of the black screen
[AW_introTitle_Cfg] spawn BIS_fnc_dynamicText;
[AW_introWave1Line1_cfg,AW_introWave1Line2_Cfg,AW_introWave1Line3_Cfg]call BIS_fnc_infoText;
[AW_introWave2Line1_Cfg,AW_introWave2Line2_Cfg,AW_introWave2Line3_Cfg] call BIS_fnc_infoText;

//sits idle until camera script is done
waitUntil {scriptDone _cameraScript};
[AW_introEndText_Cfg] spawn BIS_fnc_dynamicText;
player enableSimulation true;



