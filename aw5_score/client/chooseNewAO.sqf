private["_passedSide"];

if (playerSide != AW_allowAOPick && playerSide != resistance) exitWith{
	AW_chatLogic globalChat format["Your side can not pick an AO at this time"];
};

AW_possibleAOs_Array = [];

onMapSingleClick "
	if (playerSide == AW_allowAOPick || playerSide == resistance) then{
		_AW_pickedAO = [_pos] call AW_script_GetClickedAOMarker;
		if (_AW_pickedAO != -1) then{
			AW_event_serverInitNewAO = _AW_pickedAO;
			publicVariableServer 'AW_event_serverInitNewAO';
			AW_chatLogic globalChat format['AO %1 has been picked',_AW_pickedAO]
		}else{
			AW_chatLogic globalChat format['The selected AO is not valid']
		};
	};
	onMapSingleClick '';
";
