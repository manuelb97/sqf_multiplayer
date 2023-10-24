//Params
params [
"_delay",
"_debug"
];

_aimTag = "VehicleAim";
[_aimTag, "Started", _debug] spawn bia_to_log;

while {true} do 
{
	_veh = objectParent player;
	_turretMags = (_veh magazinesTurret [-1]) + (_veh magazinesTurret [0]); //driver + gunner mags

	if 
	(
		!(isNull _veh) 
		&& (typeOf _veh) != "B_Parachute"
		&& count _turretMags != 0
	) then 
	{
		[_aimTag, "Player in vehicle", _debug] spawn bia_to_log;

		_pos = screenToWorld [0.5,0.5];

		_aimMarkers = allMapMarkers select {"AimMarker" in _x && (str player) in _x};
		if (count _aimMarkers > 0) then 
		{
			[_aimTag, "Marker found", _debug] spawn bia_to_log;

			if (!visibleMap) then 
			{
				_marker = _aimMarkers select 0;
				_marker setMarkerPos _pos;
			};
		} else 
		{
			[_aimTag, "No marker found", _debug] spawn bia_to_log;
			
			_color = markerColor ("playerMarker_" + (str player));

			[_aimTag, format["Color: %1", _color], _debug] spawn bia_to_log;

			_marker = "AimMarker_" + (str player);
			createMarker [_marker, _pos];
			_marker setMarkerTypeLocal "mil_destroy";
			_marker setMarkerColorLocal _color;
			_marker setMarkerSize [1, 1];
		};
	};

	[_aimTag, format["Player %1 not in vehicle", player], _debug] spawn bia_to_log;

	uiSleep _delay;
};