params [
"_player"
];

//Play sound
_playerStats = getPlayerScores _player;
_deaths = 0;

if (count _playerStats > 0) then 
{
	_deaths = _playerStats select 4;
};

if (_deaths < 1) then 
{
	playMusic selectRandom["round1"];
} else
{
	//Add death to stats
	[_player, true] remoteExec ["bia_add_death", 2];

	playMusic selectRandom["fatality"];
};