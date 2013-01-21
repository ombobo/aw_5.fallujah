private["_passedArray","_objToBeRemoved","_objSideValue","_playerFaction"];

//_passedArray = _this select 3;

_objToBeRemoved = cursorTarget;

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

//AW_KillFortificationDeconstr = true;