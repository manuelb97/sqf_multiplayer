params [
"_player", "_oldUnit"
];

if (isMultiplayer && missionNamespace getVariable ["SideMissionActive", false]) then
{
	if (((getPlayerScores _player) select 4) > 0) then 
	{
		_marker = "playerDeathMarker_" + (str getPlayerUID _player);
		_deathPos = getPos _oldUnit;

		// hint str _deathPos;

		if (getMarkerColor _marker == "") then 
		{
			createMarker [_marker, _deathPos];
			_marker setMarkerTypeLocal "KIA";
			_marker setMarkerColorLocal "ColorGreen";
			_marker setMarkerSize [0.75, 0.75];
		} else 
		{
			_marker setMarkerPos _deathPos;
		};
	};
};