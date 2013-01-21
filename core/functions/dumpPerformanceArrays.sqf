///////////////////
//  AVERAGE FPS  //
///////////////////
diag_log text "";

_ArrayCounter = 0;
diag_log text "Average FPS";

_lineOutput = "====";
for "_loopcounter" from 1 to (count AW_logfpsArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;

_lineOutput = "";
for "_loopcounter" from 50 to 1 step -2 do {
	if (_loopcounter <= 9) then{
		_lineOutput = _lineOutput + " " + str _loopcounter + "|";
	}else{
		_lineOutput = _lineOutput + str _loopcounter + "|";
	};
	
	{
		_arrayEntry = (AW_logfpsArray select _ArrayCounter);
		switch (true) do{
			case(_arrayEntry > _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_arrayEntry == _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_arrayEntry == _loopcounter - 1):{_lineOutput = _lineOutput + ".";};
			case(_arrayEntry < _loopcounter):{_lineOutput = _lineOutput + " ";};
			default{};
		};
		_ArrayCounter = _ArrayCounter + 1;
	}forEach AW_logfpsArray;
	_lineOutput = _lineOutput + "|";
	diag_log text _lineOutput;
	_ArrayCounter = 0;
	_lineOutput = "";
};

_lineOutput = "====";
for "_loopcounter" from 1 to (count AW_logfpsArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;
diag_log AW_logfpsArray;

///////////////////
//  Minimum FPS  //
///////////////////
diag_log text "";

_ArrayCounter = 0;
diag_log text "Average Minimum FPS";

_lineOutput = "====";
for "_loopcounter" from 1 to (count AW_logfpsMinArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;

_lineOutput = "";
for "_loopcounter" from 50 to 1 step -2 do {
	if (_loopcounter <= 9) then{
		_lineOutput = _lineOutput + " " + str _loopcounter + "|";
	}else{
		_lineOutput = _lineOutput + str _loopcounter + "|";
	};
	
	{
		_arrayEntry = (AW_logfpsMinArray select _ArrayCounter);
		switch (true) do{
			case(_arrayEntry > _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_arrayEntry == _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_arrayEntry == _loopcounter - 1):{_lineOutput = _lineOutput + ".";};
			case(_arrayEntry < _loopcounter):{_lineOutput = _lineOutput + " ";};
			default{};
		};
		_ArrayCounter = _ArrayCounter + 1;
	}forEach AW_logfpsMinArray;
	_lineOutput = _lineOutput + "|";
	diag_log text _lineOutput;
	_ArrayCounter = 0;
	_lineOutput = "";
};

_lineOutput = "====";
for "_loopcounter" from 1 to (count AW_logfpsMinArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;
diag_log AW_logfpsMinArray;

///////////////////
////  Players  ////
///////////////////
diag_log text "";

_ArrayCounter = 0;
diag_log text "Playercount";

_lineOutput = "====";
for "_loopcounter" from 1 to (count AW_logPlayersNumberArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;

_lineOutput = "";
for "_loopcounter" from 100 to 4 step -4 do {
	if (_loopcounter <= 9) then{
		_lineOutput = _lineOutput + " " + str _loopcounter + "|";
	}else{
		_lineOutput = _lineOutput + str _loopcounter + "|";
	};
	
	{
		_currentPlayersNumber = AW_logPlayersNumberArray select _ArrayCounter;
		switch (true) do{
			case(_currentPlayersNumber > _loopcounter):{_lineOutput = _lineOutput + ":";};
			case(_currentPlayersNumber == _loopcounter || _currentPlayersNumber == _loopcounter - 1):{_lineOutput = _lineOutput + ":";};
			case(_currentPlayersNumber == _loopcounter - 2 || _currentPlayersNumber == _loopcounter - 3):{_lineOutput = _lineOutput + ".";};
			case(_currentPlayersNumber < _loopcounter):{_lineOutput = _lineOutput + " ";};
			default{};
		};
		_ArrayCounter = _ArrayCounter + 1;
	}forEach AW_logPlayersNumberArray;
	_lineOutput = _lineOutput + "|";
	diag_log text _lineOutput;
	_ArrayCounter = 0;
	_lineOutput = "";
};

_lineOutput = "====";
for "_loopcounter" from 1 to (count AW_logPlayersNumberArray) do{
	_lineOutput = _lineOutput + "=";
};
diag_log text _lineOutput;
diag_log AW_logPlayersNumberArray;