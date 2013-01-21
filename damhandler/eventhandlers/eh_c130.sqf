//this shouldnt be here at all (not in the 'damage'handler)

if (isDedicated) exitWith{};

_this select 0 addAction ['Parachute', 'parafix.sqf', '', 0, false, true, '', '(_this in _target) && ((getPos player select 2) > 25)'];