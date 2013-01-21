"AW_PV_logBMPTeloDamage" addPublicVariableEventhandler {
	diag_log text "";
	diag_log text format["new telo: %1, time: %2",AW_PV_logBMPTeloDamage,(diag_tickTime - fl_BattleInitTime) / 60];
	diag_log text "";
};

"AW_PV_logBMPMotorDamage" addPublicVariableEventhandler {
	diag_log text "";
	diag_log text format["new motor: %1, time: %2",AW_PV_logBMPMotorDamage,(diag_tickTime - fl_BattleInitTime) / 60];
	diag_log text "";
};