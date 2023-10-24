// [getPos player] call compileFinal preprocessFileLineNumbers "scripts\missions\house_raids\determine_faction.sqf";

params [
"_pos"
];

_tiers = ["Tier_4"];

_nearestMarker = [allMapMarkers select {markerShape _x == "ELLIPSE"}, _pos] call BIS_fnc_nearestPosition;

if (_pos inArea _nearestMarker) then 
{
	_markerColor = markerColor _nearestMarker;

	switch (_markerColor) do
	{
		case "ColorRed": { _tiers = ["Tier_1"] };
		case "ColorBlue": { _tiers = ["Tier_2"] };
		case "ColorGreen": { _tiers = ["Tier_3"] };
	};
};

[_tiers, [_tiers, "infantry"] call bia_faction_mix]