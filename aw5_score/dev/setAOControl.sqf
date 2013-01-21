hint "Click on the AO, to change the control.\n\nHold shift or alt while clicking to cancel the action.";

AW_newAOControl = _this select 0;

onMapSingleClick "
	if (_shift || _alt) then{
		onMapSingleClick '';
		hint 'No longer setting AO control';
	}else{
		_x =_pos select 0;
		_y =_pos select 1;
		
		_ClosestAONumber = [_x,_y]call GetAOMarker;
		if (_ClosestAONumber == -1) then{
			player sidechat 'No AO found';
		}else{
			
			player sidechat format['AO %1 control is now %2',_ClosestAONumber,AW_newAOControl];
			_AOMarkerName = format['AW_AO_%1',_ClosestAONumber];
			
			_foundIndex = -1;
			
			{
				if ((_x select 0) == _ClosestAONumber) then{
					_foundIndex = _forEachIndex;
				};
			}forEach AW_c5_AOcontrol;
			
			if (_foundIndex == -1) then{
				AW_c5_AOcontrol set[count AW_c5_AOcontrol,[_ClosestAONumber,AW_newAOControl]];
			}else{
				AW_c5_AOcontrol set[_foundIndex,[_ClosestAONumber,AW_newAOControl]];
			};
			
			switch(AW_newAOControl)do{
				case(-1):{_AOMarkerName setMarkerColor 'ColorGreen';};
				case(0):{_AOMarkerName setMarkerColor 'ColorRed';};
				case(1):{_AOMarkerName setMarkerColor 'ColorBlue';};
			};
		};
	};
";