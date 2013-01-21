AW_c5_cornerArray = [];
AW_c5_AOArray = [];
AW_c5_AOcontrol = [[25,1],[15,1],[32,1],[9,0],[8,0],[21,0],[1,0],[23,0],[7,0],[22,0],[28,0],[6,0],[10,0],[19,0],[26,0],[0,0],[4,0],[24,0],[20,1],[33,1],[13,1],[18,1],[31,1],[17,1],[29,1],[16,1],[27,1],[11,1],[12,1],[2,1],[30,1],[3,0],[14,1]];

"marker_map" setmarkerAlphaLocal 0;

AW_c5_cornerCount = 0;
AW_c5_devBorderCount = 0;

script_calcArea = compile preProcessFileLineNumbers "aw5_score\dev\calcAreaForAO.sqf";

GetCornerMarker = {
	private["_clickPos","_closestMarkerDist","_closestMarker"];
	_clickPos = [_this select 0,_this select 1];
	
	//player sidechat format["_clickPos is %1",_clickPos];
	_closestMarkerDist = 9999;
	_closestMarker = -1;
	
	for "_i" from 0 to 199 do {
		_cornerMarkerPos = markerPos format['AW_AOCorner_%1',_i];
		if ((_clickPos distance _cornerMarkerPos) < _closestMarkerDist) then{
			_closestMarkerDist = (_clickPos distance _cornerMarkerPos);
			_closestMarker = _i;
		};
	};
	//player sidechat format["closest: %1",_closestMarker];
	_closestMarker
};

GetAOMarker = {
	private["_clickPos","_closestMarkerDist","_closestMarker"];
	_clickPos = [_this select 0,_this select 1];
	
	//player sidechat format["_clickPos is %1",_clickPos];
	_closestMarkerDist = 9999;
	_closestMarker = -1;
	
	diag_log text format["GetAO clickpos: %1",_clickPos];
	diag_log text format["GetAO AOArray: %1",AW_c5_AOArray];
	
	{
		_AOMarkerPos = markerPos format['AW_AO_%1',_x select 0];
		if ((_clickPos distance _AOMarkerPos) < _closestMarkerDist) then{
			_closestMarkerDist = (_clickPos distance _AOMarkerPos);
			_closestMarker = _x select 0;
		};
	}forEach AW_c5_AOArray;
	diag_log text format["GetAO closest: %1",_closestMarker];
	
	//player sidechat format["closest: %1",_closestMarker];
	_closestMarker
};

AW_DumpDevArray = {
	diag_log text "====== Corner Array autosave ========";
	diag_log AW_c5_cornerArray;
	diag_log text "======== AO Array autosave ==========";
	diag_log AW_c5_AOArray;
	sleep 60;
};

AW_C5Dev_recreateCorners = {
	_xDifference = 0;
	_yDifference = 0;

	for "_i" from 0 to 199 do{
		if (_i % 10 == 0) then{
			_yDifference = _yDifference + 100;
			_xDifference = 0;
		};
		
		_cornerMarkerName = format['AW_AOCorner_%1',_i];
		deleteMarker _cornerMarkerName;
		if (markerColor _cornerMarkerName == "") then{
			_cornerMarkerName = createMarker [_cornerMarkerName, [500 + _xDifference,_yDifference]];
			_cornerMarkerName setMarkerShape 'ICON';
			_cornerMarkerName setMarkerType 'mil_dot';
			_cornerMarkerName setMarkerSize [0.5,0.5];
			//_cornerMarkerName setmarkerText format['%1',_i];
		};
		
		_xDifference = _xDifference + 250;
	};
	_AWProfileNS = profileNameSpace;
	{
		diag_log _x;
		if (typeName _x == "ARRAY") then{
			_cornerMarkerName = format['AW_AOCorner_%1',_x select 0];
			_cornerMarkerName setMarkerPos [_x select 1,_x select 2];
		};
	}forEach (_AWProfileNS getVariable["AW_c5_cornerArray",[]]);
};

AW_C5Dev_recreateAOs = {
	private["_totalX","_totalY","_corners","_cornerMarkerName"];
	
	{
		_AOMarkerName = format['AW_AO_%1',_x select 0];
		deleteMarker _AOMarkerName;
		
		_totalX = 0;
		_totalY = 0;
		
		_corners = _x select 1;
		
		{
			_cornerMarkerName = format['AW_AOCorner_%1',_x];
			_totalX = _totalX + ((markerPos _cornerMarkerName) select 0);
			_totalY = _totalY + ((markerPos _cornerMarkerName) select 1);
		}forEach _corners;
		
		_totalX = _totalX / (count _corners);
		_totalY = _totalY / (count _corners);
		
		_AOMarkerName = createMarker [_AOMarkerName, [_totalX,_totalY]];
		_AOMarkerName setMarkerShape 'ICON';
		_AOMarkerName setMarkerSize [0.25,0.25];
		_AOMarkerName setMarkerType 'mil_objective';
		//_AOMarkerName setmarkerText format['%1',_x select 0];
		_AOMarkerName setmarkerText format['%1 - %2',_x select 0,_AOMarkerName];
	}forEach AW_c5_AOArray;
	publicVariable "AW_c5_AOArray";
};

