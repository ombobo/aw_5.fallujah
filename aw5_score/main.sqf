diag_log "starting main.sqf";

_minTerritoryUpdateDelay = 30;
_checkInterval = 30;
_modifier = _checkInterval / 60; //1 full point per minute
_nextScoreUpdate = 0;
_nextLoop = 0;
_lastRecalc = 0;

AW_calcTerritoryNow = 0; 

AW_bluTotalScore = 0;
AW_redTotalScore = 0;

AW_CVDeployedTime = {
	private["_vehicle","_deployTime","_fired_tickTime","_isCVReady","_result"];
	
	_vehicle = _this select 0;
	
	_deployedVar = _vehicle getVariable ["isDeployed", 0];
	_deployTime = _vehicle getVariable ["DeployTime",-1];
	_fired_tickTime = _vehicle getVariable ["fired_tickTime",0];
	_isCVReady = _vehicle getVariable ["isCVReady",false];
	
	if (_deployedVar == 1 && !_isCVReady) then{
		switch(true)do{
			case(_deployTime == 0):{
				_vehicle setVariable ["DeployTime", diag_tickTime, false];
			};
			case(_deployTime > 0):{
				if (diag_tickTime > (_deployTime + 10) && diag_tickTime > (_fired_tickTime + 60)) then {
					player sidechat format["vcl %1 ready",_vehicle]; //debug
					_vehicle setVariable ["isCVReady", true, false];
					switch (faction _vehicle) do{
						case("AW_BLU"):{AW_event_CVisReady = 0;publicVariable "AW_event_CVisReady";};
						case("AW_RED"):{AW_event_CVisReady = 1;publicVariable "AW_event_CVisReady";};
						default {};
					};
				};
			};
			default{};
		};
	};
	
	if (_deployedVar == 0 && _isCVReady) then{
		_vehicle setVariable ["isCVReady", false, false];
	};
};

//----- Debug Begin
/*
[] spawn{
	while{true}do{
		sleep 2;
		AW_event_checkTerritoryControl = 1;
		publicVariable "AW_event_checkTerritoryControl";
		
		terminate AW_handle_calculateTerritory;
		AW_handle_calculateTerritory = [] spawn AW_script_recalculateTerritory;
		sleep 10;
	};
};
*/

AW_BattleInitTime = diag_tickTime;
AW_BattleDuration = AW_BattleDuration_param; //takes value from mission params

//----- There needs to be a script with that handle in memory so scriptDone gets a proper return value
AW_handle_calculateTerritory = [] spawn {true;};
//-----
if (AW_trainingEnabled_Param != 1) then{
	_beginTime = diag_tickTime;
	_noScoringTimer = 60 * 15;
	waitUntil {sleep 0.1;diag_tickTime > (_beginTime + _noScoringTimer)};
	AW_noScoreover = true;
	publicVariable "AW_noScoreover";
}else{
	_beginTime = diag_tickTime;
	_noScoringTimer = 1;
	waitUntil {sleep 0.1;diag_tickTime > (_beginTime + _noScoringTimer)};
	AW_noScoreover = true;
	publicVariable "AW_noScoreover";
};

while{true}do{
	//----- Check if game is over
	
	if ((diag_tickTime + 15) > AW_BattleDuration + AW_BattleInitTime && !AW_GameOverMusic) then{
		AW_GameOverMusic = true;
		PublicVariable "AW_GameOverMusic";
	};
	
	if (diag_tickTime > AW_BattleDuration + AW_BattleInitTime) exitwith{
		sleep 1;
		AW_isGameRunning = false;
		PublicVariable "AW_isGameRunning";
	};
	
	//----- Check if area should be recalculated, but wait at least 2 minutes
	if (AW_calcTerritoryNow == 1 || diag_tickTime >= (_lastRecalc + _minTerritoryUpdateDelay))then{
		
		AW_calcTerritoryNow = 0;
		_lastRecalc = floor(diag_tickTime + _minTerritoryUpdateDelay);
		
		//AW_event_checkTerritoryControl = 1;
		//publicVariable "AW_event_checkTerritoryControl";
		
		terminate AW_handle_calculateTerritory;
		AW_handle_calculateTerritory = [] spawn AW_script_recalculateTerritory;
	};
	
	//----- Check if CV can score
	{
		[_x] call AW_CVDeployedTime;
	}forEach [west_cv,east_cv];
	
	//----- Award territory control score. (1 point per second, divided between the sides based on control)
	if (AW_bluTerritories > 0) then{
		AW_bluTotalScore = AW_bluTotalScore + ([(AW_bluTerritories / AW_territoryCount),2] call BIS_fnc_cutDecimals);
	};
	if (AW_redTerritories > 0) then{
		AW_redTotalScore = AW_redTotalScore + ([(AW_redTerritories / AW_territoryCount),2] call BIS_fnc_cutDecimals);
	};
	
	if ((diag_tickTime >= _nextScoreUpdate) && (scriptDone AW_handle_calculateTerritory) && (scriptDone AW_handle_initializeAO)) then{	
		AW_event_TotalScore = [AW_bluTotalScore,AW_redTotalScore];
		//diag_log AW_event_TotalScore;
		publicVariable "AW_event_TotalScore";
		_nextScoreUpdate = floor(diag_tickTime + _checkInterval);
	};
	

	if ((AW_bluTotalScore >= AW_AOScoreLimitTime) || (AW_redTotalScore >= AW_AOScoreLimitTime)) then{
		[AW_bluTotalScore,AW_redTotalScore] call AW_script_AOcaptured;
		
		AW_AOChangeAnnounce = [AW_bluTotalScore,AW_redTotalScore];
		publicVariable "AW_AOChangeAnnounce";
		
		AW_AOHasBeenPicked = false;
		waitUntil{sleep 0.02;AW_AOHasBeenPicked};
		
		//--- No Score Timer between AOs
		terminate AW_handle_noScoreTimer;
		AW_handle_noScoreTimer = [] spawn{
			if (AW_trainingEnabled_Param != 1) then{
				_beginTime = diag_tickTime;
				_noScoringTimer = AW_noScoreTimer;
				waitUntil {sleep 0.1;diag_tickTime > (_beginTime + _noScoringTimer)};
				AW_noScoreover = true;
				publicVariable "AW_noScoreover";
			}else{
				_beginTime = diag_tickTime;
				_noScoringTimer = 1;
				waitUntil {sleep 0.1;diag_tickTime > (_beginTime + _noScoringTimer)};
				AW_noScoreover = true;
				publicVariable "AW_noScoreover";
			};
		};
		waitUntil{sleep 0.02;scriptDone AW_handle_noScoreTimer;};
		
		//--- Reset AO Score
		AW_bluTotalScore = 0;
		AW_redTotalScore = 0;
	};
	
	waitUntil{sleep 0.02;diag_tickTime >= _nextLoop;};
	_nextLoop = floor(diag_tickTime + 1);
};