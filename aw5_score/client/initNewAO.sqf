onMapSingleClick "
	_clickPos = [_pos select 0,_pos select 1];
	
	AW_event_serverInitNewAO = [_clickPos] call AW_script_GetClickedAOMarker;
	if (AW_event_serverInitNewAO != -1) then{
		publicVariable 'AW_event_serverInitNewAO';
		player sidechat format['AO %1 will be initialized',AW_event_serverInitNewAO];
	}else{
		player sidechat 'No valid AO chosen';
	};
	onMapSingleClick '';
";