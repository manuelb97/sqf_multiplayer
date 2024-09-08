//{ deleteMarker _x; } forEach allMapMarkers;

//Paras
params [
"_clearedPosArr",
["_debug", true]
];

_tag = "MarkClearedBuildings";
[_tag, format["Marking %1 Sectors as cleared", count _clearedPosArr]] spawn bia_to_log;

if (count _clearedPosArr > 0) then
{
	{
		_clearedPos = _x;
		_closeMarkers = allMapMarkers select {getMarkerPos _x distance2D _clearedPos < 10};
		if (count _closeMarkers > 0) then 
		{
			_nearestMarker = [_closeMarkers, _clearedPos] call BIS_fnc_nearestPosition;
			_nearestMarker setMarkerColor "colorBLUFOR";
		};
	} forEach _clearedPosArr;
};