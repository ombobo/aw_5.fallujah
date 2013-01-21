switch (true)do{
	case (isDedicated):{
		[]execVM "general_loop_scripts\server.sqf";
		[]execVM "general_loop_scripts\shared.sqf";
	};
	case (!isServer):{
		[]execVM "general_loop_scripts\client.sqf";
		[]execVM "general_loop_scripts\shared.sqf";
	};
	case (isServer):{
		[]execVM "general_loop_scripts\server.sqf";
		[]execVM "general_loop_scripts\client.sqf";
		[]execVM "general_loop_scripts\shared.sqf";
	};
	default {};
};