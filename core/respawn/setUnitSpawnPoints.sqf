/*
* Created By Jones
* last updated 1/16/2012
*/
//client or local host only
if (isMultiPlayer && isServer) exitWith{};
Private["_setSpawnPoint","_findPlayersUnit"];
/*
* Name: _setSpawnPoint
* Desc: Assignes unit spawn point if unit is in the _unitArray
* Params: [Array of units, SpawnMarkerName]
* Returns: NA
*/

sleep 1;

_setSpawnPoint ={
	private["_unitArray","_spawnMarker"];
	_unitArray = _this select 0;
	_spawnMarker = _this select 1;
	{
		_unit = call compile _x; 					
		if(player == _unit)then{
			AW_PlayerSpawnPoint = _spawnMarker;
			//player sidechat format["spawnpos is: %1",getMarkerPos AW_PlayerSpawnPoint];
		};
		//player sidechat format["testing: %1",_unit];
	}forEach _unitArray;
	//diag_log _unitArray;
};

switch (playerside) do{
	case west:{
		[AW_westUnit1_Cfg,"west_SpawnMarker1"]call _setSpawnPoint;
		[AW_westUnit2_Cfg,"west_SpawnMarker2"]call _setSpawnPoint;
		[AW_westUnit3_Cfg,"west_SpawnMarker3"]call _setSpawnPoint;
		[AW_westUnit4_Cfg,"west_SpawnMarker4"]call _setSpawnPoint;
	};
	case east:{
		[AW_eastUnit1_Cfg,"east_SpawnMarker1"]call _setSpawnPoint;
		[AW_eastUnit2_Cfg,"east_SpawnMarker1"]call _setSpawnPoint;
		[AW_eastUnit3_Cfg,"east_SpawnMarker1"]call _setSpawnPoint;
		[AW_eastUnit4_Cfg,"east_SpawnMarker1"]call _setSpawnPoint;
	};	
	case resistance:{
		AW_PlayerSpawnPoint = "respawn_guerrila";
	};
};
