hint "Click on the AO, that you want to remove.\n\nHold shift or alt while clicking to stop removing AOs.";

onMapSingleClick "
	if (_shift || _alt) then{
		onMapSingleClick '';
		hint 'No longer removing AOs on click';
	}else{
		_x =_pos select 0;
		_y =_pos select 1;
		
		_ClosestAONumber = [_x,_y]call GetAOMarker;
		if (_ClosestAONumber == -1) then{
			player sidechat 'No AO will be deleted';
		}else{
			player sidechat format['Deleting AO %1',_ClosestAONumber];
			
			AW_EH_removeAO = _ClosestAONumber;
			publicVariableServer 'AW_EH_removeAO';
		};
	};
";