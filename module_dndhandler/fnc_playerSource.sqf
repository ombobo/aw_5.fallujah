_unit = _this select 0;

player sidechat "hua";

_source = "#particlesource" createVehicleLocal (getPosATL _unit);
_source attachto [_unit,[0,0,0]];

_source setdropinterval 0.02;
_source setParticleParams [
	["\Ca\Data\ParticleEffects\pstone\pstone", 1, 0, 1, 0],
	"", //animation Name (obsolete)
	"Billboard", //type
	1, //timer (period to call the onTimer event)
	5, //lifetime
	"", //pos
	[0, 0, 0], //move velocity
	2, //rotation velocity
	1, //weight
	0.8, //volume
	0, //rubbing
	[0.2, 0.2], //Size
	[
		[1,1,1,1],
		[1,1,1,1]
	],  //Color
	[1, 1], //AnimationPhase
	0, //RandomDirectionPeriod
	0, //RandomDirectionIntensity
	"", //onTimer
	"", //onDestruction
	_unit //object
];
_source setParticleRandom [
	0, //lifetime
	[3, 3, 0], //pos
	[0, 0, 0], //move velocity
	0, //rotation velocity
	0, //size
	[0, 0, 0, 0], //color
	0, //random direction period
	0 //random direction intensity
];
//_source setParticleCircle [5, [0,0,0]]