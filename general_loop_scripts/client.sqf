private["_AW_Loop_checkAndChangePlayerTurnedOutValue","_AW_ResetPlayerGetHitArray","_AW_ShowDamhandlerDebug","_AW_CheckPlayerWeapon"];

//--- 1

_AW_Loop_checkAndChangePlayerTurnedOutValue = {
	private ["_checkOutAnim"];

	_checkOutAnim = {
		private["_unit", "_anim", "_count", "_out", "_ret"];
		//PARAMS_1(_unit);
		_unit = player;
		_anim = toArray(toLower(animationState _unit));
		_count = (count _anim)-1;
		_out = toString([_anim select (_count-2),_anim select (_count-1),_anim select _count]);
		if(_out == "ep1") then {
			_out = toString([_anim select (_count-6),_anim select (_count-5),_anim select (_count-4)]);
		};
		if (_out == "out") then { _ret = true; } else { _ret = false; };
		//player sidechat format["#DEBUG: out return value: %1",_ret];
		_ret
	};

	AW_allowPlayerDamage = true;
	AW_isPlayerTurnedOut = false;
	while{true} do{
		//reset value to the default state again, now that the player isnt in a vehicle anymore
		AW_isPlayerTurnedOut = false; //remove after scrim 2
		
		waitUntil{(vehicle player isKindOf "Tank" || vehicle player isKindOf "Wheeled_APC");};
		
		while{vehicle player != player} do{
			if (!alive (vehicle player)) then {player setDamage 1;};
			AW_allowPlayerDamage = [] call _checkOutAnim;
			sleep 1;
		};
		AW_allowPlayerDamage = true;
	};
};

[] spawn _AW_Loop_checkAndChangePlayerTurnedOutValue; //essential
diag_log text "|========== starting client loop 1 (_AW_Loop_checkAndChangePlayerTurnedOutValue)";
sleep 0.2;

//--- 2

_AW_ResetPlayerGetHitArray = {
	while {true} do{
		if (damage player == 0 && (count (player getVariable ["gethit", []])) != 0) then {
			player setVariable ["selections", [], false];
			player setVariable ["gethit", [], false];
			//player sidechat "#DEBUG: resetting players getHit array";
		};
		//player sidechat format["getHit player: %1 , %2",player getVariable "gethit",count (player getVariable "gethit")];
		sleep 1;
	};
};

[] spawn _AW_ResetPlayerGetHitArray; //essential
diag_log text "|========== starting client loop 2 (_AW_ResetPlayerGetHitArray)";
sleep 0.2;

//--- 3

_AW_ShowDamhandlerDebug = {
	while {true} do{
		//player sidechat format["damage player: %1",damage player];
		player sidechat format["select. player: %1",player getVariable "selections"];
		player sidechat format["getHit player: %1",player getVariable "gethit"];
		sleep 5;
	};
};
//[] spawn _AW_ShowDamhandlerDebug;
//diag_log text "|========== starting loop 3";