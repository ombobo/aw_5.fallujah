/*
* Created By Jones
* last updated 1/16/2012
*/
onMapSingleClick "
	_x =_pos select 0;
	_y =_pos select 1;
	vehicle player setPos [_x,_y,1];
	{
		player reveal _x;
	}forEach ((position player) nearObjects 100);
	onMapSingleClick '';
";

