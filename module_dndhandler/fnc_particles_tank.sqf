/*
Based on the burn.sqf script by Bohemia.

How to use
[unit,intensity] spawn AW_script_createDestructionEffect
*/



#define __enableSmoke true
#define __enableFire true

_unit = _this select 0;
_intensity = _this select 1;

_beginTime = diag_tickTime;

private["_soundSource","_fireSource","_smokeSource"];

//player moveInCargo _unit;

_fireSource = "#particlesource" createVehicleLocal (getPosATL _unit);
_fireSource attachto [_unit,[0,0,1],"destructionEffect2"];

_smokeSource = "#particlesource" createVehicleLocal getPosATL _unit;
_smokeSource attachto [_unit,[0,0,0],"destructionEffect1"];

_lightpoint = "#lightpoint" createVehicleLocal (getPosATL _unit);

//----- Light
_lightpoint setLightBrightness (_intensity / 30);
_lightpoint setLightAmbient[0.8, 0.6, 0.2];
_lightpoint setLightColor[1, 0.5, 0.4];
_lightpoint lightAttachObject [_unit, [0,0,0]];

//----- Particles in flight

//if ((getPosATL _unit select 2) > 15 && alive _unit) then{
while {(getPosATL _unit select 2) > 15 && alive _unit} do{

	//----- Fire
	if ((random 1) > 0) then{
		_fireSource setdropinterval 0.03;
		_fireSource setParticleParams [
			["\Ca\Data\ParticleEffects\Universal\Universal", 16, 10, 32],
			"", //animation Name (obsolete)
			"Billboard", //type
			1, //timer (period to call the onTimer event)
			0.4, //lifetime
			"destructionEffect2", //pos
			[0, 0, 0.1], //move velocity
			0, //rotation velocity
			10, //weight
			7.9, //volume
			1, //rubbing
			[2, 3], //Size
			[
				[1,1,1,0.0],
				[1,1,1,0.6],
				[1,1,1,0.6],
				[1,1,1,0.6],
				[1,1,1,0.4],
				[1,1,1,0.0]
			],  //Color
			[0.9, 0.3], //AnimationPhase
			0, //RandomDirectionPeriod
			0, //RandomDirectionIntensity
			"", //onTimer
			"", //onDestruction
			_unit //object
		];
		_fireSource setParticleRandom [
			0, //lifetime
			[0.2, 0.2, 0.2], //pos
			[1, 1, 1], //move velocity
			0, //rotation velocity
			0, //size
			[0, 0, 0, 0], //color
			0, //random direction period
			0 //random direction intensity
		];
	};

	//----- Smoke
	
	_smokeSource setDropInterval 0.015;
	_smokeSource setParticleParams [
		["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48],
		"",
		"Billboard",
		1, //time onEvent
		2, //lifetime 
		"destructionEffect1", //pos
		[(velocity _unit select 0) / 1.5, (velocity _unit select 1) / 1.5, (velocity _unit select 2) / 1.5], //move veloc
		0, //rotation veloc
		0.04, //weight
		0.04, //volume
		1, //rubbing
		[1, 10], //size
		[
			[0.3, 0.3, 0.3, 0.9],
			[0.6, 0.6, 0.6, 0.6],
			[0.9, 0.9, 0.9, 0.3],
			[1, 1, 1, 0.0]
		], //color
		[1,0.1], //animPhase
		2, //random dir period
		0, //random dir intensity
		"", //onTime
		"", //onDestruction
		_unit //object
	];
	_smokeSource setParticleRandom [
		1, //lifetime
		[0.5,0.5,0.5], //pos
		[4, 4, 2], //vel
		1, //rot vel
		0, //size
		[0, 0, 0, 0], //color
		0,
		0
	];
	sleep 0.5;
};

//----- Particles on ground GROUNDDDDDDDDDDDDDDDDDDDDDDDDDDDDD

while {_intensity > 5 && alive _unit} do{
	
	//----- Fire
	_fireSource setdropinterval (5 / (_intensity * 2));
	_fireSource setParticleParams [
		["\Ca\Data\ParticleEffects\Universal\Universal", 16, 10, 32],
		"", //animation Name (obsolete)
		"Billboard", //type
		1, //timer (period to call the onTimer event)
		_intensity / 2, //lifetime
		"destructionEffect2", //pos
		[0, 0, 0], //move velocity
		0, //rotation velocity
		10, //weight
		7.9, //volume
		1, //rubbing
		[0.5, (_intensity / 2) - 2], //Size
		[
			[1,1,1,0.0],
			[1,1,1,0.5],
			[1,1,1,0.5],
			[1,1,1,0.5],
			[1,1,1,0.5],
			[1,1,1,0.0]
		],  //Color
		[1, 1], //AnimationPhase
		0, //RandomDirectionPeriod
		0, //RandomDirectionIntensity
		"", //onTimer
		"", //onDestruction
		_unit //object
	];
	_fireSource setParticleRandom [
		0, //lifetime
		[0.1, 0.1, 0], //pos
		[0.1, 0.1, 0], //move velocity
		0, //rotation velocity
		0, //size
		[0.1, 0.1, 0.1, 0.1], //color
		0, //random direction period
		0 //random direction intensity
	];
	
	//----- Smoke
	_smokeSource setDropInterval (0.1);
	_smokeSource setParticleParams [
		["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48],
		"",
		"Billboard",
		1, //time onEvent
		16, //lifetime 
		"destructionEffect1", //pos
		[0, 0, 0.5], //move veloc
		0, //rotation veloc
		1.1, //weight
		0.98, //volume
		0.01, //rubbing
		[1, 25], //size
		[
			[0.2, 0.2, 0.2, 0.2],
			[0.2, 0.2, 0.2, 0.6],
			[0.3, 0.3, 0.3, 0.6],
			[0.4, 0.4, 0.4, 0.4],
			[0.4, 0.4, 0.4, 0.4],
			[0.4, 0.4, 0.4, 0.4],
			[0.4, 0.4, 0.4, 0.0]
		], //color
		[0.6,0], //animPhase
		0, //random dir period
		0, //random dir intensity
		"", //onTime
		"", //onDestruction
		_unit //object
	];
	_smokeSource setParticleRandom [
		1, //lifetime
		[0.5,0.5,0], //pos
		[0.6, 0.6, 0], //vel
		0, //rot vel
		0, //size
		[0.1, 0.1, 0.1, 0.0], //color
		0,
		0
	];
	
	//----- Fade
	
	_intensity = _intensity - 0.05;
	sleep 1;
};

deletevehicle _fireSource;
/*
while{_intensity > 1 && alive _unit} do{

	//----- Smoke
	_smokeSource setDropInterval (0.4);
	_smokeSource setParticleParams [
		["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48],
		"",
		"Billboard",
		1, //time onEvent
		25, //lifetime 
		"destructionEffect1", //pos
		[0, 0, 0], //move veloc
		0, //rotation veloc
		0.04, //weight
		0.04, //volume
		0.5, //rubbing
		[2, 20], //size
		[
			[0.1, 0.1, 0.1, 0.5],
			[0.1, 0.1, 0.1, 0.2],
			[0.1, 0.1, 0.1, 0.1],
			[0.1, 0.1, 0.1, 0.0]
		], //color
		[1,0.1], //animPhase
		2, //random dir period
		1, //random dir intensity
		"", //onTime
		"", //onDestruction
		_unit //object
	];
	_smokeSource setParticleRandom [
		4, //lifetime
		[0.5,0.5,0], //pos
		[1, 1, 0], //vel
		0, //rot vel
		0, //size
		[0.1, 0.1, 0.1, 0.1], //color
		0,
		0
	];
	
	//----- Fade
	
	_intensity = _intensity - 0.02;
	sleep 1;
};

while{alive _unit} do{
	sleep 0.5;
};

deletevehicle _soundSource;

deletevehicle _smokeSource;
deletevehicle _lightpoint;