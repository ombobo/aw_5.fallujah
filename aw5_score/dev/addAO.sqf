
hint "NOTE:\nCORNERS HAVE TO BE SELECTED CLOCKWISE\n\nSelect the corners you want for the AO by clicking close to them.\nTo finalize the AO, just click on the first corner again.";

AW_NewCornerArray = [];

AW_NewCornerX = 0;
AW_NewCornerY = 0;

onMapSingleClick "
	_x =_pos select 0;
	_y =_pos select 1;
	
	_ClosestMarkerNumber = [_x,_y]call GetCornerMarker;
	
	if (_ClosestMarkerNumber in AW_NewCornerArray) then{
		onMapSingleClick '';
		player sidechat format['added new AO with corners %1',AW_NewCornerArray];
		
		AW_EH_addAO = [[AW_NewCornerX,AW_NewCornerY],AW_NewCornerArray];
		publicVariableServer 'AW_EH_addAO';
	}else{
		AW_NewCornerArray set [count AW_NewCornerArray,_ClosestMarkerNumber];
		player sidechat format['Corners: %1',AW_NewCornerArray];
		AW_NewCornerX = AW_NewCornerX + _x;
		AW_NewCornerY = AW_NewCornerY + _y;
	};
";