//obsolete and should be cleaned up for the proper mission

_randomStart = true;

_setAt = 0;
_side = -1;

_markerBluStart = ["marker_base_2","marker_base_5","marker_base_21","marker_base_26","marker_base_22","marker_base_4","marker_base_24","marker_base_25","marker_base_43","marker_base_6"];
_markerRedStart = ["marker_base_1","marker_base_27","marker_base_38","marker_base_11","marker_base_7","marker_base_3","marker_base_34","marker_base_13","marker_base_29","marker_base_16"];
_markerGreenStart = [];

//----- Client executes this:
if (!isServer) exitWith{
	for "_counter" from 1 to 100 do{
		_baseName = format["marker_base_%1",_counter];
		if (markerColor _baseName != "") then{
			AW_marker_base_array set [_setAt,_baseName];
			_setAt = _setAt + 1;
		};
	};
};

//----- Server executes this:
if (_randomStart) then{
	for "_counter" from 1 to 100 do{
		_randomNumber = random(100);
		_baseName = format["marker_base_%1",_counter];
		if (markerColor _baseName != "") then{
			switch(true)do{
				case(_randomNumber < 30):{_side = 0;_baseName setmarkerColorLocal "ColorRed";};
				case(_randomNumber < 60):{_side = 1;_baseName setmarkerColorLocal "ColorBlue";};
				case(_randomNumber < 80):{_side = 2;_baseName setmarkerColorLocal "ColorGreen";};
				default{_side = -1;};
			};
			AW_marker_base_array set [_setAt,_baseName];
			AW_marker_side_array set [_setAt,_side];
			_setAt = _setAt + 1;
		};
	};
}else{
	for "_counter" from 1 to 100 do{
		_baseName = format["marker_base_%1",_counter];
		if (markerColor _baseName != "") then{
			switch(true)do{
				case(_baseName in _markerRedStart):{_side = 0;_baseName setmarkerColorLocal "ColorRed";};
				case(_baseName in _markerBluStart):{_side = 1;_baseName setmarkerColorLocal "ColorBlue";};
				case(_baseName in _markerGreenStart):{_side = 2;_baseName setmarkerColorLocal "ColorGreen";};
				default{_side = -1;};
			};
			AW_marker_base_array set [_setAt,_baseName];
			AW_marker_side_array set [_setAt,_side];
			_setAt = _setAt + 1;
		};
	};
};

//----- PV the side-array to all clients
publicVariable "AW_marker_side_array";

