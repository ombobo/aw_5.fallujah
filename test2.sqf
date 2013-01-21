/*
if (isServer) then{
	[] spawn {
		while {true} do{
			AW_PV_CVTestPos = getPosASL west_cv;
			PublicVariable "AW_PV_CVTestPos";
			sleep 0.1;
		};
	};
};

if (!isServer) then{
	
	helperSphere = "Sign_sphere25cm_EP1" createVehicleLocal [0,0,0];
	
	"AW_PV_CVTestPos" addPublicVariableEventhandler {
		helperSphere setPosASL [AW_PV_CVTestPos select 0,AW_PV_CVTestPos select 1,(AW_PV_CVTestPos select 2) + 2];
		//player sidechat format["vclpos: %1",AW_PV_CVTestPos];
		//player sidechat format["sphere: %1",getPosASL helperSphere];
	};
};
*/

/*
sleep 0.1;

_IDs = [372420,372389,372439,372477,372478,372479,372481,961632,979081,372480,372425,961631,372570];

//diag_log ((position player) nearObjects 50);
//diag_log (getPos player nearestObject 372389);

{
	_obj = (markerPos "marker_removeTrees_1" nearestObject _x);
	//hideObject _obj;
	_obj setDamage 1;
	//diag_log position _obj;
	//_obj setPos [(getPos _obj) select 0,(getPos _obj) select 1,((getPos _obj) select 2) + 10];
}forEach _IDs;
*/
/*
_i = 0;
{
	_i = _i + 1;
	_type = typeOf (call compile _x);
	diag_log format["%1: %2",_i,_type];
	if !(_type isKindOf "SoldierWB") then{diag_log "ERROR: unit is not a soldier class"};
}forEach AW_westUnit1_Cfg + AW_westUnit2_Cfg + AW_westUnit3_Cfg + AW_westUnit4_Cfg;

_i = 0;
{
	_i = _i + 1;
	_type = typeOf (call compile _x);
	diag_log format["%1: %2",_i,_type];
	if !(_type isKindOf "SoldierWB") then{diag_log "ERROR: unit is not a soldier class"};
}forEach AW_eastUnit1_Cfg + AW_eastUnit2_Cfg + AW_eastUnit3_Cfg + AW_eastUnit4_Cfg;

_i = 0;
{
	_i = _i + 1;
	_type = typeOf (call compile _x);
	diag_log format["%1: %2",_i,_type];
}forEach AW_refereeSlots_Cfg;
*/