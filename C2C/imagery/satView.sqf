private["_CamPos","_targetPos","_camera_Target","_command_vehicle"];


if (side player == west)then{_command_Vehicle = call compile AW_west_CommandVehicle_cfg;};
if (side player == east)then{_command_Vehicle = call compile AW_east_CommandVehicle_cfg;};
if (( vehicle player ) != ( vehicle _command_vehicle ))exitwith{
	Hint "You need to be inside the command vehicle to use this feature";
};


IDC_FILTERS_LIST = 12102;
IDC_ZOOM_LEVEL_LIST = 12103;
AW_SatView_ON = true;
AW_Sat_Camera = objnull;
AW_SatView_Z_Pos = 100;

_dialog = createDialog "AW_Sat_View_Dialog";

_listIndex = lbAdd [IDC_FILTERS_LIST, "Normal"];
_listIndex = lbAdd [IDC_FILTERS_LIST, "Star Light"];
_listIndex = lbAdd [IDC_FILTERS_LIST, "W-FLIR"];
_listIndex = lbAdd [IDC_FILTERS_LIST, "B-FLIR"];

_zoom_Level_Index = lbAdd [IDC_ZOOM_LEVEL_LIST, "High"];
lbSetData [IDC_ZOOM_LEVEL_LIST, _zoom_Level_Index, "200"];
_zoom_Level_Index = lbAdd [IDC_ZOOM_LEVEL_LIST, "Medium"];
lbSetData [IDC_ZOOM_LEVEL_LIST, _zoom_Level_Index, "100"];
_zoom_Level_Index = lbAdd [IDC_ZOOM_LEVEL_LIST, "Low"];
lbSetData [IDC_ZOOM_LEVEL_LIST, _zoom_Level_Index, "50"];


AW_Sat_Camera = "camera" camcreate [0, 0, 0];
AW_Sat_Camera cameraEffect [ "internal", "back" ];
showCinemaBorder false;

while {AW_SatView_ON}do{
	_camera_target = [(getpos Player select 0)+ 3, (getpos Player select 1) + 18, getpos Player select 2];
	AW_Sat_Camera camPrepareTarget _camera_target;
	AW_Sat_Camera camSetPos [getpos Player select 0, getpos Player select 1, (getpos Player select 2) + AW_SatView_Z_Pos];
	AW_Sat_Camera camCommitPrepared 0;
	//kill cam and close dialog condition
    if ( !( alive player ) || !( dialog ) ) exitWith{
        titleCut["", "Black In", 0.01 ];
        titleText["", "Plain", 0.01 ];
		if ( !( isnull AW_Sat_Camera ) ) then{
           AW_Sat_Camera cameraeffect [ "terminate", "back" ];
           camDestroy AW_Sat_Camera;
        };
        if(dialog)then{closeDialog 0;};
        AW_SatView_ON = false;
		//deleteVehicle _camera_Target;
		player groupChat "Exited Sat view";
    };
};
