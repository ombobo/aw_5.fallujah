private ["_pos","_x","_y","_z"];
_pos = _this select 0;
_x = _pos select 0;
_y = _pos select 1;
_z = _pos select 2;

if (side player == west) then {	
	AW_FM_PositionWest = [_x,_y,_z];
	///range check
	_invalidRange = (getMarkerPos "respawn_east")distance _pos;
	if ( _invalidRange < 1500 ) then {hint "Fire mission too close to enemy base!"; AW_FM_PositionWest = [0,0,0];};
	AW_FM_markerWest setMarkerPosLocal AW_FM_PositionWest;

};
if (side player == east) then {	
	AW_FM_PositionEast = [_x,_y,_z];
	//range check
	_invalidRange = (getMarkerPos "respawn_west")distance _pos;
	if ( _invalidRange < 1500 ) then {hint "Fire mission too close to enemy base!"; AW_FM_PositionEast = [0,0,0];};
	AW_FM_markerEast setMarkerPosLocal AW_FM_PositionEast;
};

