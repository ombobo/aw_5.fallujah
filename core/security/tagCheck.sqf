/*
* Created By Jones
* last updated 1/16/2012
*/
/*
	This file requires a string table in the root directory with the following entries
	STR_westArmyTag
	STR_eastArmyTag
	STR_refereeTag
*/
if (isMultiPlayer && isServer) exitWith{};
private["_getTagArray","_compareTags","_blockPlayerSimulation","_playerTag","_westArmyTag","_eastArmyTag","_refereeTag"];

/*
* Description: gets the first 4 characters from a string and places them in an array
* Paramters: String select 0
* Returns: Array of characters
*/
_getTagArray ={
	private["_tagString","_tagArray","_tag"];
	_tagString = _this select 0;
	_tagArray = toArray(_tagString);
	_tag = (_tagArray select 0) + (_tagArray select 1) + (_tagArray select 2) + (_tagArray select 3);
	//return
	_tag
};
/*
* Description: compares to tags for equality
* Paramters:  character array select 0, character array select 1
* Returns: boolean, true if tags are equal
*/
_compareTags ={
	private["_tag1","_tag2","_result"];
	_tag1 = _this select 0;
	_tag2 = _this select 1;
	_result = if(_tag1 == _tag2 || _tag1 == _refereeTag)then{true}else{false};
	//return
	_result
};
/*
* Description: diables controls and makes players screen black
* Paramters:  N/A
* Returns:N/A
*/
_blockPlayerSimulation ={
	CutText ["", "BLACK",0];
	TitleText ["Your Tags are incorrect or you joined the wrong side.", "BLACK",0];
	player enableSimulation false;
};
/////////////////////////////////////////////////////
// Script start
//////////////////////////////////////////////////////
_playerTag = [name player]call _getTagArray;
_westArmyTag = [localize "@STR_westArmyTag"]call _getTagArray;
_eastArmyTag = [localize "@STR_eastArmyTag"]call _getTagArray;
_refereeTag = [localize "@STR_refereeTag"]call _getTagArray;

switch(playerSide)do{
	case west:{
		if!([_playerTag,_westArmyTag]call _compareTags)then{
			[]call _blockPlayerSimulation;
		};
	};
	case east:{
		if!([_playerTag,_eastArmyTag]call _compareTags)then{
			[]call _blockPlayerSimulation;
		};
	};
	case resistance:{
		if!([_playerTag,_refereeTag]call _compareTags)then{
			[]call _blockPlayerSimulation;
		};
	};
	default{
		diag_log "Error: 'playerSide' no match found, tagcheck.sqf";
	};
};


