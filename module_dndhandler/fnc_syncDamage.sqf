private["_syncThis","_synced","_lastHit","_vehicle","_fnc_syncToServer"];

AW_DH_localVehicles = [];

_fnc_syncToServer = {
	private["_syncDelay"];
};

while{true} do{
	//diag_log AW_DH_localVehicles;
	{
		_synced = _x getVariable ["AW_DH_synced",true];
		_lastHit = _x getVariable ["AW_DH_lastHit",diag_tickTime];
		
		//diag_log format["%1 %2",_synced,_lastHit];
		
		if (isNull _x || !alive _x) then{
			//player sidechat "#DEBUG: Vehicle is null or not alive. Removing from Array";
			AW_DH_localVehicles = AW_DH_localVehicles - [_x];
			_synced = true;
		};
		
		if (!_synced && alive _x) then{
			_syncThis = false;
			
			switch(true)do{
				case !(local _x):{
					//player sidechat "#DEBUG: Syncing NOW (vehicle became local to someone else)";
					AW_DH_localVehicles = AW_DH_localVehicles - [_x];
					_syncThis = true;
				};
				case (diag_tickTime > _lastHit + 2):{
					//player sidechat "#DEBUG: Syncing NOW (2 seconds passed since the damage event)";
					_syncThis = true;
				};
				case (!alive player):{
					//player sidechat "#DEBUG: Syncing NOW (player died)";
					_syncThis = true;
				};
				default {};
			};
			
			if (_syncThis) then{
				_gethit = _x getVariable ["gethit",[]];
				AW_DH_relayGetHitArray = [_x,_gethit,player];
				publicVariableServer "AW_DH_relayGetHitArray";
				
				_x setVariable ["AW_DH_synced", true, false];
			};
		};
		sleep 0.1;
	}forEach AW_DH_localVehicles;
	sleep 0.1;
};
