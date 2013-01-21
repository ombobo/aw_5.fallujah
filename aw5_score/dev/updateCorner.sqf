hint "Hold alt and click to select a corner.\n\nHold shift and click to update its position.";

AW_cornerToUpdateNumber = -1; //starting with an invalid corner

onMapSingleClick "
	_x =_pos select 0;
	_y =_pos select 1;
	
	if (_alt) then{
		AW_cornerToUpdateNumber = [_x,_y]call GetCornerMarker;
		player sidechat format['corner %1 will be updated on the next click',AW_cornerToUpdateNumber];
	};
	
	if (_shift) then{
		AW_EH_updateCorner = [AW_cornerToUpdateNumber,_x,_y];
		publicVariableServer 'AW_EH_updateCorner';
	};
";