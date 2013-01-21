/*
* Created By Jones
* last updated 1/16/2012
*/
if (isMultiPlayer && isServer) exitWith{};
private["_distance","_isTrespassing","_restrictedAreaArray","_restrictedArea"];

_restrictedAreaArray =[];
_isTrespassing = false;

///assigns the restricted areas according to sides
switch (playerside) do{ 
	case west:{	
		_restrictedAreaArray = AW_eastBases_Cfg;
		};
	case east:{	
		_restrictedAreaArray = AW_westBases_Cfg;
	};		
};


///main loop, 
while{AW_isGameRunning}do{
	{
		_protectionMarker = _x;
		_restrictedArea = getMarkerPos _protectionMarker;
		_restrictedAreaRadius = getMarkerSize _protectionMarker;
		_restrictedAreaRadius = _restrictedAreaRadius select 0;
		_distance = player distance _restrictedArea;
		
		//checks players distance from base and determines if the player is trespassing
		if (_distance < _restrictedAreaRadius)then{
			_isTrespassing = true;
			taskhint ["Restricted Area", [1, 0, 0, 1], "taskFailed"];
			player globalchat "Warning you are in a restricted area. Leave or you will be killed";
		}else{
			_isTrespassing = false;		
		};
		sleep 1;
		//second check, if they are still in the zone player is killed
		_distance = player distance _restrictedArea;
		if ((_distance < _restrictedAreaRadius)&&(_isTrespassing))then{
			if(vehicle player != player)then{
				vehicle player setdamage 1;
			}else{
				player setdamage 1;
			};		
		};
	}forEach _restrictedAreaArray;
};