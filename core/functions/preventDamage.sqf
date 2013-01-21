_unit = _this select 0;

//player sidechat format["###DEBUG: disabling damage for player %1",_unit];
_unit allowDamage false;		
sleep 5;
//player sidechat format["###DEBUG: enabling damage for player %1",_unit];
_unit allowDamage true;