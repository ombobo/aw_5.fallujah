diag_log text "======== Corner Array forced save ==========";
{
	if (typeName _x == "ARRAY") then{
		diag_log text format["%1%2",_x,","];
	};	
}forEach AW_c5_cornerArray;
diag_log text "======== AO Array forced save ==========";
{
	diag_log text format["%1%2",_x,","];
}forEach AW_c5_AOArray;
diag_log text "======== AO Control forced save ==========";
diag_log AW_c5_AOcontrol;

hint "AOs and corners saved to local RPT";