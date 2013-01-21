/*
	Before equipment is spawned we neeed to check the following;
	1. is HQ deployed
	2. is there enough supply points to purchase the fortification
	3. Is the spanw location empty
	
	After the fortification is spawned the available supply points need to be updated
	Supply Points Label IDC = 10102



*/

/*
*  (Place holder function)
* Param: 
* Returns: 
*/

AW_GetRessourcePoints = {
	private["_returnValue"];
	
	switch (AW_FM_BuildingFrom)do{
		case (0):{
			switch (faction player)do{
				case ("AW_BLU"):{
					_returnValue = AW_West_Ressources;
					{
						if (alive _x && (_x distance west_CV < AW_distanceToBuild)) then {_returnValue = _returnValue + 25;};
					}forEach AW_west_ScoringTrucks;
				};
				case ("AW_RED"):{
					_returnValue = AW_East_Ressources;
					{
						if (alive _x && (_x distance east_CV < AW_distanceToBuild)) then {_returnValue = _returnValue + 25;};
					}forEach AW_east_ScoringTrucks;
				};
				default {};
			};
		};
		case (1):{
			switch (faction player)do{
				case ("AW_BLU"):{_returnValue = AW_West_RessourcesTrucks;};
				case ("AW_RED"):{_returnValue = AW_East_RessourcesTrucks;};
				default {};
			};
		};
		default {};
	};
	

	_returnValue;
};

AW_Spawn_Fortification = {
	private["_objectClassString","_previewString","_cost","_distanceFromPlayer","_distanceHint","_calculatedDistance","_xPos","_yPos"];
	
	//player sidechat format["#DEBUG: preview: %1",AW_Selected_Preview];
	
	AW_Player_Constructing = true;
	
	_objectClassString = AW_Selected_Fortification;
	if (AW_Selected_Preview == "") then {AW_Selected_Preview = AW_Selected_Fortification};
	//_previewString = AW_Selected_Preview;
	//AW_FortificationToSpawn = AW_Selected_Preview createvehiclelocal [0,0,0];
	AW_FortificationToSpawn = AW_Selected_Fortification createvehiclelocal [0,0,0];
	
	_cost = AW_Selected_Fortification_Cost;
	
	_distanceFromPlayer = (sizeof AW_Selected_Fortification);
	if (_distanceFromPlayer < 5) then {_distanceFromPlayer = 5};
	if (_distanceFromPlayer > 10) then {_distanceFromPlayer = 10};
	//player sidechat format["#DEBUG: sizeOfObject = %1",_distanceFromPlayer];
	//player sidechat format["#DEBUG: CV: %1",CommandVehicle];
	//player sidechat format["#DEBUG: faction: %1",faction player];
	
	action_ConstrSingle = player addAction ["Construct", "fortification_manager\constr_single.sqf", [_objectClassString,_distanceFromPlayer,_cost]];
	action_ConstrMultiple = player addAction ["Construct additional", "fortification_manager\constr_additional.sqf", [_objectClassString,_distanceFromPlayer,_cost]];
	action_ConstrCancel = player addAction ["Cancel construction", "fortification_manager\constr_cancel.sqf"];

	AW_KillFortificationSpawning = false;
	
	while {alive player && !(AW_KillFortificationSpawning)} do
	{
		_xPos = (getPos player select 0) + (_distanceFromPlayer * (cos ((direction player - 90) * (-1))));
		_yPos = (getPos player select 1) + (_distanceFromPlayer * (sin ((direction player - 90) * (-1))));
		
		_distanceHint = 999;
		{
			_calculatedDistance = [_xPos,_yPos,0] distance _x;
			if (_calculatedDistance < _distanceHint) then {_distanceHint = _calculatedDistance}
		}forEach [AW_friendlyCV]+AW_friendlySupplyTrucks;
		
		AW_FortificationToSpawn setDir direction player;
		AW_FortificationToSpawn setPos [_xPos,_yPos,0];
		hintSilent format["dist: %1",_distanceHint];
		//sleep 0.033
	};
	
	//if (alive AW_FortificationToSpawn) then {deleteVehicle AW_FortificationToSpawn}; //in case player died and object is still alive
	deleteVehicle AW_FortificationToSpawn;
	
	//player sidechat "#DEBUG: exiting AW_Spawn_Fortification";
	
	player removeAction action_ConstrSingle;
	player removeAction action_ConstrMultiple;
	player removeAction action_ConstrCancel;
	
	AW_Player_Constructing = false;
};

