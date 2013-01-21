#define __minGroupSize 5

#define __distanceToCV 350
#define __distanceToClusters 250

#define __clusterSearchRadius 150
#define __clusterCombineRadius 100

//player sidechat "calc started";

_AW_bluScoringAssets = [];
_AW_redScoringAssets = [];

//----- If an AO is being initialized at the moment, then wait till it's done, before calculating its territories
if !(scriptDone AW_handle_initializeAO) then{
	waitUntil{scriptDone AW_handle_initializeAO;};
};
_preCalcTimeStart = diag_tickTime;
_preCalcFrameStart = diag_frameno;

//----- Check scoring 'assets' positions and send them to all clients, which will initiate a recalculation on their side as well
if (isServer) then{
	
	if (alive west_cv && west_cv getVariable ["isCVReady",false]) then {
		_AW_bluScoringAssets set[count _AW_bluScoringAssets,getPosATL west_cv];
	};
	if (alive east_cv && east_cv getVariable ["isCVReady",false]) then {
		_AW_redScoringAssets set[count _AW_redScoringAssets,getPosATL east_cv];
	};
	
	_AW_bluClusters = [];
	_AW_compiledAliveAllWest = [];
	_AW_redClusters = [];
	_AW_compiledAliveAllEast = [];
	
	//----- Create an array of compiled unitstrings
	_isWestCValive = alive west_cv;
	_isEastCValive = alive east_cv;
	{
		_unit = call compile _x;
		if (alive _unit && (_unit == vehicle _unit)) then{
			if (_unit distance west_cv > __distanceToCV && _unit distance east_cv > __distanceToCV) then{
				_AW_compiledAliveAllWest set [count _AW_compiledAliveAllWest,_unit];
			};
		};
	}forEach AW_allWest;
	{
		_unit = call compile _x;
		if (alive _unit && (_unit == vehicle _unit)) then{
			if (_unit distance west_cv > __distanceToCV && _unit distance east_cv > __distanceToCV) then{
				_AW_compiledAliveAllEast set [count _AW_compiledAliveAllEast,_unit];
			};
		};
	}forEach AW_allEast;
	
	//----- Create an array of unitclusters
	_newUnitCount = 0;
	{
		_newUnitCount = {_x in _AW_compiledAliveAllWest} count (_x nearEntities ["Man",__clusterSearchRadius]);
		if (_newUnitCount >= __minGroupSize) then{
			_AW_bluClusters set[count _AW_bluClusters,[getPosATL _x,_newUnitCount]];
		};
	}forEach _AW_compiledAliveAllWest;
	{
		_newUnitCount = {_x in _AW_compiledAliveAllEast} count (_x nearEntities ["Man",__clusterSearchRadius]);
		if (_newUnitCount >= __minGroupSize) then{
			_AW_redClusters set[count _AW_redClusters,[getPosATL _x,_newUnitCount]];
		};
	}forEach _AW_compiledAliveAllEast;
	
	//----- Now try to reduce the cluster array in size

	//--- Check if some friendly clusters are close enough together to combine them
	_AW_bluClustersCombined = [];
	_AW_redClustersCombined = [];
	
	while{count _AW_bluClusters > 0}do{
		_combinedPos = [0,0];
		_combinedCount = 0;
		_biggestClusterCount = 0;
		_biggestClusterIndex = -1;
		{
			if ((_x select 1) > _biggestClusterCount) then{_biggestClusterIndex = _forEachIndex;};
		}forEach _AW_bluClusters;
		
		_biggestClusterPos = (_AW_bluClusters select _biggestClusterIndex) select 0;
		
		{
			if ((_x select 0) distance _biggestClusterPos < __clusterCombineRadius) then{
				_AW_bluClusters set[_forEachIndex,-1];
				_combinedPos = [(_combinedPos select 0) + ((_x select 0) select 0),(_combinedPos select 1) + ((_x select 0) select 1)];
				_combinedCount = _combinedCount + 1;
			};
		}forEach _AW_bluClusters;
		_AW_bluClusters = _AW_bluClusters - [-1];
		_AW_bluClustersCombined set [count _AW_bluClustersCombined,[(_combinedPos select 0) / _combinedCount,(_combinedPos select 1) / _combinedCount]];
		//_AW_bluScoringAssets set[count _AW_bluScoringAssets,[(_combinedPos select 0) / _combinedCount,(_combinedPos select 1) / _combinedCount]];
	};
	
	while{count _AW_redClusters > 0}do{
		_combinedPos = [0,0];
		_combinedCount = 0;
		_biggestClusterCount = 0;
		_biggestClusterIndex = -1;
		{
			if ((_x select 1) > _biggestClusterCount) then{_biggestClusterIndex = _forEachIndex;};
		}forEach _AW_redClusters;
		_biggestClusterPos = (_AW_redClusters select _biggestClusterIndex) select 0;
		{
			if ((_x select 0) distance _biggestClusterPos < __clusterCombineRadius) then{
				_AW_redClusters set[_forEachIndex,-1];
				_combinedPos = [(_combinedPos select 0) + ((_x select 0) select 0),(_combinedPos select 1) + ((_x select 0) select 1)];
				_combinedCount = _combinedCount + 1;
			};
		}forEach _AW_redClusters;
		_AW_redClusters = _AW_redClusters - [-1];
		_AW_redClustersCombined set [count _AW_redClustersCombined,[(_combinedPos select 0) / _combinedCount,(_combinedPos select 1) / _combinedCount]];
		//_AW_redScoringAssets set[count _AW_redScoringAssets,[(_combinedPos select 0) / _combinedCount,(_combinedPos select 1) / _combinedCount]];
	};
	
	//--- Check if any combined clusters are close enough to cancel each other out
	_bluToRemove = [];
	_redToRemove = [];
	{
		_bluClusterPos = _x;
		_bluClusterIndex = _forEachIndex;
		
		{
			if ((_bluClusterPos distance _x) < __distanceToClusters) then{
				if !(_bluClusterIndex in _bluToRemove) then{_bluToRemove set[count _bluToRemove,_bluClusterIndex];};
				if !(_forEachIndex in _redToRemove) then{_redToRemove set[count _redToRemove,_forEachIndex];};
			};
		}forEach _AW_redClustersCombined;
		sleep 0.01;
	}forEach _AW_bluClustersCombined;
	
	//-- now clear up the arrays
	{
		_AW_bluClustersCombined set[_x,-1]
	}forEach _bluToRemove;
	{
		_AW_redClustersCombined set[_x,-1]
	}forEach _redToRemove;
	_AW_bluClustersCombined = _AW_bluClustersCombined - [-1];
	_AW_redClustersCombined = _AW_redClustersCombined - [-1];
	
	//-- add the remaining combined clusters to the assets array
	_AW_bluScoringAssets = _AW_bluScoringAssets + _AW_bluClustersCombined;
	_AW_redScoringAssets = _AW_redScoringAssets + _AW_redClustersCombined;
	
	//-- send finished arrays to clients
	AW_event_checkTerritoryControl = [_AW_bluScoringAssets,_AW_redScoringAssets];
	publicVariable "AW_event_checkTerritoryControl";
};

