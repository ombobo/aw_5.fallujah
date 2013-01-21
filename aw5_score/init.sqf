if !(isDedicated) then{
	//AW_chatLogic globalchat format["This is the campaign 5 mission preview"];
	//AW_chatLogic globalchat format["_Nothing_ in this version should be considered final"];
	//AW_chatLogic globalchat format["This mission only demonstrates the C5 scoring mechanics."];
	//AW_chatLogic globalchat format["Equipment will be adjusted accordingly in one of the next versions"];
};

//----- Set marker alpha of most markers to 0 to clean up the map
for "_i" from 0 to 10 do{
    _helpermarker = format["fl_helper%1",_i];
	if (getmarkercolor _helpermarker != "") then{
		_helpermarker setMarkerAlphaLocal 0;
	};
};

"fl_top_triggermarker" setMarkerAlphaLocal 0;
"fl_bot_triggermarker" setMarkerAlphaLocal 0;

for "_i" from 1 to 10 do{
	_markerName = format["aw5_obj_%1",_i];
	if (markerColor _markerName != "") then{_markerName setMarkerAlphaLocal 0;};
	_markerName = format["aw5_not_%1",_i];
	if (markerColor _markerName != "") then{_markerName setMarkerAlphaLocal 0;};
	_markerName = format["obj_3_%1",_i];
	if (markerColor _markerName != "") then{_markerName setMarkerAlphaLocal 0;};
	_markerName = format["ao_3_%1",_i];
	if (markerColor _markerName != "") then{_markerName setMarkerAlphaLocal 0;};
};

//----- Scripts starting below

AW_GameOverMusic = false;
AW_allowAOPick = resistance;

_sharedScripts = {
	switch(AW_C5_EditorMode)do{
		case(0):{AW_handle_sharedInit = []execVM "aw5_score\shared.sqf";};
		case(1):{[]execVM "aw5_score\dev\init.sqf";};
		default{};
	};
};

_clientScripts = {
	AW_clientHandle = []execVM "aw5_score\client.sqf";
};

_serverScripts = {
	AW_serverHandle = []execVM "aw5_score\server.sqf";
};

switch(true)do{
	//Server in MP
	case(isDedicated):{
		[]call _sharedScripts;
		waitUntil{scriptDone AW_handle_sharedInit};
		[]call _serverScripts;
	};
	//Client in MP
	case(!isServer):{
		[]call _sharedScripts;
		waitUntil{scriptDone AW_handle_sharedInit};
		[]call _clientScripts;
	};
	//A hosting client or editor-mode
	case(isServer):{
		[]call _sharedScripts;
		waitUntil{scriptDone AW_handle_sharedInit};
		[]call _serverScripts;
		[]call _clientScripts;
	};
	default{};
};