diag_log text "";
diag_log text "|==========================================================|";
diag_log text format ["Mission: %1",missionName];
diag_log text "";
diag_log text format ["Date & Time: %1",missionStart];
diag_log text format ["Client-Build: %1",productVersion select 3];
diag_log text "|==========================================================|";
diag_log text "";

private["_settingsScript","_configScript"];
//load settings, configs and functions before any other scripts

if (!isDedicated) then{
	waitUntil {!isNull player};
	waitUntil {player == player};
};

// no sleep before the settings.sqf!!!, otherwise the time and date wont be set correctly for clients at the start

_settingsScript = []execVM "settings.sqf";
waitUntil {scriptDone _settingsScript};
sleep 0.02;
_configScript = []execVM "config.sqf";
waitUntil {scriptDone _configScript};

////////////////////////////////////////////////////////////////////////////////
// LOAD INDIVIDUAL MODULE BELOW THIS LINE
////////////////////////////////////////////////////////////////////////////////
sleep 0.02;

[]execVM "core\init.sqf";

[]execVM "menus\init.sqf";

[]execVM "artillery\init.sqf";
[]execVM "R3F_logistics\init.sqf";
[]execVM "C2C\init.sqf";

[]execVM "general_eventhandlers\init.sqf";
[]execVM "general_loop_scripts\init.sqf";

[]execVM "aw5_score\init.sqf";  //score system

//other modules
[]execVM "damhandler\damhandler.sqf";
[]execVM "fortification_manager\init.sqf";

if (isServer && !isDedicated) then{
	[]execVM "module_dndhandler\init.sqf";
};

//test script, shouldnt be here
if (isServer && !isDedicated) then{
	{
		_unit = call compile _x;
		_unit setCaptive true;
	}forEach AW_allWest + AW_allEast;
};

if (isServer) then{
	[] execVM "test.sqf"; //temp fix to add equipment to ammocrates
};

//sleep 5;
//[] execVM "test2.sqf";