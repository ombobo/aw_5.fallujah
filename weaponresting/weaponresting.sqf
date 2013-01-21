/*
Weapon resting script by Conroy

script v1.0

If you want to see debug information you can change the _debug value below from false to true

/////////////
// LICENSE //
/////////////

Copyright (c) 2012 Conroy

Permission is hereby granted, free of charge, to any person obtaining a copy of the script below, to deal in the Software without restriction, 
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF 
OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

if (isDedicated) exitWith{};

private[
	"_eyePos",
	"_weaponLenght",
	"_pX",
	"_pY",
	"_pZ",
	"_cX",
	"_cY",
	"_cZ",
	"_oldPrimWeapon",
	"_weaponGroup_1",
	"_weaponGroup_2",
	"_weaponGroup_3",
	"_recoilForGroup_1",
	"_recoilForGroup_2",
	"_recoilForGroup_3",
	"_recoilForGroup_rest",
	"_weaponRecoil",
	"_weaponGroupsAllowed",
	"_weaponGroupsAllowedCheckValue",
	"_checkWeaponGroup",
	"_suitableWeapon",
	"_primWeapon",
	"_currentWeapon",
	"_weaponVec",
	"_weaponHDir",
	"_weaponVDir",
	"_helper1",
	"_clearLine",
	"_canRest",
	"_stanceLong",
	"_stanceShort",
	"_getStringPart",
	"_debug"];

_getStringPart ={
	private["_string","_result"];
	_string = _this select 0;
	_result = [];
	for "_i" from (_this select 1) to (_this select 2) do {_result = _result + [_string select _i];};
	toString _result
};

_checkWeaponGroup = {
	private ["_weaponGroup","_newRecoil"];
	
	_weaponGroup = [];
	_newRecoil = 1;
	_weaponRecoil = 1;
	
	switch (_this select 0)do{
		case (8):{_weaponGroup = _weaponGroup_3;_newRecoil = _recoilForGroup_3;};
		case (4):{_weaponGroup = _weaponGroup_2;_newRecoil = _recoilForGroup_2;};
		case (2):{_weaponGroup = _weaponGroup_1;_newRecoil = _recoilForGroup_1;};
		case (1):{_suitableWeapon = true;_weaponRecoil = _recoilForGroup_rest;};
		default {};
	};
	
	{
		if (_primWeapon == _x) then{
			_suitableWeapon = true;
			_weaponRecoil = _newRecoil;
			if (_debug) then {
				player sidechat format["#DEBUG: _primWeapon matches = %1, newRecoil = %2",_primWeapon,_weaponRecoil];
			};
		};
	}forEach _weaponGroup;
	
	_weaponGroupsAllowedCheckValue = _weaponGroupsAllowedCheckValue - (_this select 0);
};

//snipers
_weaponGroup_1 = [
	"M240","Mk_48","Mk_48_DES_EP1","BAF_L7A2_GPMG","m240_scoped_EP1",
	"M249","M249_EP1","M249_TWS_EP1","M249_m145_EP1",
	"PK","Pecheneg",
	"MG36","MG36_camo",
	"RPK_74",
	"m8_SAW",
	"BAF_L110A1_Aim",
	"M60A4_EP1",
	"AW_M60A4_EP1","AW_M249_EP1","AW_PK","AW_MG36"];
//MGs
_weaponGroup_2 = [
	"M24","M40A3","M24_des_EP1",
	"SVD","SVD_CAMO","SVD_des_EP1","SVD_NSPU_EP1",
	"DMR",
	"ksvk",
	"m107","m107_TWS_EP1",
	"BAF_AS50_scoped","BAF_AS50_TWS","PMC_AS50_TWS","PMC_AS50_scoped",
	"BAF_LRR_scoped","BAF_LRR_scoped_W",
	"M110_TWS_EP1","M110_NVG_EP1",
	"AW_M110_NVG_EP1"];
//custom weapons
_weaponGroup_3 = [];

_recoilForGroup_1 = 0.2; //MGs (base is 1)
_recoilForGroup_2 = 0.2; //Snipers
_recoilForGroup_3 = 0.4; //custom group
_recoilForGroup_rest = 0.4; //all others like normal m16 rifles for example
_newRecoil = 1;
_weaponRecoil = _newRecoil;

_debug = false; //set this to true if you want to see debug info in the game
_weaponGroupsAllowed = 7; //1 = rifles and others, 2 = MGs, 4 = Snipers, 8 = custom group (add the ones you want together... for example '6' would be snipers + MG, 15 = everything)
_weaponGroupsAllowedCheckValue = _weaponGroupsAllowed;
_suitableWeapon = false;

//the helper sphere is used to visualize the line checking for a suitable resting position
if (_debug) then {
	_helper1 = "Sign_sphere25cm_EP1" createVehicleLocal eyePos player;
};

_oldPrimWeapon = ""; //setting no weapon as starting primary weapon to be able to compare it properly

sleep 0.5;

while {true} do {
	if (player == vehicle player && alive player) then{
		_eyePos = eyePos player;
		_primWeapon = primaryWeapon player;
		_currentWeapon = currentWeapon player;
		_weaponVec = player weaponDirection _primWeapon;
		_weaponLenght = 0.75; //distance from player in meters to check for resting position (edit this if you want) (might be changed to be different for vertain weapons)
		_clearLine = 0;
		_canRest = 0;
		
		if (_oldPrimWeapon != _primWeapon) then{
			_oldPrimWeapon = _primWeapon;
			_suitableWeapon = false;
			_weaponGroupsAllowedCheckValue = _weaponGroupsAllowed;
			//while {_weaponGroupsAllowedCheckValue > 0 && !(_suitableWeapon)} do{
			while {_weaponGroupsAllowedCheckValue > 0 && !(_suitableWeapon)} do{
				switch (true)do{
					case (_weaponGroupsAllowedCheckValue >= 8):{[8] call _checkWeaponGroup;};
					case (_weaponGroupsAllowedCheckValue >= 4):{[4] call _checkWeaponGroup;};
					case (_weaponGroupsAllowedCheckValue >= 2):{[2] call _checkWeaponGroup;};
					case (_weaponGroupsAllowedCheckValue >= 1):{[1] call _checkWeaponGroup;};
					default {};
				};
			};

			if (_debug) then {
				player sidechat format["#DEBUG: _suitable = %1, recoil = %2, _primWeapon = %3",_suitableWeapon,_weaponRecoil,_primWeapon];
			};
			//player sidechat format["recoil2: %1",_weaponRecoil];
		};
		
		//only go through all this if the primary rifle is actually equipped and not some other sidearm or launcher
		if (_primWeapon == _currentWeapon) then {
			_pX = _eyePos select 0; //player Positions - (start of the line)
			_pY = _eyePos select 1;
			_pZ = _eyePos select 2;
			
			_cX = _pX;///check Positions - position in front of the player (end of the line)
			_cY = _pY;
			_cZ = _pZ;
			
			//horizontal
			_weaponHDir = (_weaponVec select 0) atan2 (_weaponVec select 1);
			if (_weaponHDir < 0) then {_weaponHDir + 360};
			//vertical
			_weaponVDir = (sqrt((_weaponVec select 0)^2 + (_weaponVec select 1)^2));// call simplifyAngle;
			_weaponVDir = (_weaponVec select 2) atan2 _weaponVDir;
			
			//far end of the line being checked
			_cX = (_pX + (_weaponLenght * (cos ((_weaponHDir - 90) * (-1)))));
			_cY = (_pY + (_weaponLenght * (sin ((_weaponHDir - 90) * (-1)))));
			_cZ = (_pZ + (_weaponLenght * (sin ((_weaponVDir) * (1)))));
			
			for "_i" from 1 to 12 do {
				//lineIntersects is false then the line is clear
				if !(lineIntersects [[_pX,_pY,_pZ], [_cX,_cY,_cZ], player]) then{
					_clearLine = 1;
				}else{
					if (_clearLine == 1) then {_canRest = 1};
				};
				
				//lower height of the lines start and end by a certain amount for the next check (default 5 cm)
				_pZ = _pZ - 0.05;
				_cZ = _cZ - 0.05;
				
				if (_debug) then {
					_helper1 setPosASL [_cX,_cY,_cZ];
				};
				
				sleep 0.001;
			};
			
			if (_canRest == 1) then {
				//check if player is standing or kneeling
				_stanceLong = animationState player; //get the players current animation
				_stanceShort = [toArray _stanceLong,5,7] call _getStringPart; //get the part of the animation that tells us, whether the player is standing or kneeling
				
				if (_stanceShort in ["knl", "erc"]) then {
					player setUnitRecoilCoefficient _weaponRecoil; //suitable resting position detected
					cutRsc ["AW_RestingIcon","PLAIN",0];
				};
			}else{
				player setUnitRecoilCoefficient 1; //no resting position detected
			};
		} else {
			player setUnitRecoilCoefficient 1; //secondary weapon equipped
		};
	};
/*
	if (_debug) then {
		player sidechat format["#DEBUG: canRest: %1, recoilcoeff: %2",_canRest,unitRecoilCoefficient player];
	};
*/
	
	//check only once a second for a resting position
	sleep 1;
};