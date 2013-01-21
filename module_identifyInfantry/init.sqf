/*
#define __DEBUG true

#define __REFRESH 0.34
#define __DISTANCE 50

#define __SIZE size='0.25'
#define __FONT font='Zeppelin33'
#define __SHADOW shadow='2'
#define __FriendlyColorValue #ff0000
#define __FriendlyColor color=__FriendlyColorValue

diag_log __FriendlyColorValue;

#define __STRUCT <t __SIZE __FONT __SHADOW __FriendlyColor>
#define __STRUCTSTRING #__STRUCT

while{true}do{
	#ifdef __DEBUG
		_initTime = diag_tickTime;
		_frameNo = diag_frameNo;
	#endif
	
	_target = cursorTarget;
	if (_target isKindOf "Man" && player == vehicle player) then{
		if((side _target == playerSide || playerside == resistance) && (player distance _target) < __DISTANCE)then{
			//_nameString = __STRUCTSTRING + format['%1',_target getVariable ['unitname', name _target]] + "</t>";
			//_nameString = "<t size='0.5' shadow='2' color='#ffffffff'>" + format['%1',_target getVariable ['unitname', name _target]] + "</t>";
			_nameString = "<t size='0.5' shadow='2' color='#ffffffff'>" + (name _target) + "</t>";
			[_nameString,0,0.8,__REFRESH,0,0,3] spawn bis_fnc_dynamicText;
		};
	};
	#ifdef __DEBUG
		player sidechat format["time: %1, frames: %2",_initTime - diag_tickTime,_frameNo - diag_frameNo];
	#endif
	sleep __REFRESH;
};
*/

//#define __DEBUG true

#define __REFRESH 0.34
#define __DISTANCE 50


while{true}do{
	#ifdef __DEBUG
		_initTime = diag_tickTime;
		_frameNo = diag_frameNo;
	#endif
	
	_target = cursorTarget;
	if (_target isKindOf "Man" && player == vehicle player) then{
		if((side _target == playerSide || playerside == resistance) && (player distance _target) < __DISTANCE)then{
			_nameString = "<t size='0.5' shadow='2' color='#ffffffff'>" + format['%1',_target getVariable ['unitname', name _target]] + "</t>";
			[_nameString,0,0.8,__REFRESH,0,0,3] spawn bis_fnc_dynamicText;
		};
	};
	#ifdef __DEBUG
		player sidechat format["time: %1, frames: %2",_initTime - diag_tickTime,_frameNo - diag_frameNo];
	#endif
	sleep __REFRESH;
};