AW_Destroy_Fortifications = {
	private["_cursorPos","_distance","_arrow"];
	AW_Player_Constructing = true;
	_arrow = "Sign_arrow_down_large_EP1" createvehiclelocal [0,0,0];
	
	action_deconstrSingle = player addAction ["Deconstruct cursortarget", "fortification_manager\remove_single.sqf"];
	action_deconstrSpecial = player addAction ["Deconstruct in 5m radius", "fortification_manager\remove_special.sqf"];
	action_ConstrCancel = player addAction ["Cancel construction", "fortification_manager\constr_cancel.sqf"];
	
	AW_KillFortificationDeconstr = false;
	while {alive player && !AW_KillFortificationDeconstr} do{
		_cursorPos = getPosASL cursorTarget;
		_distance = (getPosASL player) distance _cursorPos;
		_distance = _distance / 2;
		if (_distance > 3) then {_distance = 3;};
		//if (_distance < 3) then {_distance = 3;};
		_arrow setPosASL [_cursorPos select 0, _cursorPos select 1, (_cursorPos select 2) + 6];
		//player sidechat format["pos: %1",getPosASL cursorTarget];
		//sleep 0.1;
	};
	player removeAction action_deconstrSingle;
	player removeAction action_deconstrSpecial;
	player removeAction action_ConstrCancel;
	deleteVehicle _arrow;
	AW_Player_Constructing = false;
};

/*
* Function that is called when purchase button is clicked in the dialog.
*/
AW_Purchase_Button_Click_Event ={
	if (!AW_Player_Constructing) then {handle_constructionScript = []spawn AW_Spawn_Fortification;};
	//debug
	hint format["Class: %1\nCost: %2",AW_Selected_Fortification, AW_Selected_Fortification_Cost];
};

AW_Deconstruct_Button_Click_Event ={
	if (!AW_Player_Constructing) then {handle_constructionScript = []spawn AW_Destroy_Fortifications;};
	//debug
	hint format["Class: %1\nCost: %2",AW_Selected_Fortification, AW_Selected_Fortification_Cost];

};

/*
* Update the 2nd Listbox
*/

AW_Update_Second_List ={
	private["_index","_data","_availableObjArray"];
	
	lbClear IDC_FORTIFICATION_LIST2;
	
	_availableObjArray = [];
	switch (AW_FM_BuildingFrom)do{
		case (0):{_availableObjArray = AW_Fortification_Data;};
		case (1):{_availableObjArray = AW_Fortification_Data_Trucks;};
		default {};
	};

	_index = _this select 1;
	AW_Selected_SubCategory = _availableObjArray select _index;
	_config_length = count AW_Selected_SubCategory;
	
	//player sidechat format["#DEBUG length: %1",_config_length];
	//diag_log AW_Selected_SubCategory;
	
	for [{_index = 0},{_index < _config_length},{_index =_index + 1}] do{
		_data = AW_Selected_SubCategory select _index;
		_equipment_name = _data select 0;
		_equipment_class = _data select 1;
		_equipment_preview = _data select 2;
		_equipment_cost = _data select 3;
		lbAdd [IDC_FORTIFICATION_LIST2, _equipment_name];
		//lbSetData [IDC_FORTIFICATION_LIST, _index, [_equipment_class,_equipment_preview,_equipment_cost]];
	};
};

/*
* Diplays the cost of equipment.
* Called from  LBindexchanged event
* Param: Dialog
* Returns: N/A
*/

AW_Upadate_Selection_Dialog ={
	private["_index","_data","_costString"];
	_index = _this select 1;
	_data = AW_Selected_SubCategory select _index;
	AW_Selected_Fortification = _data select 1;
	AW_Selected_Preview = _data select 2;
	AW_Selected_Fortification_Cost = _data select 3;
	_costString = format["Equipment Cost. %1",AW_Selected_Fortification_Cost];
	ctrlSetText [10103, _costString];
	//player sidechat format["#DEBUG: %1, %2",_costString,IDC_COST_STATUS];
};


//
AW_Fortification_To_Array = {
	//0=east, 1=west
	private["_newFortification","_side","_cost"];
	
	_side = _this select 0;
	_newFortification = _this select 1;
	_cost = _this select 2;
	_builtFrom = _this select 3;
	
	//obj,cost,tickTime for refund duration check(0 when its being added),buildFrom
	switch (_side)do{
		case ("WEST"):{AW_FortificationTempArrayWest set [count AW_FortificationTempArrayWest, [_newFortification,_cost,0,_builtFrom]];};
		case ("EAST"):{AW_FortificationTempArrayEast set [count AW_FortificationTempArrayEast, [_newFortification,_cost,0,_builtFrom]];};
		case ("GUER"):{AW_FortificationTempArrayGuer set [count AW_FortificationTempArrayGuer, [_newFortification,_cost,0,_builtFrom]];};
		default {};
	};
	
	
};

