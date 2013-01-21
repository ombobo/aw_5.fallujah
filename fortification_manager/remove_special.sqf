private["_passedArray","_objToBeRemoved","_objSideValue","_playerFaction"];

//_passedArray = _this select 3;



//AW_KillFortificationDeconstr = true;
_validObjects = ["Fort_RazorWire","HeliH","PARACHUTE_TARGET","Land_CamoNetVar_NATO","Land_CamoNet_NATO","Land_CamoNetVar_NATO_EP1","Land_CamoNetVar_EAST","Land_CamoNet_EAST","Land_CamoNetVar_EAST_EP1"];
	
{
	
	_objToBeRemoved = _x;
	if (typeOf _objToBeRemoved in _validObjects) then{
		_objSideValue = _objToBeRemoved getvariable ["sideValue",-1];

		//player sidechat format["#Debug: obj: %1, sidevalue: %2",_objToBeRemoved,_objSideValue];

		switch (faction player)do{
			case ("AW_BLU"):{_playerFaction = 0;};
			case ("AW_RED"):{_playerFaction = 1;};
			default {};
		};

		if (_objSideValue == _playerFaction) then{
			_objToBeRemoved setPos [0,0,0];
			_objToBeRemoved setDamage 1;
		};
		//player sidechat format["valid %1",_objToBeRemoved];
	}else{
		//player sidechat format["not valid %1",_objToBeRemoved];
	};
}forEach ((position player) nearObjects 5);