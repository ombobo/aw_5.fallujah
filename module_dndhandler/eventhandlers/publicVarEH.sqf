////////////////////////////////////
//----- Client Eventhandlers -----//
////////////////////////////////////

if (!isDedicated) then{
	"PublicDebugMessage" addPublicVariableEventHandler {player sidechat (_this select 1);};
	"PublicDebugDamMessage" addPublicVariableEventHandler {player sidechat (_this select 1);};
	
	//--- Server sends this PV, when a new vehicle is created
	"AW_RespawningVehicle" addPublicVariableEventHandler {[(_this select 1)]call fnc_RenewDamageEventhandler;};
	
	[]spawn fnc_checkEH; //--- Keep checking if an EH is set for the vehicle you are getting in
	[]spawn fnc_syncdamagetoserver; //--- Keep checking when a sync of the vehicles damage is required
	
	//----- add EH to the player himself
	[player]call fnc_RenewDamageEventhandler;
	
	"AW_DH_replyArray" addPublicVariableEventHandler {
		private["_vehicle","_gethitarray","_selections","_i"];
		_vehicle = AW_DH_replyArray select 0;
		_gethitarray = AW_DH_replyArray select 1;
		
		//diag_log AW_DH_replyArray;
		//diag_log format["vcl: %1, array: %2",_vehicle,_gethitarray];
		
		_vehicle setVariable["gethit",_gethitarray,false];
		
		//player sidechat format["#DEBUG: Received GetHit Array for vehicle %1",_vehicle];
		//player sidechat format["%1",_gethitarray];
		AW_DH_synced = true;
		
		if (count AW_DH_replyArray > 2) then{
			_selections = _vehicle getVariable ["selections", []];
			_i = 0;
			//player sidechat "#DEBUG: accepting repair values";
			{
				_vehicle setHit [_x, _gethitarray select _i];				
				_i = _i + 1;
			}forEach _selections;
		};
	};
	
	"AW_DH_forceOwnerToSync" addPublicVariableEventHandler {
		//senderID,vehicle,_ownerID
		private["_senderID","_vehicle","_gethitarray"];
		_senderID = AW_DH_forceOwnerToSync select 0;
		_vehicle = AW_DH_forceOwnerToSync select 1;
		_ownerID = AW_DH_forceOwnerToSync select 2;
		_gethitarray = _vehicle getVariable["gethit",[]];
		
		if (_ownerID != _senderID) then{
			AW_DH_replyArray = [_vehicle,_gethitarray];
			_senderID publicVariableClient "AW_DH_replyArray";
			//player sidechat format["#DEBUG: forced sync for vehicle: %1, to player ID: %2, with array: %3",_vehicle,_senderID,_gethitarray];
			//also syncing to Server
			AW_DH_relayGetHitArray = [_vehicle,_gethitarray,player];
			publicVariableServer "AW_DH_relayGetHitArray";
		}else{
			AW_DH_synced = true;
			//diag_log "tempfix... seems like you requested an array for a vehicle thats local to your machine";
		};
	};
};

////////////////////////////////////
//----- Server Eventhandlers -----//
////////////////////////////////////

if (isServer) then{
	"AW_DH_relayGetHitArray" addPublicVariableEventHandler {
		//vehicle,gethitarray,from
		private["_vehicle","_array","_ownerID","_sentFrom","_senderID","_selections","_i"];
		_vehicle = AW_DH_relayGetHitArray select 0;
		_array = AW_DH_relayGetHitArray select 1;
		_sentFrom = AW_DH_relayGetHitArray select 2;
		
		_ownerID = owner _vehicle;
		_senderID = owner _sentFrom;
		
		_vehicle setVariable["gethit",_array,false];
		
		AW_DH_replyArray = [_vehicle,_array,true];
		
		switch(true)do{
			case (_ownerID == _senderID):{diag_log text "|========== Not relaying the array because the sender is the owner";};
			case (local _vehicle):{
				diag_log text "|========== Not relaying the array because the vehicle is local to the server";
				
				_selections = _vehicle getVariable ["selections", []];
				_i = 0;
				diag_log text "|========== Accepting repair values";
				{
					_vehicle setHit [_x, _array select _i];				
					_i = _i + 1;
				}forEach _selections;
			};
			default {
				_ownerID publicVariableClient "AW_DH_replyArray";
				diag_log text format["|========== Relaying GetHit array to ID: %1, with Array: %2",_ownerID,AW_DH_replyArray];
			};
		};
	};
	
	"AW_DH_requestArray" addPublicVariableEventHandler {
		private["_requestedBy","_vehicle","_array","_senderID","_ownerID"];
		_requestedBy = AW_DH_requestArray select 0;
		_vehicle = AW_DH_requestArray select 1;
		_array = _vehicle getVariable ["gethit",[]];
		
		_senderID = owner _requestedBy;
		_ownerID = owner _vehicle;
		
		//diag_log format["by: %1, vcl: %2",_requestedBy,_vehicle];
		
		switch(true)do{
			case (count AW_DH_requestArray > 2):{
				diag_log text format["|========== Player %1 just got into %2 and is requesting its array.",_senderID,_vehicle];
				AW_DH_replyArray = [_vehicle,_array];
				_senderID publicVariableClient "AW_DH_replyArray";
				diag_log text format["|========== sending GetHit array to ID: %1, for vehicle: %2, with Array: %3",_senderID,_vehicle,AW_DH_replyArray];
			};
			case (_ownerID == _senderID):{
				//diag_log "#DEBUG: Not sending an answer because the sender is the owner"; //config needs to be changed to not wait for an answer if vehicle is local to that player
				AW_DH_forceOwnerToSync = [_senderID,_vehicle,_ownerID];
				_ownerID publicVariableClient "AW_DH_forceOwnerToSync";
			};
			case (local _vehicle):{
				AW_DH_replyArray = [_vehicle,_array];
				_senderID publicVariableClient "AW_DH_replyArray";
				diag_log text format["|========== Sending GetHit array to ID: %1, for vehicle: %2, with Array: %3",_senderID,_vehicle,AW_DH_replyArray];
			};
			case !(local _vehicle):{
				diag_log text format["|========== Vehicle not local! Forcing a sync from vehicle owner (ID: %1).",owner _vehicle];
				
				AW_DH_forceOwnerToSync = [_senderID,_vehicle,_ownerID];
				_ownerID publicVariableClient "AW_DH_forceOwnerToSync";
			};
			default {};
		};
	};
};