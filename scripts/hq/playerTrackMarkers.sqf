//Params
params [
"_updateTime",
"_debug"
];

_colors = ["ColorGreen", "ColorBlue", "ColorRed"]; //"ColorOrange", , "ColorCIV", "ColorPink"

while {true} do 
{
	_players = allPlayers;
	_playerMarkers = allMapMarkers select {"playerMarker" in _x};
	
	{
		_player = _x;
		_markers = _playerMarkers select {(str _player) in _x};

		if (count _markers < 1) then 
		{
			_color = selectRandom _colors;
			// _colors deleteAt (_colors find _color);

			_marker = "playerMarker_" + (str _player);
			createMarker [_marker, getPos _player];
			_marker setMarkerTypeLocal format["loc_Letter%1", toUpper((str _player) select [0, 1])];
			_marker setMarkerColorLocal _color;
			_marker setMarkerSize [1, 1];
		} else 
		{
			_marker = _markers select 0;
			_marker setMarkerPos (getPos _player);
		};
	} forEach _players;

	uiSleep _updateTime;
};