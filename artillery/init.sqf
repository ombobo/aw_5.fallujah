/*
* Created By Jones
*/

private["_loadClientScripts","_loadServerScripts"];
/*
* Loads client related scripts
*/
_loadClientScripts ={
	AW_FireMission = false;
	if(((str player) in AW_officers_Cfg) || (AW_trainingEnabled_Param == 1))then{
		[]execVM "artillery\client.sqf";
	};	
};
/*
* loads server related scripts					
*/
_loadServerScripts ={
	AW_westArtyAmmo = 150;
	publicVariable "AW_westArtyAmmo";
	//AW_EastArtyAmmo = 150;
	AW_eastArtyAmmo = 150;
	publicVariable "AW_eastArtyAmmo";
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




