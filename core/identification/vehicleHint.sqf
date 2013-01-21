/*
* Created By Jones
* last updated 1/16/2012
*/
private ["_getWeaponTangent","_getWeaponElevation",
		"_degreeToMills","_unitNameToStructuredText",
		"_crewListToString"
		];
disableSerialization;
/* 
*  Params: weapon 
* Returns tangent of weapon
*/
_getWeaponTangent ={
	private["_weapon","_tangent"];
	_weapon = _this select 0;
	_tangent = ((vehicle Player weaponDirection _weapon)select 0)atan2(((vehicle Player weaponDirection _weapon))select 1); 
	if ( _tangent < 0 ) then{_tangent = _tangent + 360;};
	_tangent =[_tangent]call _degreeToMills;
	_tangent
};
/* 
*  Params: weapon 
* Returns elevation of weapon
*/
_getWeaponElevation ={
	private["_weapon","_elevation"];
	_weapon = _this select 0;
	_elevation = asin(( vehicle Player weaponDirection _weapon)select 2 )-asin( vectorDir vehicle Player select 2);      
	_elevation =[_elevation]call _degreeToMills ;
	_elevation
};
/* Converts degress to mils
* Params: degree
* Returns int, 
*/
_degreeToMills ={
	private["_degree","_mils"];
	_degree = _this select 0;	
	_mils =  _degree * 17.777777777777777777777777777778; 
	_mils = _mils - (_mils mod 1); 
	_mils
};

/* Converts players name to strucrtured text
*   based on position in vehicles
* Parms: unit,
* Returns: String,
*/
_unitNameToStructuredText ={
	private["_unit","_text","_vehicle"];
	_unit = _this select 0;
	_vehicle = vehicle player;
	
	_text = switch true do{
		case(_unit == driver _vehicle):{
			"<br/>"+"<img image='core\resources\i_driver.paa' align='left'/>"+(name _unit);
		};
		case(_unit == commander _vehicle):{
			"<br/>"+"<img image='core\resources\i_commander.paa' align='left'/>"+(name _unit);
		};
		case(_unit == gunner _vehicle):{
			"<br/>"+"<img image='core\resources\i_gunner.paa' align='left'/>"+(name _unit);
		};
		default{
			"<br/>"+(name _unit);
		};
	};
	_text
};
/*  Converts the crew of a vehicle in to a string of structured text
*  Params: NA
* Returns : String, structured text
*/
_crewListToString ={
	private["_string","_vehicleCrew","_result","_damage"];
	_vehicleCrew = crew vehicle player;
	
	_string = "<t color='#ffffffff' size='1.2' shadow='1' shadowColor='#000000' align='center'>Status: </t>";
	/*
	_damage = vehicle player getVariable "vcldam";
	switch(true)do{
		case (_damage <= 0.02):{_string = _string + "<t color='#FF41A317' size='1.2' shadow='1' shadowColor='#000000' align='center'>Fully Intact</t><br/>"}; //Lime Green
		case (_damage < 0.17):{_string = _string + "<t color='#FF41A317' size='1.2' shadow='1' shadowColor='#000000' align='center'>Good</t><br/>"}; //Lime Green
		case (_damage < 0.34):{_string = _string + "<t color='#FFA0C544' size='1.2' shadow='1' shadowColor='#000000' align='center'>Light Damage</t><br/>"}; //Dark Olive Green3
		case (_damage < 0.51):{_string = _string + "<t color='#FFD4A017' size='1.2' shadow='1' shadowColor='#000000' align='center'>Damaged</t><br/>"}; //Gold
		case (_damage < 0.68):{_string = _string + "<t color='#FFE56717' size='1.2' shadow='1' shadowColor='#000000' align='center'>Heavily Damaged</t><br/>"}; //Dark Orange 2
		case (_damage < 0.85):{_string = _string + "<t color='#FFC11B17' size='1.2' shadow='1' shadowColor='#000000' align='center'>Major Damage !!</t><br/>"}; //Firebrick 3
		case (_damage < 1.00):{_string = _string + "<t color='#FFC11B17' size='1.2' shadow='1' shadowColor='#000000' align='center'>Hull about to fail !!!</t><br/>"}; //Firebrick 3
		default {};
	};
	_string = _string + "<t color='#ffffff00' size='1.2' shadow='1' shadowColor='#000000' align='center'>Crew</t><br/>";
	*/	 
	{
		private["_unitName"];
		_unitName = [_x]call _unitNameToStructuredText;
		_string = _string + _unitName;
	}forEach _vehicleCrew;
	_result = parseText _string;
	_result
};
////////////////////////////////////
//RUN SCRIPT
////////////////////////////////////
while{true} do{
	_vehicle = vehicle player;
	if(_vehicle != player)then{
		if(typeOf _vehicle in AW_TandEHint_Cfg)then{
			_vehicleWeapons = Weapons vehicle player;
			_weapon = _vehicleWeapons select 0;
			_tangent = [_weapon]call _getWeaponTangent;
			_elevation = [_weapon]call _getWeaponElevation;
			hintSilent format ["Tangent: %1 Mils\nElevation: %2 Mils",_tangent,_elevation];		
		}else{	
			_crewString = []call _crewListToString;
			hintSilent _crewString;
		};
	};
sleep 0.2;	
};	
