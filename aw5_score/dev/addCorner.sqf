onMapSingleClick "
	_x =_pos select 0;
	_y =_pos select 1;
	
	_cornerMarkerName = format['AW_cornerMarker_%1',count AW_c5_cornerArray];
	_cornerMarkerName = createMarkerLocal [_cornerMarkerName, [_x,_y]];
	_cornerMarkerName setMarkerShapeLocal 'ICON';
	_cornerMarkerName setMarkerTypeLocal 'mil_dot';
	_cornerMarkerName setmarkerTextLocal format['%1',count AW_c5_cornerArray];
	
	AW_c5_cornerArray set [count AW_c5_cornerArray,[AW_c5_cornerCount,_x,_y]];
	
	AW_c5_cornerCount = AW_c5_cornerCount + 1;
";