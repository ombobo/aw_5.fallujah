/*
* Created By Jones
* last updated 1/16/2012
*/
titleCut["","BLACK IN",2];
_pos = position player;
_vehi = "Lada1" createVehicle [0,0,0];
player moveInCargo _vehi;
deleteVehicle _vehi;
player setPos _pos;