if (isServer) exitWith{};

//diag_log "###DEBUG: RestoreRating.sqf running";

while{true} do{
	if (rating player < 0) then{
		player addRating 10000;
		//diag_log format["###DEBUG: increasing your rating to %1 in RestoreRating.sqf",rating player];
		//player sidechat "#Info: Your hostily status has been corrected";
	};
	sleep 5;
};