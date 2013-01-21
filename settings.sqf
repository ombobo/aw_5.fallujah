/*
* Created By Jones
* last updated 1/16/2012
*/
///////////////////////////////////////////////////////////////
///Settings file is where the MP lobby parameters are set
///////////////////////////////////////////////////////////////
private["_configScript","_setMoonState"];
/*
* Name: _setMoonState
* Desc: Sets the date to nights with various moon setings
* Params: NA
* Returns: NA
*/
_setMoonState ={
	private["_moonState"];
	switch (AW_moonSettings_Param) do {
		case 1:{_moonState = [2012, 7, 6, 00, 0];};//full moon
		case 2:{_moonState = [2012, 7, 11, 00, 0];};//half moon
		case 3:{_moonState = [2012, 7, 27, 00, 0];};//new moon
	};
	setDate _moonState;	
};
///single player logic
if (!isMultiPlayer) exitWith{
	AW_isGameRunning = true;
	AW_inGameTime_Param = daytime;
	AW_moonSettings_Param = 1;
	AW_tagCheckEnabled_Param = 2;
	AW_trainingEnabled_Param  = 1;
	AW_introEnabled_Param = 2;
	AW_markerMode_Param = 2;
	AW_SpawnTime_Param = 20;
	AW_viewDistance_Param = 3000;
	AW_terrainGrid_Param = 3.125;
	AW_BattleDuration_param = 10800;
	
	fl_NeutralZone =  250;
	fl_TimeBetweenAOs = 30;
	AW_AOScoreLimitSetting = -1;
	AW_AOScoreLimitTime = AW_AOScoreLimitSetting;
	fl_Chain = 3;
	fl_activeAO = 4;
	
	AW_C5_Features = 1;
	AW_C5_EditorMode = 0;
	
	AW_activeAO = 6;
	
	AW_territorySteps = 50;
	
	setviewdistance AW_viewDistance_Param;
	setterraingrid AW_terrainGrid_Param;	
	[]call _setMoonState;
	skiptime AW_inGameTime_Param;
};
/////////////////////////////////////////////
//multiplayer logic
/////////////////////////////////////////////
AW_isGameRunning = true;//flag to determine if the mission is still running
AW_inGameTime_Param = paramsArray select 0;
AW_moonSettings_Param  = paramsArray select 1;
AW_tagCheckEnabled_Param = paramsArray select 2;
AW_trainingEnabled_Param  = paramsArray select 3;
AW_introEnabled_Param  = paramsArray select 4;
AW_markerMode_Param = paramsArray select 5;
AW_SpawnTime_Param = paramsArray select 6;
AW_viewDistance_Param = paramsArray select 7;
AW_terrainGrid_Param = paramsArray select 8;
AW_BattleDuration_param = paramsArray select 9;

fl_TimeBetweenAOs = paramsArray select 10;
AW_AOScoreLimitSetting = paramsArray select 11;
AW_AOScoreLimitTime = AW_AOScoreLimitSetting;

AW_C5_EditorMode = paramsArray select 12;

if (isNil "AW_activeAO") then{AW_activeAO = paramsArray select 13;};

AW_territorySteps = paramsArray select 14;
//server only scripts
if (isServer) then{	
	[]call _setMoonState;
	skiptime AW_inGameTime_Param;
};
//client only scripts
if (!isServer) then{	
	setviewdistance AW_viewDistance_Param;
	setterraingrid AW_terrainGrid_Param;	
	enableSaving [false, false];
	enableSentences false;
	player enableAttack false;
};


