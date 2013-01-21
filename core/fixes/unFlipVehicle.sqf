/*
* Created By Jones
* last updated 1/16/2012
*/
_vehicle = vehicle player;
if (player != _vehicle) then{
	if !(_vehicle isKindOf "air")then{
		_vehicle setPos [getPos _vehicle select 0,getpos _vehicle select 1,0.5];
	};
};
if (player == _vehicle) then{
	_objects = player NearEntities[["Car","Motorcycle","Tank"],10];
	if (count _objects > 0) then{
		{_x setPos [getPos _x select 0,getpos _x select 1,0.5]} forEach _objects;
	};
};