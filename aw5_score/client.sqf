/////////////////////////////
//----- Eventhandlers -----//
/////////////////////////////
"AW_event_checkTerritoryControl" addPublicVariableEventhandler{
	terminate AW_handle_calculateTerritory;
	AW_handle_calculateTerritory = (_this select 1) spawn AW_script_recalculateTerritory;
};

//sets the little progress hint on the map for both sides
"AW_event_AOControlMarkerInfo" addPublicVariableEventHandler{
	"fl_marker_AO_score" setMarkerTextLocal format ["AO control -> BluFor: %1/100, RedFor %2/100", fl_AOControlMarkerInfo select 0, fl_AOControlMarkerInfo select 1];
};

//updates the total score hint on the map to show the battle performance
"AW_event_TotalScore" addPublicVariableEventHandler{
	"fl_marker_total_score" setMarkerTextLocal format ["Total score -> BluFor: %1, RedFor %2", ([((AW_event_TotalScore select 0) / AW_AOScoreLimitTime) * 100,1] call BIS_fnc_cutDecimals), ([((AW_event_TotalScore select 1) / AW_AOScoreLimitTime) * 100,1] call BIS_fnc_cutDecimals)];
};

//Message Eventhandler
"AW_event_debugMessage" addPublicVariableEventHandler{
	player sidechat format["%1",_this select 1];
};

//Change AO
"AW_event_clientInitNewAO" addPublicVariableEventHandler{
	terminate AW_handle_initializeAO;
	AW_handle_initializeAO = [_this select 1] spawn AW_script_initializeAO;
	//--- reset onClick Event in case another officer is still picking an AO
	onMapSingleClick "";
};

"AW_allowAOPick" addPublicVariableEventHandler{
	//AW_chatLogic globalchat format["The area has been taken. %1 will choose the next AO",_this select 1];
};

"AW_c5_AOcontrol" addPublicVariableEventHandler{
	{
		_AOMarkerName = format['AW_AO_%1',_x select 0];
		switch(_x select 1)do{
			case(0):{_AOMarkerName setMarkerColorLocal "ColorRed"};
			case(1):{_AOMarkerName setMarkerColorLocal "ColorBlue"};
			case(-1):{_AOMarkerName setMarkerColorLocal "ColorBlack"};
			default{};
		};
	}forEach (_this select 1);
/*
	{
		_AOMarkerName = format['AW_AO_%1',_x select 0];
		
		switch((_this select 1) select (_x select 0))do{
			case(0):{_AOMarkerName setMarkerColorLocal "ColorRed"};
			case(1):{_AOMarkerName setMarkerColorLocal "ColorBlue"};
			case(-1):{_AOMarkerName setMarkerColorLocal "ColorBlack"};
			default{};
		};
	}forEach AW_c5_AOArray;
*/
};

"AW_event_CVisReady" addPublicVariableEventHandler{
	if (!isServer) then{
		if (str (player) in AW_officers_Cfg) then{
			switch (true) do{
				case ((_this select 1) == 0 && playerside == west):{["Command Vehicle","position established"] spawn BIS_fnc_infoText;};
				case ((_this select 1) == 1 && playerside == east):{["Command Vehicle","position established"] spawn BIS_fnc_infoText;};
				default {};
			};
		};
	};
};

"AW_GameOverMusic" addPublicVariableEventHandler{
	if (!isServer) then{
		0 fadeMusic 0;
		16 fadeMusic 0.8;
		playMusic ["EP1_Track12", 14];
	};
};

"AW_isGameRunning" addPublicVariableEventHandler{
	if (!isServer && !AW_isGameRunning) then{
		execVM "aw5_score\client\outro.sqf";
	};
};

"AW_noScoreover" addPublicVariableEventHandler{
	["The area is","now contested"] spawn BIS_fnc_infoText;
};

"AW_AOChangeAnnounce" addPublicVariableEventHandler{
	if (!isServer) then{
		AW_announce_bluAOPoints = (_this select 1) select 0;
		AW_announce_redAOPoints = (_this select 1) select 1;
		//fl_announce_bluLosses = (_this select 1) select 2;
		//fl_announce_redLosses = (_this select 1) select 3;
		//fl_announce_AO = (_this select 1) select 4;
		
		[] spawn {
			0 fadeMusic 0;
			19 fadeMusic 0.7;
			playMusic "Short01_Defcon_Three";
			
			sleep 10;
			
			if (AW_announce_bluAOPoints > AW_announce_redAOPoints) then{
				["RAR has seized","control of the AO"] spawn BIS_fnc_infoText;
			}else{
				["TRG has seized","control of the AO"] spawn BIS_fnc_infoText;
			};
			sleep 5;
			/*
			AW_chatLogic globalChat format["--------------"];
			AW_chatLogic globalChat format["Combat report:"];
			AW_chatLogic globalChat format["CBC: %1, (-%2 from unit losses)",fl_announce_bluAOPoints,fl_announce_bluLosses];
			AW_chatLogic globalChat format["ZFL: %1, (-%2 from unit losses)",fl_announce_redAOPoints,fl_announce_redLosses];
			AW_chatLogic globalChat format["--------------"];
			*/
		};
		//reset all hostile vehicle markers, so they dont stay on the map for 10 minutes while the AO moves.
		/*
		{
			_marker = _x;
			_marker SetMarkerPosLocal [0,0,0];
			_marker setMarkerTextLocal "";
		} forEach fl_HostileVehicles;
		*/
	};
};

/*
//Let players choose a new AO
"AW_event_chooseNewAO" addPublicVariableEventHandler{
	//0 = east,1 = west, -1 = any side
	[_this select 1] call AW_script_chooseNewAO;
};
*/
//----- EH End -----//

//----- Client.sqf ----- Begin ----- //

AW_script_GetClickedAOMarker = compile preprocessfilelinenumbers "aw5_score\client\getClickedAOMarker.sqf";
AW_script_chooseNewAO = compile preprocessfilelinenumbers "aw5_score\client\chooseNewAO.sqf";

if (AW_C5_EditorMode == 0) then{
	[]execVM 'aw5_score\dev\AW_DrawDevBorders.sqf';
};