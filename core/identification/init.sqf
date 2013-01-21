/*
* Created By Jones
* last updated 1/16/2012
*/
private["_loadMarkerModule","_settingsScript","_loadClientScripts","_loadServerScripts"];

/*
* uses MP lobby paramters to start the unit marker script
*
*/
_loadMarkerModule ={
	if(playerSide == resistance)exitWith{[]execVM "core\identification\cnr_fl_markers.sqf";};
	if(AW_markerMode_Param > 1)then{[]spawn compile preprocessFileLineNumbers "core\identification\cnr_fl_markers.sqf";};
	//if(AW_markerMode_Param > 1)then{[]spawn compile preprocessFileLineNumbers "core\identification\aw5_markers_2.sqf";};
	//if(playerSide == resistance)exitWith{[]execVM "core\identification\cnr_fl_markers.sqf";};
	//if(AW_markerMode_Param > 1)then{[]execVM "core\identification\cnr_fl_markers.sqf";};
};

/*
* Loads client related scripts
*/
_loadClientScripts ={	
	[]spawn _loadMarkerModule;
	[]execVM "core\identification\vehicleHint.sqf";
};
/*
* loads server related scripts
*/
_loadServerScripts ={

};			
//single player
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




