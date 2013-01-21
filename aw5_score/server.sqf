AW_bluTerritories = 1;
AW_bluTerritories = 1;

"AW_event_serverInitNewAO" addPublicVariableEventHandler{
	AW_allowAOPick = resistance;
	publicVariable "AW_allowAOPick";
	
	terminate AW_handle_noScoreTimer;
	terminate AW_handle_initializeAO;
	AW_handle_initializeAO = [_this select 1] spawn AW_script_initializeAO;
	
	//----- Send new AO info to all clients
	AW_event_clientInitNewAO = _this select 1;
	publicVariable "AW_event_clientInitNewAO";
	
	AW_sideToPickAO = resistance;
	publicVariable "AW_sideToPickAO";
	
	AW_oldAO = AW_activeAO;
	//publicVariable "AW_oldAO";
	AW_activeAO = _this select 1;
	publicVariable "AW_activeAO";
	
	//AW_c5_AOcontrol set[AW_activeAO,-1];
	{
		if ((_x select 0) == AW_activeAO) then{
			AW_c5_AOcontrol set[_forEachIndex,[AW_activeAO,-1]];
		};
	}forEach AW_c5_AOcontrol;
	publicVariable "AW_c5_AOcontrol";
	
	//get distance from the old to the new AO
	_newAO = format['AW_AO_%1',AW_activeAO];
	_oldAO = format['AW_AO_%1',AW_oldAO];
	_dist = (markerPos _newAO) distance (markerPos _oldAO);
	AW_noScoreTimer = ((2 + (_dist / 1000)) min 10) * 60;
	
	AW_noScoreTimer = [AW_noScoreTimer,1] call BIS_fnc_cutDecimals;
	diag_log format["noScore: %1",AW_noScoreTimer];
	
	AW_AOHasBeenPicked = true;
};

AW_script_AOcaptured = compile preProcessFileLineNumbers "aw5_score\server\AOCaptured.sqf";

[]execVM "aw5_score\main.sqf";