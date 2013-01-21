private ["_AW_measureServerPerformance"];

_AW_measureServerPerformance = {
	private["_nextSecond","_logInterval","_fps","_fpsMin","_playersNumber","_dumpEachX","_i","_totalPlayersNumber"];
	
	_logInterval = 5; //in seconds
	_dumpEachX = 60 / _logInterval; //dump results to the array once a minute
	
	_fps = 0;
	_fpsMin = 0;
	_playersNumber = 0;
	
	_nextSecond = floor diag_tickTime + _logInterval;
	_i = 1;
	
	AW_logfpsArray = [];
	AW_logfpsMinArray = [];
	AW_logPlayersNumberArray = [];
	
	waitUntil {sleep 0.01; diag_tickTime > _nextSecond};
	
	while{true}do{
		 _fps = _fps + diag_fps;
		 _fpsMin = _fpsMin + diag_fpsmin;
		 _playersNumber = _playersNumber + playersNumber west + playersNumber east + playersNumber resistance;
		 
		if (_i >= _dumpEachX) then{
			AW_logfpsArray set[count AW_logfpsArray,round (_fps / _dumpEachX)];
			AW_logfpsMinArray set[count AW_logfpsMinArray,round (_fpsMin / _dumpEachX)];
			AW_logPlayersNumberArray set[count AW_logPlayersNumberArray,round (_playersNumber / _dumpEachX)];
			//if (!isDedicated) then {player sidechat format["%1",round (_fps / _dumpEachX)];};
			_i = 1;
			_fps = 0;
			_fpsMin = 0;
			_playersNumber = 0;
		}else{
			_i = _i + 1;
		};
		waitUntil {sleep 0.01; diag_tickTime > _nextSecond};
		_nextSecond = floor diag_tickTime + _logInterval;
	};	
};

[] spawn _AW_measureServerPerformance;
diag_log text "|========== starting server loop 1 (_AW_measureServerPerformance)";
sleep 0.2;
