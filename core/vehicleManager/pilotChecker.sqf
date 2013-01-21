_vehicle = _this select 0;
_position = _this select 1;
_unit = _this select 2;
if(!isServer) exitWith{};

if!((str _unit) in AW_pilots_Cfg)then{	
	switch(_position)do{
		case "driver":{
			sleep 2;
			driver _vehicle action["GetOut",_vehicle];
		};
		//case "gunner": {/*not blocked*/};
		default{};
	};
};