//----- if client
if !(isServer) then{
	_passedArguments = _this;
	_AW_bluScoringAssets = _passedArguments select 0;
	_AW_redScoringAssets = _passedArguments select 1;
};

//--- if in editor
if (isServer && !isDedicated) then{
	AW_chatLogic globalChat format["Time: %1, Frames: %2",diag_tickTime - _preCalcTimeStart,diag_frameno - _preCalcFrameStart];
	AW_chatLogic globalChat format["Assets: %1",count (_AW_bluScoringAssets + _AW_redScoringAssets)];
	AW_chatLogic globalChat format["near: %1",count (player nearEntities ["Man",150])];
};
//--- if server
if (isServer) then{
	diag_log format["Time: %1, Frames: %2",diag_tickTime - _preCalcTimeStart,diag_frameno - _preCalcFrameStart];
	diag_log format["Assets: %1",count (_AW_bluScoringAssets + _AW_redScoringAssets)];
};

//----- if side == resistance
if (playerside == Resistance) then{
	for "_i" from 0 to 100 do{
		_markerName = format["AW_assetMarker_%1",_i];
		deleteMarkerLocal _markerName;
	};

	_markerCounter = 0;

	{
		_markerName = format["AW_assetMarker_%1",_markerCounter];
		_markerName = createMarkerLocal [_markerName,_x];
		_markerName setMarkerTypeLocal "dot";
		_markerName setMarkerColorLocal "ColorGreen";
		_markerCounter = _markerCounter + 1;
	}forEach _AW_bluScoringAssets;
	{
		_markerName = format["AW_assetMarker_%1",_markerCounter];
		_markerName = createMarkerLocal [_markerName,_x];
		_markerName setMarkerTypeLocal "dot";
		_markerName setMarkerColorLocal "ColorOrange";
		_markerCounter = _markerCounter + 1;
	}forEach _AW_redScoringAssets;
};

