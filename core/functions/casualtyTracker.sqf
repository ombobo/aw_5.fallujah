/*
* Created By Jones
* last updated 1/18/2012
*/
private["_side"];
_side = _this select 0;

if(isServer)then{
	switch(_side)do{
		case west:{
			AW_westCasualties = AW_westCasualties + 1;
			publicVariable "AW_westCasualties";
		};
		case east:{
			AW_eastCasualties = AW_eastCasualties + 1;
			publicVariable "AW_eastCasualties";
		};
	};
};

