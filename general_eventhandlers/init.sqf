switch (true)do{
	case (isDedicated):{
		[]execVM "general_eventhandlers\server.sqf";
	};
	case (!isServer):{
		[]execVM "general_eventhandlers\client.sqf";
	};
	case (isServer):{
		[]execVM "general_eventhandlers\server.sqf";
		[]execVM "general_eventhandlers\client.sqf";
	};
	default {};
};