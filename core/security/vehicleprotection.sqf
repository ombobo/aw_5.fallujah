private["_unit","_vehicle"];

fnc_RenewMPKilledEventhandler = compile preprocessFileLineNumbers "core\security\eh_mpkilled.sqf";

if (isServer) then{
	{
		_unit = _x select 0;
		_vehicle = call compile _unit;
		
		diag_log format["setting mpkilled EH for vcl %1",_vehicle];
		All_MPKilled_EH = [_vehicle]call fnc_RenewMPKilledEventhandler;
	}forEach AW_westVehicleArray_Cfg+AW_eastVehicleArray_Cfg;
};