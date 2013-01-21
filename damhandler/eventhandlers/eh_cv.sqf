//player sidechat "#DEBUG: CV EH added";

_this select 0 addeventhandler ["Engine",{
	_vehicle = _this select 0;
	_engineState = _this select 1;
	_deployedVar = _vehicle getVariable ["isDeployed", 0];
	
	if (!isServer) then{
		if (player in _vehicle && _deployedVar == 1) then{
			AW_chatLogic globalChat "### CV has been mobilized ###";
		};
	};
	
	if (isServer) then{
		if (_deployedVar == 1) then{
			_vehicle setVariable ["isDeployed", 0, true];
			_vehicle setVariable ["DeployTime", 0, false];
			switch (faction _vehicle) do{
				case("AW_BLU"):{fl_event_mobilizeCV = 0;publicVariable "fl_event_mobilizeCV";};
				case("AW_RED"):{fl_event_mobilizeCV = 1;publicVariable "fl_event_mobilizeCV";};
				default {};
			};
		};
	};
}]; //addeventhandler end

_this select 0 addeventhandler ["Fired",{
	_vehicle = _this select 0;
	_deployedVar = _vehicle getVariable ["isDeployed", 0];
	
	if (!isServer) then{
		if (player in _vehicle && _deployedVar == 1) then{
			AW_chatLogic globalChat "### CV has been mobilized ###";
		};
	};
	
	if (isServer) then{
		if (_deployedVar == 1) then{
			_vehicle setVariable ["isDeployed", 0, true];
			_vehicle setVariable ["DeployTime", 0, false];
			switch (faction _vehicle) do{
				case("AW_BLU"):{fl_event_mobilizeCV = 0;publicVariable "fl_event_mobilizeCV";};
				case("AW_RED"):{fl_event_mobilizeCV = 1;publicVariable "fl_event_mobilizeCV";};
				default {};
			};
		};
		_vehicle setVariable ["fired_tickTime", diag_tickTime, false];
	};
}]; //addeventhandler end