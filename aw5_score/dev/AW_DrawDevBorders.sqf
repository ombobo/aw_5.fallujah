for "_i" from 0 to AW_c5_devBorderCount do{
	_deletemarkerName = format["AW_AOBorder_%1",_i];
	deleteMarkerLocal _deletemarkerName;
};

AW_c5_borderArray = [];
AW_c5_devBorderCount = 0;
AW_c5_doubleDevBorderCount = 0;

private["_pos1","_pos2","_combinedX","_combinedY","_dir","_borderMarkerName","_drawAOBorder"];

_drawAOBorder = {
	private["_pos1","_pos2","_combinedX","_combinedY","_dir","_borderMarkerName"];
	
	_corner1 = _this select 0;
	_corner2 = _this select 1;
	
	//----- Check if Border has been drawn already
	_BorderAlreadyDrawn = false;
	{
		if ((_x select 0) == (_corner1 min _corner2)) then{
			if ((_x select 1) == (_corner1 max _corner2)) exitWith{_BorderAlreadyDrawn = true;};
		};
	}forEach AW_c5_borderArray;
	if (_BorderAlreadyDrawn) exitWith{AW_c5_doubleDevBorderCount = AW_c5_doubleDevBorderCount + 1;};
	
	
	AW_c5_borderArray set[count AW_c5_borderArray,[(_corner1 min _corner2),(_corner1 max _corner2)]];
	
	_pos1 = markerPos format["AW_AOCorner_%1",_corner1];
	_pos2 = markerPos format["AW_AOCorner_%1",_corner2];
	
	_combinedX = ((_pos1 select 0) + (_pos2 select 0)) / 2;
	_combinedY = ((_pos1 select 1) + (_pos2 select 1)) / 2;
	
	_dir = [_pos1,_pos2]call BIS_fnc_dirTo;
	if (_dir < 0) then{_dir = _dir + 360;};
	
	_borderMarkerName = format["AW_AOBorder_%1",AW_c5_devBorderCount];
	
	AW_c5_devBorderCount = AW_c5_devBorderCount + 1;
	
	_borderMarkerName = createMarkerLocal [_borderMarkerName, [_combinedX,_combinedY]];
	
	_borderMarkerName setMarkerDirLocal (_dir + 90);
	_borderMarkerName setMarkerSizeLocal [(_pos1 distance _pos2) / 2,1];
	_borderMarkerName setMarkerShapeLocal "RECTANGLE";
	_borderMarkerName setMarkerBrushLocal "Border";
	_borderMarkerName setMarkerAlphaLocal 1;
};

{
	//diag_log _x;
	AW_c5_currentCorners = _x select 1;
	//player sidechat format["creating borders for %1",AW_c5_currentCorners];
	{
		//diag_log AW_c5_currentCorners;
		//diag_log (AW_c5_currentCorners select _forEachIndex);
		//diag_log (AW_c5_currentCorners select (_forEachIndex + 1));
		switch(true)do{
			case(_forEachIndex == 0):{
				[AW_c5_currentCorners select _forEachIndex,AW_c5_currentCorners select (_forEachIndex + 1)] call _drawAOBorder;
			};
			case(_forEachIndex == ((count AW_c5_currentCorners) - 1)):{
				[AW_c5_currentCorners select ((count AW_c5_currentCorners) - 1),AW_c5_currentCorners select 0] call _drawAOBorder;
			};
			default{
				//diag_log AW_c5_currentCorners;
				//diag_log (AW_c5_currentCorners select _forEachIndex);
				//diag_log (AW_c5_currentCorners select (_forEachIndex + 1));
				[AW_c5_currentCorners select _forEachIndex,AW_c5_currentCorners select (_forEachIndex + 1)] call _drawAOBorder;
			};
		};
	}forEach AW_c5_currentCorners;
}forEach AW_c5_AOArray;

//player sidechat format["B: %1, D: %2",AW_c5_devBorderCount,AW_c5_doubleDevBorderCount];