/*
* Created By Jones
* last updated 1/16/2012
*/
_west = playersNumber west;
_east = playersNumber east;
_referees = playersNumber resistance;

hint format [
			"Players count\nWest = %1\nEast = %2\nReferees = %3\nTotal = %4\nWest Casualties %5\nEast Casualties %6\nWest Expend %7\nEast Expend %8",
			_west, 
			_east, 
			_referees, 
			_west + _east + _referees,	
			AW_westCasualties,
			AW_eastCasualties,
			AW_westWarExpenditure,
			AW_eastWarExpenditure
			];