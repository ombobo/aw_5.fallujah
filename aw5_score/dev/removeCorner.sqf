hint "Click on a corner to remove it.\n\nHold shift or alt while clicking to stop removing corners";

onMapSingleClick "
	if (_shift || _alt) then{
		onMapSingleClick '';
		hint 'No longer removing corners on click';
	}else{
		_x =_pos select 0;
		_y =_pos select 1;
		
		AW_EH_removeCorner = [_x,_y]call GetCornerMarker;
		player sidechat format['removed corner %1',AW_EH_removeCorner];
		publicVariableServer 'AW_EH_removeCorner';
	};
";