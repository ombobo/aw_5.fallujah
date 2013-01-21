private["_loadClientScripts","_loadServerScripts"];

/*
####################
# Global functions #				
####################
*/

if(isNil "AW_westCasualties")then{AW_westCasualties = 0;};
if(isNil "AW_eastCasualties")then{AW_eastCasualties = 0;};

/*
################################
# Loads client related scripts #				
################################
*/

_loadClientScripts ={
	waitUntil {!isNull player};
	waitUntil {player == player};
	
    []execVM "core\respawn\init.sqf";
	
	[]execVM "core\fixes\RestoreRating.sqf";
	[]execVM "core\security\protectionZones.sqf";
	
	if(AW_tagCheckEnabled_Param == 1)then{[]execVM "core\security\tagCheck.sqf";};
	if(AW_introEnabled_Param == 1)then{[]execVM "core\intro\intro.sqf";};
	
	[]execVm "core\identification\init.sqf";
	[]execVm "core\vehicleManager\client_mod.sqf";
	
	/*//preventDamage was used as spawn protection when teleporting to the bunkers in the KOTI campaign-mode
	AW_fnc_PreventDamage = compile preprocessFileLineNumbers "core\functions\preventDamage.sqf";
	"AW_PreventDamage" addPublicVariableEventHandler {[AW_PreventDamage] spawn AW_fnc_PreventDamage};
	*/
	
	//----- Disable all conversations (*greeting*)
	
	player disableConversation true;
	
	//----- Other non-essential modules
	
	[]execVM "weaponresting\weaponresting.sqf";
	[]execVM "module_identifyInfantry\init.sqf";
	
	//----- Reveal vehicles at spawn and leave the initial group
	
	[] spawn {
		/*
		switch(playerSide)do{
			case(West):{[player] joinSilent (group west_inf_dummy);};
			case(East):{[player] joinSilent (group east_inf_dummy);};
			default{};
		};
		*/
		[player] joinSilent grpNull; 
		{
			player reveal _x;
		}forEach ((position player) nearObjects 100);
	};
	[]execVM "core\functions\manageEquipment.sqf";
};

/*
################################
# Loads server related scripts #				
################################
*/

_loadServerScripts ={
	//[]execVM "core\fixes\BridgeBuild.sqf";
	[]execVm "core\vehicleManager\server.sqf";
	AW_func_CasualtyTracker = compile preprocessFileLineNumbers "core\functions\casualtyTracker.sqf";
	"AW_casualtyFlag" addPublicVariableEventHandler {[_this select 1]spawn AW_func_CasualtyTracker;};
	//vehicle protection. shows a message when a vehicle is destroyed in the safezone
	//[]execVm "core\security\vehicleprotection.sqf"; //WIP
};			
//single player, load both client and server
if(!isMultiplayer)exitWith{
	[]call _loadServerScripts;
	[]call _loadClientScripts;
};
//server scripts
if(isServer)then{
	[]call _loadServerScripts;
};
// client scripts
if(!isServer)then{
	[]call _loadClientScripts;
};