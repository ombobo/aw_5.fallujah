_this select 0 addMPEventHandler ["MPKilled",{
	_unit = _this select 0;
	_vehiclestring = format["%1",_unit];
	_killer = _this select 1;
	_side = "string";
	_safeZones = [];
	
	{
		if ((_x select 0) == _vehiclestring) then {_side = "west";};
	}forEach AW_westVehicleArray_Cfg;
	
	{
		if ((_x select 0) == _vehiclestring) then {_side = "east";};
	}forEach AW_eastVehicleArray_Cfg;
	
	diag_log format["side unit %1",_side];
	
	switch (_side) do{ 
		case "east":{	
			_safeZones = AW_eastBases_Cfg;
			};
		case "west":{	
			_safeZones = AW_westBases_Cfg;
		};
		default{diag_log "side error";};		
	};
	
	diag_log format["safezones: %1,%2",_safeZones select 0,_safeZones select 1];
	
	{
		_protectionMarker = _x;
		_restrictedArea = getMarkerPos _protectionMarker;
		_restrictedAreaRadius = getMarkerSize _protectionMarker;
		_restrictedAreaRadius = _restrictedAreaRadius select 0;
		_distance = _unit distance _restrictedArea;
		
		diag_log format["distance %1",_distance];
		
		//checks players distance from base and determines if the player is trespassing
		if (_distance < _restrictedAreaRadius)then{
			PublicDebugMessage = format["Vehicle %1 was destroyed by %2 inside a safezone",_unit,name _killer];
			PublicVariable "PublicDebugMessage";
			diag_log format["Vehicle %1 was destroyed by %2 inside a safezone",_unit,name _killer];
			if (_side != (side _killer)) then{
				PublicDebugMessage = format["Rule violation by %1",side _killer];
				PublicVariable "PublicDebugMessage";
			};
		};
	}forEach _safeZones;
	diag_log "triggered";
}]; // addeventhandler end

diag_log "set";