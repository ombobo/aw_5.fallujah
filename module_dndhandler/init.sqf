//Damage-handling module
private["_vehicleArray","_unit","_vehicle","_projectile","_area","_damageVar"];

//Reassign eventhandler when the vehicle (re)spawns
fnc_RenewDamageEventhandler = compile preprocessFileLineNumbers "damhandler\fnc_renewdamageeventhandler.sqf"; 

fnc_RenewEHVodnik = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_vodnik.sqf"; 
fnc_RenewEHMHQ = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_m113.sqf";
fnc_RenewEHPlayer = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_player.sqf";
fnc_RenewEHTest = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_test.sqf";
fnc_RenewEHMBT = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_mbt.sqf";
fnc_RenewEHIFV = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_ifv.sqf";
fnc_RenewEHAPC = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_apc.sqf";
fnc_RenewEHC130 = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_c130.sqf";
fnc_RenewEHCV = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_cv.sqf";

fnc_RenewEHMBTTEST = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_mbttest.sqf";
fnc_RenewEHIFVTEST = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_ifvtest.sqf";

fnc_RenewEHHOUSE = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_house.sqf";
fnc_RenewEHFORTIFICATION = compile preprocessFileLineNumbers "damhandler\eventhandlers\eh_fortification.sqf";

fnc_checkEH = compile preprocessFileLineNumbers "damhandler\fnc_checkEH.sqf";
fnc_syncdamagetoserver = compile preprocessFileLineNumbers "damhandler\fnc_syncdamagetoserver.sqf";

fnc_resetGetHitArray = compile preprocessFileLineNumbers "damhandler\fnc_resetgethitarray.sqf";

AW_DH_synced = true;

AW_DH_lastHit = 0;
AW_DH_localVehicles = [];


//---------------------------------//
//Combined Part for Server & Client//
//---------------------------------//

//----- Initial setting of the eventhandlers when connecting.

sleep 2;
{
	_unit = _x select 0;
	_vehicle = call compile _unit;
	
	[_vehicle]call fnc_RenewDamageEventhandler;	
} forEach AW_westVehicleArray_Cfg+AW_eastVehicleArray_Cfg+[["west_mbt_test"]]+[["east_mbt_test"]];




/*
BIS_Effects_Burn = compile preprocessFileLineNumbers "\ca\Data\ParticleEffects\SCRIPTS\destruction\burn.sqf";
AW_script_createDestructionEffect = compile preprocessFileLineNumbers "module_dndhandler\fnc_createParticleSources.sqf";
AW_script_createPlayerEffect = compile preprocessFileLineNumbers "module_dndhandler\fnc_playerSource.sqf";

AW_script_TankDestruction = compile preprocessFileLineNumbers "module_dndhandler\fnc_particles_tank.sqf";

//add the eventhandler which triggers where the vehicle is local
{
	_x addeventhandler ["HandleDamage",{
		//to handle actual damage just return '_this select 2'
		//our own handling below. Passed array for the Eventhandler: [unit, selectionName, damage, source, projectile]
		_unit = _this select 0;
		_selection = _this select 1;
		_damage = _this select 2;
		_projectile = _this select 4;
		
		if (_unit getVariable ["allGood",true]) then{
			//if (_projectile == "AW_R_M136_AT") then{
			if (true) then{
				[_unit, 7] spawn AW_script_createDestructionEffect;
				_unit setHit ["mala vrtule", 1];
				_unit setHit ["motor", 1];
				player sidechat "hit";
			};
			_unit setVariable ["allGood",false,true];
			//driver _unit setDamage 1;
		};
		//_damage;	
	}]; //addeventhandler end
}forEach [testchopper_1,testchopper_2];

{
	_x addeventhandler ["HandleDamage",{
		//to handle actual damage just return '_this select 2'
		//our own handling below. Passed array for the Eventhandler: [unit, selectionName, damage, source, projectile]
		_unit = _this select 0;
		_selection = _this select 1;
		_damage = _this select 2;
		_projectile = _this select 4;
		
		if (_unit getVariable ["allGood",true]) then{
			//if (_projectile == "AW_R_M136_AT") then{
			if (true) then{
				[_unit, 7] spawn AW_script_TankDestruction;
				//_unit setHit ["mala vrtule", 1];
				//_unit setHit ["motor", 1];
				player sidechat "hit";
			};
			_unit setVariable ["allGood",false,true];
			//driver _unit setDamage 1;
		};
		//_damage;	
	}]; //addeventhandler end
}forEach [testtank_1,testtank_2];
/*
(vehicle player) addeventhandler ["Fired",{
	[player,5] spawn AW_script_createPlayerEffect;
}]; //addeventhandler end
