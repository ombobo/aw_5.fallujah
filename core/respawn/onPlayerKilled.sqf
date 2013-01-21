/*
* Created By Jones
*/
private["_body","_killer"];
_body = _this select 0;
_killer = _this select 1;//might be useful down the road

AW_playerKiller = _killer;
titleText["Dead!","BLACK OUT", 5];

5 fadeSound 0;

AW_playerWeapons = weapons _body;
AW_playerMagazines = magazines _body; 
_body removeWeapon primaryWeapon _body;
_body removeWeapon secondaryWeapon _body;
sleep 120+(random 30);
hideBody _body;