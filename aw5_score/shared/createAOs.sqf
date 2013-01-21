
//----- Create Corners
{
	_cornerNumber = _x select 0;
	_cornerPos = [_x select 1,_x select 2];
	
	//diag_log text format["createAOs. CornerNr: %1, CornerPos: %2",_cornerNumber,_cornerPos];
	
	_cornerMarkerName = format['AW_AOCorner_%1',_cornerNumber];
	
	_cornerMarkerName = createMarkerLocal [_cornerMarkerName, _cornerPos];
	_cornerMarkerName setMarkerShapeLocal 'ICON';
	_cornerMarkerName setMarkerTypeLocal 'mil_dot';
	_cornerMarkerName setMarkerSizeLocal [0.5,0.5];
	//_cornerMarkerName setmarkerTextLocal format['%1',_cornerNumber];
	_cornerMarkerName setmarkerAlphaLocal 0;
}forEach AW_c5_cornerArray;

//----- Create AOs
{
	_minX = 99999;
	_maxX = 0;
	_minY = 99999;
	_maxY = 0;
	
	_corners = _x select 1;
	
	{
		_cornerMarkerName = format['AW_AOCorner_%1',_x];
		_markerPos = markerPos _cornerMarkerName;
		_minX = _minX min (_markerPos select 0);
		_maxX = _maxX max (_markerPos select 0);
		_minY = _minY min (_markerPos select 1);
		_maxY = _maxY max (_markerPos select 1);
	}forEach _corners;
	
	_AOMarkerName = format['AW_AO_%1',_x select 0];
	
	_AOMarkerName = createMarkerLocal [_AOMarkerName, [(_minX + _maxX) / 2,(_minY + _maxY) / 2]];
	_AOMarkerName setMarkerShapeLocal 'ICON';
	_AOMarkerName setMarkerSizeLocal [0.0,0.0];
	_AOMarkerName setMarkerTypeLocal 'hd_flag';
	_AOMarkerName setmarkerTextLocal format['%1',_x select 0];
	_AOMarkerName setmarkerAlphaLocal 0.5;
	/*
	switch(AW_c5_AOcontrol select (_x select 0))do{
		case(0):{_AOMarkerName setMarkerColorLocal "ColorRed"};
		case(1):{_AOMarkerName setMarkerColorLocal "ColorBlue"};
		case(-1):{_AOMarkerName setMarkerColorLocal "ColorBlack"};
		default{};
	};
	*/
}forEach AW_c5_AOArray;
//----- Colorize AOs
{
	_AOMarkerName = format['AW_AO_%1',_x select 0];
	switch(_x select 1)do{
		case(0):{_AOMarkerName setMarkerColorLocal "ColorRed"};
		case(1):{_AOMarkerName setMarkerColorLocal "ColorBlue"};
		case(-1):{_AOMarkerName setMarkerColorLocal "ColorBlack"};
		default{};
	};
}forEach AW_c5_AOcontrol;