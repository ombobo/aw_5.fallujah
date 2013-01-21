IDC_AMMO_LIST = 9102;
IDC_DISPERS_LIST = 9103;
IDC_LOAD_LIST = 9104;
IDC_STATUS_SET = 9109;
sleep 0.5;
_dlg = createdialog "AW_artyDialog";

/////Dispersion settings
_index = lbAdd [IDC_DISPERS_LIST, "25 Meters"];
lbSetData [IDC_DISPERS_LIST, _index, "13"];
_index = lbAdd [IDC_DISPERS_LIST, "50 Meters"];
lbSetData [IDC_DISPERS_LIST, _index, "25"];
_index = lbAdd [IDC_DISPERS_LIST, "100 Meters"];
lbSetData [IDC_DISPERS_LIST, _index, "50"];

/////rounds loaded
_index2 = lbAdd [IDC_LOAD_LIST, "1 Round"];
lbSetData [IDC_LOAD_LIST, _index2, "1"];
_index2 = lbAdd [IDC_LOAD_LIST, "2 Rounds"];
lbSetData [IDC_LOAD_LIST, _index2, "2"];
_index2 = lbAdd [IDC_LOAD_LIST, "3 Rounds"];
lbSetData [IDC_LOAD_LIST, _index2, "3"];
_index2 = lbAdd [IDC_LOAD_LIST, "4 Rounds"];
lbSetData [IDC_LOAD_LIST, _index2, "4"];
_index2 = lbAdd [IDC_LOAD_LIST, "5 Rounds"];
lbSetData [IDC_LOAD_LIST, _index2, "5"];

/////Ammo Types
_index3 = lbAdd [IDC_AMMO_LIST, "White Illumination"];
lbSetData [IDC_AMMO_LIST, _index3, "F_40mm_White"];
_index3 = lbAdd [IDC_AMMO_LIST, "Red Illumination"];
lbSetData [IDC_AMMO_LIST, _index3, "F_40mm_Red"];
_index3 = lbAdd [IDC_AMMO_LIST, "Green Illumination"];
lbSetData [IDC_AMMO_LIST, _index3, "F_40mm_Green"];
_index3 = lbAdd [IDC_AMMO_LIST, "White Smoke"];
lbSetData [IDC_AMMO_LIST, _index3, "AW_SmokeShell"];
_index3 = lbAdd [IDC_AMMO_LIST, "Red Smoke"];
lbSetData [IDC_AMMO_LIST, _index3, "AW_SmokeShell_Red"];
_index = lbAdd [IDC_AMMO_LIST, "Green Smoke"];
lbSetData [IDC_AMMO_LIST, _index, "AW_SmokeShell_Green"];

if (AW_FireMission) then {		
	//9109 ctrlSetTextColor [1, 0, 0, 1];
	ctrlSetText  [9109 ,"Fire Support Busy"];
}else{
	//9109 ctrlSetTextColor [0, 1, 0, 1];
	ctrlSetText  [9109 ,"Fire Support Ready"];
};
///ammo deductions
if (side player == west) then {	
	AW_FM_markerWest = createMarkerLocal ["FM", AW_FM_PositionWest];                                         
	AW_FM_markerWest setMarkerSizeLocal [0.5,0.5];                                       
	AW_FM_markerWest setMarkerColorLocal "ColorRed";
	AW_FM_markerWest setMarkerTypeLocal "FireMission";
	AW_FM_markerWest setMarkerTextLocal "Fire Mission";	
	ctrlSetText  [9106 ,format["Ammo Supply %1",AW_westArtyAmmo ]];
};
if (side player == east) then {		
	AW_FM_markerEast = createMarkerLocal ["FM", AW_FM_PositionEast];                                         
	AW_FM_markerEast setMarkerSizeLocal [0.5,0.5];                                       
	AW_FM_markerEast setMarkerColorLocal "ColorRed";
	AW_FM_markerEast setMarkerTypeLocal "FireMission";
	AW_FM_markerEast setMarkerTextLocal "Fire Mission";
	ctrlSetText [9106 ,format["Ammo Supply %1",AW_EastArtyAmmo ]];
};
ctrlSetText [9105 ,format["Rounds Loaded %1", AW_RoundsLoaded]];
ctrlSetText [9107 ,format["Dispersion %1",(AW_artyDispersion* 2)]];
ctrlSetText [9108 ,format["Ammo Type %1",AW_artyAmmoType ]];
waitUntil {not dialog};
if (side player == west) then {deleteMarker AW_FM_markerWest;};
if (side player == east) then {deleteMarker AW_FM_markerEast;};