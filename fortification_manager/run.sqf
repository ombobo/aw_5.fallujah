if !((str player) in AW_builders_Cfg) exitWith{hint "You dont have the capability to construct objects.";};

/*
* This is the script that will be executed through the action menu.
*/
//relevent IDCs for the dialog
IDC_FORTIFICATION_LIST = 10101;
IDC_SUPPLY_STATUS = 10102;
IDC_FORTIFICATION_LIST2 = 10202;
IDC_FORTIFICATION_LIST3 = 10203;
IDC_FORTIFICATION_LIST4 = 10204;

private ["_supply_point_text"];

//AW fortification manager is building from 0=CV, 1=Truck
AW_FM_BuildingFrom = 0;

/*
 IT MIGHT BE EASIER TO CHECK IF THE HQ IS DEPLOYED HERE AND 
 REFUSE TO OPEN THE DIALOG IS IT IS NOT.
 
 OR THE ACTION CAN ONLY BE AVAILABLE WHEN IT IS DEPLOYED AND ALIVE
*/
//create the dialog
_dialog = createdialog "AW_fortification_manager_dialog";

/*
* Get supply point value then display it
*/

//player sidechat format["#DEBUG: faction %1",(faction player)]; //debug

switch (faction player)do{
	case ("AW_BLU"):{_supply_point_text = format["Supply Points: %1", [] call AW_GetRessourcePoints];};
	case ("AW_RED"):{_supply_point_text = format["Supply Points: %1", [] call AW_GetRessourcePoints];};
	default {};
};

//_supply_point_text = format["Supply Points: %1", AW_West_Ressources];

//_supply_point_text = format["Supply Points: %1", 50];//place holder
//draws text to dialog label.
ctrlSetText [IDC_SUPPLY_STATUS, _supply_point_text];

/*
* Loads dialog listbox with equipment display name and cost from AW_Fortifications_List.
*/
_config_length = count AW_Fortification_Names;
for [{_index = 0},{_index < _config_length},{_index =_index + 1}] do{
	lbAdd [IDC_FORTIFICATION_LIST, AW_Fortification_Names select _index];
	//lbSetData [IDC_FORTIFICATION_LIST, _index, [_equipment_class,_equipment_preview,_equipment_cost]];
};

/*
* fill the second Listbox with the first subarrays entries
*/
lbClear IDC_FORTIFICATION_LIST2;

AW_Selected_SubCategory = AW_Fortification_Data select 0;
_config_length = count AW_Selected_SubCategory;

//player sidechat format["#DEBUG length: %1",_config_length];
//diag_log AW_Selected_SubCategory;

for [{_index = 0},{_index < _config_length},{_index =_index + 1}] do{
	_data = AW_Selected_SubCategory select _index;
	_equipment_name = _data select 0;
	//player sidechat format["#DEBUG name: %1",_equipment_name];
	lbAdd [IDC_FORTIFICATION_LIST2, _equipment_name];
};

//we can choose to keep the an update loop here with the following code.
//so that if any supply points are added while the dialog is open it will automatically update in the display
/*
while{dialog}do{
	//insert code here
	sleep 1;
};

*/


