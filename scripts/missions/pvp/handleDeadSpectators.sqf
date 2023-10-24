//Paras
params [
"_pos",
"_dir"
];

_currentSpectators = [];
while 
{
	missionNamespace getVariable ["PvPMissionActive", false]
} do 
{
	_hqPlayers = allPlayers select {_x distance2D hq_pos < 100};
	_hqPlayers = _hqPlayers select {!(_x in _currentSpectators)};

	{
		_player = _x;
		_currentSpectators pushBack _player;

		[
			"Switching to spectator mode", "center_top", 10, 0, 0, 100, "Green"
		] remoteExec ["bia_spawn_text", _player];

		uiSleep 10;

		[_player, true, _pos, _dir] call bia_pvp_spectator;
	} forEach _hqPlayers;

	uiSleep 1;
};

{
	_player = _x;
	[_player, false, getPos hq_pos, random 360] call bia_pvp_spectator;
} forEach allPlayers;