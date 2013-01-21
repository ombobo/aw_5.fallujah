//_bluScore = fl_TotalScore select 0;
//_redScore = fl_TotalScore select 1;

AW_OutroText = "";
AW_newOutroText = false;

_composeText = {
	{
		AW_OutroText = AW_OutroText + _x;
	}forEach _this;
	AW_newOutroText = true;
};

1 cutText ["","BLACK", 3];

sleep 3;

player enableSimulation false;
player action ["engineOff", vehicle player];
player action ["autoHover", vehicle player];

_line1 = "The Mission Has Been Completed." + "\n" + "Both sides are ordered to retreat to continue the fight another day." + "\n\n";
//_line3 = "|=== Area control ===|" + "\n";
//_line4 = format["BluFor: %1 | RedFor: %2",_bluScore,_redScore] + "\n";
_line5 = "\n" + "|=== Casualties ===|" + "\n";
_line6 = format["BluFor: %1 | RedFor: %2",AW_westCasualties,AW_eastCasualties] + "\n";
_line9 = "\n" + "We hope you had a good time." + "\n";
_line10 = "Debrief starts now";

[] spawn {
	while{true}do{
		waitUntil{AW_newOutroText};
		3 cutText [AW_OutroText, "PLAIN"];
		AW_newOutroText = false;
		waitUntil{AW_newOutroText};
		2 cutText [AW_OutroText, "PLAIN"];
		AW_newOutroText = false;
	};
};

[_line1] call _composeText;
sleep 6;
//[_line3,_line4] call _composeText;
//sleep 10;
[_line5,_line6] call _composeText;
sleep 10;
//[_line7,_line8] call _composeText;
//sleep 10;
[_line9] call _composeText;
sleep 5;
[_line10] call _composeText;
sleep 15;

diag_log text ""; 
diag_log text format["|===========================   END %1   ===========================|", missionName];
diag_log text "";
endMission "END1";