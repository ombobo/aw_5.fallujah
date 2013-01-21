private["_passedArgument","_AW_bluTotal","_AW_redTotal"];

_passedArgument = _this;
_AW_bluTotal = _passedArgument select 0;
_AW_redTotal = _passedArgument select 1;

//----- set controlled territories to 0 to stop any scoring
AW_bluTerritories = 0;
AW_redTerritories = 0;

//----- allow the victor to pick the next AO and PV it
switch(true)do{
	case(_AW_bluTotal > _AW_redTotal):{
		AW_allowAOPick = west;
		//AW_c5_AOcontrol set[AW_activeAO,1];
	};
	case(_AW_bluTotal < _AW_redTotal):{
		AW_allowAOPick = east;
		//AW_c5_AOcontrol set[AW_activeAO,0];
	};
	default{};
};

{
	if ((_x select 0) == AW_activeAO) then{
		switch(AW_allowAOPick)do{
			case(west):{AW_c5_AOcontrol set[_forEachIndex,[AW_activeAO,1]];};
			case(east):{AW_c5_AOcontrol set[_forEachIndex,[AW_activeAO,0]];};
		};
	};
}forEach AW_c5_AOcontrol;

publicVariable "AW_allowAOPick";
publicVariable "AW_c5_AOcontrol";