//----- actual calculation starts

_AW_bluTerritories = 0;
_AW_redTerritories = 0;

_startTime = diag_tickTime;

_alphaNeutralLimit = 0.0 max 0.0001;
_alphaMaxLimit = 0.18;
_alphaMinLimit = 0.1;
_alphaMultiplier = 1;

_influence = 1;

for "_i" from 0 to AW_territoryCount do {
	_marker = format["AW_marker_territory_%1",_i];
	
	/*
	if (AW_trainingEnabled_Param == 1 && (_i > 0)) then{
		hintSilent format["recalculating area-control\n%1 / %2\n%3%4",_i,AW_territoryCount,round ((_i / AW_territoryCount) * 100),"%"];
	};
	*/
	
	_bluDist = 99999;
	_redDist = 99999;
	_newDist = 0;
	
	//----- calc distance
	{
		if (count _x == 3) then{_influence = 1;}else{_influence = 0.33;};
		_newDist = ((markerPos _marker) distance _x) / _influence;
		if (_newDist < _bluDist) then{
			_bluDist = _newDist;
		};
	}forEach _AW_bluScoringAssets;
	{
		if (count _x == 3) then{_influence = 1;}else{_influence = 0.33;};
		_newDist = ((markerPos _marker) distance _x) / _influence;
		if (_newDist < _redDist) then{
			_redDist = _newDist;
		};
	}forEach _AW_redScoringAssets;
	
	if (isDedicated) then{
		switch(true)do{
			case(_bluDist < _redDist):{
				_AW_bluTerritories = _AW_bluTerritories + 1;
			};
			case(_redDist < _bluDist):{
				_AW_redTerritories = _AW_redTerritories + 1;
			};
			default{};
		};
	}else{
		switch(true)do{
			case(_bluDist < _redDist):{
				_marker setMarkerColorLocal "ColorBlue";
				_marker setmarkerAlphaLocal 0.15;
				_AW_bluTerritories = _AW_bluTerritories + 1;
			};
			case(_redDist < _bluDist):{
				_marker setMarkerColorLocal "ColorRed";
				_marker setmarkerAlphaLocal 0.15;
				_AW_redTerritories = _AW_redTerritories + 1;
			};
			case(_redDist == _bluDist):{
				_marker setmarkerAlphaLocal 0;
			};
			default{player sidechat "error"};
		};
	};
	//sleep 0.001;
};

AW_bluTerritories = _AW_bluTerritories;
AW_redTerritories = _AW_redTerritories;

if (isDedicated) then{
	diag_log format["Territory calculated: Blu: %1 | Red: %2 | Time: %3",_AW_bluTerritories,_AW_redTerritories,(diag_tickTime - _startTime)];
}else{
	//hintSilent format["Territory calculated:\nBlu: %1 | Red: %2\ntime: %3",_AW_bluTerritories,_AW_redTerritories,(diag_tickTime - _startTime)];
};