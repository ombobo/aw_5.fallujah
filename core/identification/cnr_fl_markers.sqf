AW_markerMode = 2;
AW_InfNameLenght = 2; //Lenght defaults to full
AW_UpdateInfName = true;

//player setVariable[''];

//the variables below should be changed to use the AW_ tag in front in all files, so they dont conflict with other variables
FriendlyUnits = [];
HostileUnits = [];
fl_HostileVehicles = [];

private["_AW_WestTotal","_AW_EastTotal","_AW_AllTotal"];
_AW_WestTotal = AW_westUnit1_Cfg + AW_westUnit2_Cfg + AW_westUnit3_Cfg + AW_westUnit4_Cfg;
_AW_EastTotal = AW_eastUnit1_Cfg + AW_eastUnit2_Cfg + AW_eastUnit3_Cfg + AW_eastUnit4_Cfg;
_AW_AllTotal = _AW_WestTotal + _AW_EastTotal;

private["_color","_marker","_unit","_vehicle","_AW_LastNameCheck"];
_color = "ColorBlack";
_marker = "w0";
_AW_LastNameCheck = -999;

private["_t_empty","_t_man","_t_hostile","_t_vehicle","_t_med","_refresh_rate"];
_t_empty = "EMPTY"; 
_t_man = "mil_arrow";
_t_hostile = "mil_dot"; 
_t_vehicle = "mil_box";
_t_med = "n_med";
_refresh_rate = 1;

//check which markers are for friendly and hostile units
switch(playerSide)do{
	case west:{
		FriendlyUnits = _AW_WestTotal;
		HostileUnits = _AW_EastTotal;
		{
			_marker = _x select 0;
			_vehicle = call compile _marker;
			//if ((_vehicle isKindOf "Tank") || (_vehicle isKindOf "Wheeled_APC")) then
			//{
				fl_HostileVehicles set [count fl_HostileVehicles, _marker];
			//};
		}forEach AW_eastVehicleArray_Cfg;
	};
	case east:{
		FriendlyUnits = _AW_EastTotal;
		HostileUnits = _AW_WestTotal;
		{
			_marker = _x select 0;
			_vehicle = call compile _marker;
			//if ((_vehicle isKindOf "Tank") || (_vehicle isKindOf "Wheeled_APC")) then
			//{
				fl_HostileVehicles set [count fl_HostileVehicles, _marker];
			//};
		}forEach AW_westVehicleArray_Cfg;
	};
	//assigns all unit markers to be drawn if in referee slot
	case resistance:{
		FriendlyUnits = _AW_WestTotal + _AW_EastTotal + AW_refereeSlots_Cfg;
	};
};

if (AW_markerMode_Param == 3) then{FriendlyUnits = _AW_WestTotal + _AW_EastTotal + AW_refereeSlots_Cfg;};

//set the correct markercolor
if (playerSide == resistance) then{
	{
		_marker = _x;
		switch (true) do{
			case(_marker in _AW_WestTotal):{_color = "ColorBlue"};
			case(_marker in _AW_EastTotal):{_color = "ColorRed"};
			case(_marker in AW_refereeSlots_Cfg):{_color = "ColorGreen"};
			default{diag_log format["error marker: %1",_marker];};
		};
		createMarkerLocal [_marker, [0, 0, 0]];
		_marker setMarkerColorLocal _color;
		_marker setMarkerTypeLocal _t_man;
		_marker setMarkerSizeLocal [0.6,0.6];
	}forEach FriendlyUnits;
}else{
	{
		_marker = _x;
		switch (true) do{
			case(_marker in AW_westUnit1_Cfg):{_color = "ColorBlack"};
			case(_marker in AW_westUnit2_Cfg):{_color = "ColorBlack"};
			case(_marker in AW_westUnit3_Cfg):{_color = "ColorBlack"};
			case(_marker in AW_westUnit4_Cfg):{_color = "ColorBlack"};
			case(_marker in AW_eastUnit1_Cfg):{_color = "ColorBlack"};
			case(_marker in AW_eastUnit2_Cfg):{_color = "ColorBlue"};
			case(_marker in AW_eastUnit3_Cfg):{_color = "ColorGreen"};
			case(_marker in AW_eastUnit4_Cfg):{_color = "ColorOrange"};
			case(_marker in AW_refereeSlots_Cfg):{_color = "ColorGreen"};
			default{diag_log format["error marker: %1",_marker];};
		};
		createMarkerLocal [_marker, [0, 0, 0]];
		_marker setMarkerColorLocal _color;
		_marker setMarkerTypeLocal _t_man;
		_marker setMarkerSizeLocal [0.6,0.6];
	}forEach FriendlyUnits;
};


//Create makers for hostile soldiers
{
		_marker = _x;
		
		createMarkerLocal [_marker, [0, 0, 0]];
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerTypeLocal _t_vehicle;
		_marker setMarkerSizeLocal [0.4,0.4];
		_marker setMarkerAlphaLocal 0.5;
		
}forEach HostileUnits;

//Create makers for hostile vehicles
{
		_marker = _x;
		
		createMarkerLocal [_marker, [0, 0, 0]];
		_marker setMarkerColorLocal "ColorRed";
		_marker setMarkerTypeLocal _t_vehicle;
		_marker setMarkerSizeLocal [0.4,0.4];
		
} forEach fl_HostileVehicles;

///-----Marker loop
_oldPlayersNumber = playersNumber playerside;
_unitname = "string";
while {true} do{
	{
		_marker = _x;
		_unit = call compile _marker;
		if (alive _unit && _unit == vehicle _unit) then{
			//-----Marker Name
			switch(AW_InfNameLenght)do{
				case(1):{_unitname = _unit getVariable["unitname","John Doe"];};
				case(2):{_unitname = _unit getVariable["unitShortName","John Doe"];};
				default{_unitname = "error, check script!";};
			};
		
			//-----Marker position and direction
			_marker SetMarkerPosLocal GetPos _unit;	
			_marker SetMarkerDirLocal direction _unit;
			_marker setMarkerTypeLocal _t_man;
			
			//-----MarkerColor
			if (playerSide != resistance) then{
				switch(_unit getVariable ['AW_markerColor',1])do{
					case(1):{_color = "ColorBlack"};
					case(2):{_color = "ColorBlue"};
					case(3):{_color = "ColorGreen"};
					case(4):{_color = "ColorOrange"};
					case(5):{_color = "ColorBrown"};
					case(6):{_color = "ColorKhaki"};
					case(7):{_color = "ColorWhite"};
					default{_color = "ColorBlack"};
				};
				_marker setMarkerColorLocal _color;
			};
			
			//-----Marker text
			switch (AW_markerMode) do{
				case 1:{_marker setMarkerTextLocal format ["%1|%2",1-(round((damage _unit)*10))/10,_unitname];};
				case 2:{_marker setMarkerTextLocal format ["%1", _unitname];};
				case 3:{_marker setMarkerTextLocal format ["%1|%2",getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "displayName"),_unitname];};
				default{_marker setMarkerTextLocal "";};
			};
		}else{
			_marker setMarkerTypeLocal _t_empty;
		};
	}forEach FriendlyUnits;
	sleep _refresh_rate;
};