if !(isServer) then{
	"AW_c5_AOArray" addPublicVariableEventhandler {
		terminate AW_handle_drawBorders;
		AW_handle_drawBorders = []execVM 'aw5_score\dev\AW_DrawDevBorders.sqf';
	};	
	"AW_c5_cornerArray" addPublicVariableEventhandler {
		terminate AW_handle_drawBorders;
		AW_handle_drawBorders = []execVM 'aw5_score\dev\AW_DrawDevBorders.sqf';
	};	
};

if (isServer) then{
	
	_AWProfileNS = profileNameSpace;
	AW_c5_AOArray = _AWProfileNS getVariable["AW_c5_AOArray",[]];
	AW_c5_cornerArray = _AWProfileNS getVariable["AW_c5_cornerArray",[]];
	
	diag_log "Getting AW arrays from the Namespace";
	diag_log AW_c5_AOArray;
	diag_log AW_c5_cornerArray;
	
	//----- Begin EH
	
	"AW_EH_resetArrays" addPublicVariableEventhandler{
		AW_c5_AOArray = [];
		AW_c5_cornerArray = [];
		
		_AWProfileNS = profileNameSpace;
		_AWProfileNS setVariable["AW_c5_AOArray",AW_c5_AOArray];
		_AWProfileNS setVariable["AW_c5_cornerArray",AW_c5_cornerArray];
		
		{
			_AOMarkerName = format['AW_AO_%1',_x select 0];
			deletemarker _AOMarkerName;
		}forEach AW_c5_AOArray;
		
		publicVariable "AW_c5_cornerArray";
		publicVariable "AW_c5_AOArray";
	};
	
	"AW_EH_addAO" addPublicVariableEventhandler {
		_AW_passedArgument = _this select 1;
		diag_log _AW_passedArgument;
		//AW_NewCornerArray = [];
		//_posArray = 
		AW_NewCornerX = (_AW_passedArgument select 0) select 0;
		AW_NewCornerY = (_AW_passedArgument select 0) select 1;
		AW_NewCornerArray = _AW_passedArgument select 1;
		
		_newAOID = 0;
		_indexExists = false;
		for "_i" from 0 to (count AW_c5_AOArray) do{
			_indexExists = false;
			{
				if ((_x select 0) == _i) exitWith{_indexExists = true;};
			}forEach AW_c5_AOArray;
			if !(_indexExists) exitWith{_newAOID = _i;};
		};
		
		AW_c5_AOArray set [count AW_c5_AOArray,[_newAOID,AW_NewCornerArray]];
		
		_AOMarkerName = format['AW_AO_%1',_newAOID];
		_AOMarkerName = createMarker [_AOMarkerName, [AW_NewCornerX / (count AW_NewCornerArray),AW_NewCornerY / (count AW_NewCornerArray)]];
		_AOMarkerName setMarkerShape 'ICON';
		_AOMarkerName setMarkerSize [0.5,0.5];
		_AOMarkerName setMarkerType 'mil_objective';
		//_AOMarkerName setmarkerText format['%1',_newAOID];
		_AOMarkerName setmarkerText format['%1 - %2',_x select 0,_AOMarkerName];
		
		publicVariable "AW_c5_AOArray";
		
		//----- Update profileNameSpace Begin
		_AWProfileNS = profileNameSpace;
		_profileVars = _AWProfileNS getVariable ["AW_profileVars",[]];
		if !("AW_c5_AOArray" in _profileVars) then{
			_profileVars set[count _profileVars,"AW_c5_AOArray"];
			_AWProfileNS setVariable["AW_profileVars",_profileVars];
		};
		_AWProfileNS setVariable["AW_c5_AOArray",AW_c5_AOArray];
		saveProfileNamespace;
		//----- Update profileNameSpace End
		
	};
	
	"AW_EH_removeAO" addPublicVariableEventhandler {
		_AW_passedArgument = _this select 1;
		diag_log format["removeAO passed: %1",_AW_passedArgument];
		
		_AOMarkerName = format['AW_AO_%1',_AW_passedArgument];
		deletemarker _AOMarkerName;
		
		{
			if ((_x select 0) == _AW_passedArgument) then{
				AW_c5_AOArray set[_forEachIndex,-1];
			};
		}forEach AW_c5_AOArray;
		AW_c5_AOArray = AW_c5_AOArray - [-1];
		
		publicVariable "AW_c5_AOArray";
		
		//----- Update profileNameSpace Begin
		_AWProfileNS = profileNameSpace;
		_AWProfileNS setVariable["AW_c5_AOArray",AW_c5_AOArray];
		saveProfileNamespace;
		//----- Update profileNameSpace End
	};
	
	"AW_EH_updateCorner" addPublicVariableEventhandler {
		_AW_passedArgument = _this select 1;
		AW_cornerToUpdateNumber = _AW_passedArgument select 0;
		_x = _AW_passedArgument select 1;
		_y = _AW_passedArgument select 2;
		
		AW_cornerToUpdateName = format['AW_AOCorner_%1',AW_cornerToUpdateNumber];
		AW_cornerToUpdateName setmarkerPos [_x,_y];
		
		AW_c5_cornerArray set [AW_cornerToUpdateNumber,[AW_cornerToUpdateNumber,_x,_y]];
		publicVariable "AW_c5_cornerArray";
		
		terminate handlerrrrryesbadnametellme;
		terminate AW_handle_calcArea;
		handlerrrrryesbadnametellme = [] spawn{
			diag_log "arrrrhandler";
			{
				diag_log format["checking array AO %1, corners:",_x select 0,_x select 1];
				if (AW_cornerToUpdateNumber in (_x select 1)) then{
					diag_log format["found"];
					AW_handle_calcArea = [_x select 0] spawn script_calcArea;
					waitUntil{scriptDone AW_handle_calcArea;};
				};
			}forEach AW_c5_AOArray;
		};

		
		//----- Update profileNameSpace Begin
		_AWProfileNS = profileNameSpace;
		_profileVars = _AWProfileNS getVariable ["AW_profileVars",[]];
		if !("AW_c5_cornerArray" in _profileVars) then{
			_profileVars set[count _profileVars,"AW_c5_cornerArray"];
			_AWProfileNS setVariable["AW_profileVars",_profileVars];
		};
		_AWProfileNS setVariable["AW_c5_cornerArray",AW_c5_cornerArray];
		saveProfileNamespace;
		//----- Update profileNameSpace End
	};	
	
	"AW_EH_removeCorner" addPublicVariableEventhandler {
		_AW_passedArgument = _this select 1;
		diag_log format["removeCorner passed: %1",_AW_passedArgument];
		
		_cornerMarkerName = format['AW_AOCorner_%1',_AW_passedArgument];
		
		//deletemarker _cornerMarkerName;
		
		{
			if (typeName _x == "ARRAY") then{
				if ((_x select 0) == _AW_passedArgument) then{
					AW_c5_cornerArray set[_forEachIndex,-1];
				};
			};
		}forEach AW_c5_cornerArray;
		//AW_c5_cornerArray = AW_c5_cornerArray - [-1];
		
		publicVariable "AW_c5_cornerArray";
		
		//----- Update profileNameSpace Begin
		_AWProfileNS = profileNameSpace;
		_AWProfileNS setVariable["AW_c5_cornerArray",AW_c5_cornerArray];
		saveProfileNamespace;
		//----- Update profileNameSpace End
	};
	
	"AW_EH_recreateCornersAndAOs" addPublicVariableEventhandler {
		[] call AW_C5Dev_recreateCorners;
		[] call AW_C5Dev_recreateAOs;
	};
	//----- End EH
	
	[] call AW_C5Dev_recreateCorners;
	[] call AW_C5Dev_recreateAOs;
	

	/*
	while{true} do{
		[]call AW_DumpDevArray;
		sleep 60;
	};
	*/
	
	//overwriting
	AW_c5_cornerArray= [
[10,4897.64,4502.84],
[42,6542.48,4460.7],
[50,2861.88,5992.35],
[62,1993.19,7263.6],
[64,5389.23,3996.41],
[65,4337.06,5818.66],
[70,7129.55,6305.42],
[74,5947.88,5312.85],
[75,6453.71,4669.99],
[83,3039.91,5509.37],
[84,3030.3,4367],
[85,6474.95,5878.59],
[92,3536.37,4273.3],
[93,6414.4,6357.66],
[94,5584.75,4983.61],
[95,6444.25,6080.34],
[96,5618.34,4616.84],
[98,7257.52,5309.76],
[102,2831.66,4828.62],
[103,4945.11,4895.38],
[104,3810.87,4673.73],
[105,6129.3,4401.16],
[112,3005.14,7231.45],
[113,4492.47,4348.17],
[114,5036.72,5898.3],
[115,5471.35,5960.26],
[117,6145.54,4064.65],
[122,2548.36,5839.64],
[123,3085.75,5211.96],
[124,7246.38,5410.06],
[125,3940.3,4525.03],
[127,4669.25,5860.91],
[132,6366.16,6692.61],
[133,3279.73,4558.1],
[134,2346.08,7551.45],
[135,5523.11,5270.9],
[136,4312.41,6182.5],
[137,6426.32,5028.67],
[142,7088,6588.17],
[143,5795.69,6273.49],
[144,4311.66,4626.6],
[145,4404.67,5129.53],
[146,6404.68,5361.02],
[147,5290.47,4940.45],
[152,3212.44,4874.55],
[153,4341.38,8360.69],
[154,4173.48,4558.17],
[155,5899.64,5804.36],
[156,3261.96,4167.04],
[157,5102.56,5409.15],
[158,5641.58,4345.51],
[161,6432.53,6211.42],
[162,3930.38,5718.07],
[163,4971.43,8478.82],
[164,5853.63,6002.79],
[165,4377.71,5396.79],
[166,5455.88,5745.72],
[167,4677.93,4858.82],
[168,5354.98,4317.54],
[173,7164.82,5989.37],
[174,1993.19,8266.61],
[175,3739.8,5356.34],
[176,4629.79,5156.22],
[177,4765.57,5402.43],
[178,6790.83,5423.26],
[179,4980.29,6328.78],
[183,4302.01,8931.67],
[184,3709.68,5687.54],
[185,3374.85,5617.14],
[186,3110.77,4193.57],
[187,5317.31,4680.11],
[188,7102.27,5118.95],
[190,3784.52,4946.96],
[191,2783.67,5122.51],
[192,6348.86,5856.74],
[193,6754.53,5925],
[194,3419.73,5309.89],
[195,3477.24,4908.03],
[196,3892.22,6126.84],
[197,5133.38,5222.76],
[198,5065.37,5698.33]
	];
	//----- AO Array
	AW_c5_AOArray = [
[0,[185,184,175,190,195,194]],
[1,[174,134,112,62]],
[6,[146,178,124,98,188,137]],
[7,[183,163,153]],
[8,[147,94,96,158,168,187]],
[10,[166,155,74,135]],
[11,[137,188,42,75]],
[12,[155,192,146,74]],
[5,[135,74,146,137,94]],
[13,[94,137,75,96]],
[14,[96,75,42,105,158]],
[16,[193,173,124,178]],
[4,[176,197,135,94,147,103,167]],
[9,[145,165,177,157,197,176]],
[17,[157,198,166,135,197]],
[18,[168,158,105,117,64]],
[19,[65,127,114,198,157,177,165]],
[20,[114,115,164,95,85,192,155,166,198]],
[21,[184,162,65,165,175]],
[22,[165,145,190,175]],
[2,[104,190,145,176,167,144,154,125]],
[3,[152,195,190,104,133]],
[23,[104,125,92,156,186,84,133]],
[24,[191,123,152,133,84,102]],
[25,[196,136,65,162]],
[15,[192,85,193,178,146]],
[26,[161,70,173,193,85,95]],
[27,[161,93,132,142,70]],
[28,[152,123,83,185,194,195]],
[29,[122,50,83,123,191]]
	];

	AW_newCornerIndex = [];

	{
		/*
		//_cornerToCheck = _x select 0;
		_indexToCheck = _forEachIndex;
		{
			if(_x select 0 == _indexToCheck && _indexToCheck != _forEachIndex)then{
				diag_log text format["Double Entry detected. Corner: %1, at index: %2. Correcting this now.",_cornerToCheck,_forEachIndex];
				//AW_c5_cornerArray set[_forEachIndex,-1];
			};
		}forEach AW_c5_cornerArray;
		*/
		AW_newCornerIndex set[_x select 0,_x];
	}forEach AW_c5_cornerArray;
	
	AW_c5_cornerArray = AW_newCornerIndex;
	
	_AWProfileNS = profileNameSpace;
	_AWProfileNS setVariable["AW_c5_AOArray",AW_c5_AOArray];
	_AWProfileNS setVariable["AW_c5_cornerArray",AW_c5_cornerArray];
	
	publicVariable "AW_c5_cornerArray";
	publicVariable "AW_c5_AOArray";
};
