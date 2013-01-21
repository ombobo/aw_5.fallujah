private["_clickPos","_closestMarkerDist","_closestMarker"];
_clickPos = _this select 0;

_closestMarkerDist = 2000;
_closestMarker = -1;

{
	_AOMarkerPos = markerPos format['AW_AO_%1',_x select 0];
	if ((_clickPos distance _AOMarkerPos) < _closestMarkerDist) then{
		_closestMarkerDist = (_clickPos distance _AOMarkerPos);
		_closestMarker = _x select 0;
	};
}forEach AW_c5_AOArray;

_closestMarker