AW_Check_Fortifications ={
	private["_checkFortificationDistanceWest",
	"_checkFortificationDistanceEast",
	"_westVehicleArray",
	"_eastVehicleArray",
	"_westArray",
	"_eastArray",
	"_randomobject",
	"_deleteVehicle",
	"_tickTime",
	"_object",
	"_cost",
	"_counter",
	"_builtFrom"];
	
	_westArray = [];
	_eastArray = [];
	
	_westVehicleArray = [west_CV] + AW_west_ScoringTrucks;
	_eastVehicleArray = [east_CV] + AW_east_ScoringTrucks;
	
	_deleteVehicle = {
		private ["_objectToDelete"];
		_objectToDelete = _this select 0;
		sleep 5;
		//diag_log format["#DEBUG: deleting obj: %1 at time: %2",_objectToDelete,diag_tickTime];
		AW_RefundArrayWest set [count AW_RefundArrayWest,[[typeof _objectToDelete] call _findOutCosts],diag_tickTime];
		deleteVehicle _objectToDelete;
	};
	
	_checkFortificationDistanceWest = {
		private["_returnValue"];
		_returnValue = true;
		{
			if (alive _x && _object distance _x < (AW_distanceToBuild * 2)) then {_returnValue = false;};
			//diag_log format["dist: %1, _x: %2",(_object distance _x),_x];
		}forEach _westVehicleArray;
		//if (!isDedicated) then {player sidechat format["returnValue %1",_returnValue];};
		_returnValue;
	};
	
	_checkFortificationDistanceEast = {
		private["_returnValue"];
		_returnValue = true;
		{
			if (alive _x && _object distance _x < (AW_distanceToBuild * 2)) then {_returnValue = false;};
		}forEach _eastVehicleArray;
		_returnValue;
	};
	
	while {true} do {
		_westVehicleArray = [west_CV] + AW_west_ScoringTrucks;
		_eastVehicleArray = [east_CV] + AW_east_ScoringTrucks;
	
		if (count AW_FortificationTempArrayWest > 0) then {
			AW_FortificationArrayWest = AW_FortificationArrayWest + AW_FortificationTempArrayWest;
			AW_FortificationTempArrayWest resize 0;
		};
		
		if (count AW_FortificationTempArrayEast > 0) then {
			AW_FortificationArrayEast = AW_FortificationArrayEast + AW_FortificationTempArrayEast;
			AW_FortificationTempArrayEast resize 0;
		};
		
		//west
		_counter = 0;
		{
			_object = _x select 0;
			_cost = _x select 1;
			_tickTime = _x select 2;
			_builtFrom = _x select 3;
			
			switch (true)do{
				case (_tickTime == 0):{
					switch (true)do{
						case (!alive _object):{AW_FortificationArrayWest set [_counter, [_object,_cost,diag_tickTime,_builtFrom]];};
						case ([] call _checkFortificationDistanceWest):{_westArray set [count _westArray, _object];};
						default {};
					};
				};
				case (_tickTime < (diag_tickTime - AW_timeTillRefund)):{
					//refund associated points, 0=CV, 1=trucks
					switch (_builtFrom)do{
						case (0):{AW_West_Ressources = AW_West_Ressources + _cost;};
						case (1):{AW_West_RessourcesTrucks = AW_West_RessourcesTrucks + _cost;};
						default {};
					};
					deleteVehicle _object;
					AW_FortificationArrayWest set [_counter, -1]; //set data at that position to '-1' for easy deletion
				};
				default {};
			};
			_counter = _counter + 1;
			sleep 0.01;
		}forEach AW_FortificationArrayWest;
		
		//remove entries of deleted objects from the array
		AW_FortificationArrayWest = AW_FortificationArrayWest - [-1];
		
		if (count _westArray > 0) then {
			_randomobject = _westArray select (round(random((count _westArray) -1)));
			_randomobject setDamage 1;
		};
		
		//east
		_counter = 0;
		{
			_object = _x select 0;
			_cost = _x select 1;
			_tickTime = _x select 2;
			_builtFrom = _x select 3;
			
			switch (true)do{
				case (_tickTime == 0):{
					switch (true)do{
						case (!alive _object):{AW_FortificationArrayeast set [_counter, [_object,_cost,diag_tickTime,_builtFrom]];};
						case ([] call _checkFortificationDistanceEast):{_eastArray set [count _eastArray, _object];};
						default {};
					};
				};
				case (_tickTime < (diag_tickTime - AW_timeTillRefund)):{
					//refund associated points, 0=CV, 1=trucks
					switch (_builtFrom)do{
						case (0):{AW_East_Ressources = AW_East_Ressources + _cost;};
						case (1):{AW_East_RessourcesTrucks = AW_East_RessourcesTrucks + _cost;};
						default {};
					};
					deleteVehicle _object;
					AW_FortificationArrayeast set [_counter, -1]; //set data at that position to '-1' for easy deletion
				};
				default {};
			};
			
			//if (!isDedicated) then{player sidechat format["obj: %1, cost: %2, time: %3, builtFrom: %4",_object,_cost,_tickTime,_builtFrom];};
			
			_counter = _counter + 1;
			sleep 0.01; //should result in one object chcked per frame
		}forEach AW_FortificationArrayeast;
		
		//remove entries of deleted objects from the array
		AW_FortificationArrayeast = AW_FortificationArrayeast - [-1];
		
		if (count _eastArray > 0) then {
			_randomobject = _eastArray select (round(random((count _eastArray) -1)));
			_randomobject setDamage 1;
		};
		
		//get arrays ready again
		_westArray resize 0;
		_eastArray resize 0;

		sleep 10;
		
		//update the ressource pool and inform all players about the new value
		publicVariable "AW_West_Ressources";
		publicVariable "AW_West_RessourcesTrucks";
		publicVariable "AW_East_Ressources";
		publicVariable "AW_East_RessourcesTrucks";
	};
};