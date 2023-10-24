/*
[] call compileFinal preprocessFileLineNumbers "scripts\sectors\getMarkerSetup.sqf";
*/

//Get all markers of map build with all info
_sectorMarkers = [];

{
	if (_x != "respawn_west") then {
		_marker = _x;
		_markerType = markerType _marker;
		_markerColor = markerColor _marker;
		_markerPos = getMarkerPos _marker;
		_markerSize = markerSize _marker;
		_markerShape = markerShape _marker;
		_markerBrush = markerBrush _marker;
		_markerAlpha = markerAlpha _marker;
		_markerText = markerText _marker;
		_markerArr = [_markerType, _markerColor, _markerPos, _markerSize, _markerShape, _markerBrush, _markerAlpha, _markerText];
		_sectorMarkers = _sectorMarkers + [_markerArr];
	};
} forEach allMapMarkers;

_sectorMarkers

// Get marker distribution stats
/*
_lib = 0;
_defence = 0;
_hvt = 0;
_heist = 0;
_sab = 0;
_esc = 0;
_zombie = 0;

{
	if (markerType _x == "mil_marker")		then { _lib = _lib + 1; };
	if (markerType _x == "mil_flag")			then { _defence = _defence + 1; };
	if (markerType _x == "mil_end") 			then { _hvt = _hvt + 1; };
	if (markerType _x == "mil_unknown")	then { _heist = _heist + 1; };
	if (markerType _x == "mil_join") 			then { _sab = _sab + 1; };
	if (markerType _x == "mil_pickup") 		then { _esc = _esc + 1; };
	if (markerType _x == "mil_circle") 		then { _zombie = _zombie + 1; };
} forEach allMapMarkers;

hint format["Lib: %1\nDef: %2\nHVT: %3\nHeist: %4\nSab: %5\nEsc: %6\nZombie: %7",_lib,_defence,_hvt,_heist,_sab,_esc,_zombie];

format["Lib: %1, Def: %2, HVT: %3, Heist: %4, Sab: %5, Esc: %6, Zombie: %7",_lib,_defence,_hvt,_heist,_sab,_esc,_zombie];
*/