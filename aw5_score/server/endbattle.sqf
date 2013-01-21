private["_AW_bluInfLosses","_AW_redInfLosses","_AW_bluEquipLosses","_AW_redEquipLosses"];

fl_AOsPlayed = fl_AOsPlayed + 1;

fl_BluAOPointsInfo = fl_BluAOScore / fl_AOPointLimit * 100;
fl_RedAOPointsInfo = fl_RedAOScore / fl_AOPointLimit * 100;

_AW_bluInfLosses = ((AW_westCasualties - fl_AOBluCasualties) * 0.1);
_AW_redInfLosses = ((AW_eastCasualties - fl_AORedCasualties) * 0.1);

_AW_bluEquipLosses = AW_westWarExpenditure - fl_AOBluWarExpenditure;
_AW_redEquipLosses = AW_eastWarExpenditure - fl_AORedWarExpenditure;

[]execVM "core\functions\dumpPerformanceArrays.sqf";



fl_BluTotalScore = fl_BluTotalScore + fl_BluAOPointsInfo - _AW_bluInfLosses - _AW_bluEquipLosses;
fl_RedTotalScore = fl_RedTotalScore + fl_RedAOPointsInfo - _AW_redInfLosses - _AW_redEquipLosses;

fl_TotalScore = [fl_BluTotalScore,fl_RedTotalScore];
PublicVariable "fl_TotalScore";
publicVariable "AW_westCasualties";
publicVariable "AW_eastCasualties";

//AW_civDamageByBlu = round (AW_civDamageByBlu * 100);
//AW_civDamageByRed = round (AW_civDamageByRed * 100);

//publicVariable "AW_civDamageByBlu";
//publicVariable "AW_civDamageByRed";

//LOG
diag_log text "";
diag_log text "=============================================";
diag_log text format ["Result for AO %1",fl_AOsPlayed];
diag_log text "============= New Total =============";
diag_log text format ["BluFor: %1, RedFor: %2",fl_BluTotalScore,fl_RedTotalScore];
diag_log text "============= AO control =============";
diag_log text format ["BluFor: %1, RedFor: %2",fl_BluAOPointsInfo,fl_RedAOPointsInfo];
diag_log text "============= Losses =============";
diag_log text format ["Inf: BluFor: %1, RedFor: %2",_AW_bluInfLosses,_AW_redInfLosses];
diag_log text format ["Vcl: BluFor: %1, RedFor: %2",_AW_bluEquipLosses,_AW_redEquipLosses];
diag_log text "=============================================";
diag_log text "";
diag_log text "=============================================";
diag_log text format ["Game ended after %1 AOs",fl_AOsPlayed];
diag_log text "============= Score =============";
diag_log text format ["BluFor: %1, RedFor: %2",fl_BluTotalScore,fl_RedTotalScore];
diag_log text "============= Casualties =============";
diag_log text format ["BluFor: %1, RedFor: %2",AW_westCasualties,AW_eastCasualties];
//diag_log text "============= Collateral Damage =============";
//diag_log text format ["BluFor: %1, RedFor: %2",AW_civDamageByBlu,AW_civDamageByRed];
diag_log text "=============================================";
diag_log text "";

[]execVM "core\functions\dumpPerformanceArrays.sqf";