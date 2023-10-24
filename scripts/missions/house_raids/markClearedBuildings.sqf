//{ deleteMarker _x; } forEach allMapMarkers;

//Paras
params [
"_clearedPosArr"
];

_text = format["Marking %1 Buildings as cleared", count _clearedPosArr];
["MarkClearedBuildings", _text] remoteExec ["bia_to_log", 2, false]; 

if (count _clearedPosArr > 0) then
{
	{
		_clearedPos = _x;
		_nearestMarker = [allMapMarkers, _clearedPos] call BIS_fnc_nearestPosition;
		_nearestMarker setMarkerColor "ColorGreen";
		//[_nearestMarker, "ColorGreen"] remoteExec ["setMarkerColorLocal", 0, true]; 
	} forEach _clearedPosArr;
};