//Paras
params [
"_target", 
"_caller", 
"_arguments"
];

_playersOutsideHQ = allPlayers select {_x distance2D hq_pos > 200};
_enemies = allUnits select {side _x == east};
_playersOutsideHQ = _playersOutsideHQ select 
{
	_player = _x;
	_dists = _enemies apply {_player distance2D _x};
	_ret = false;

	if (selectMin _dists > 250 && count _enemies > 0) then 
	{
		_ret = true;
	};

	_ret
};

if (count _playersOutsideHQ > 0) then 
{
	{
		_x setPosATL (getPosATL hq_pos);
	} forEach _playersOutsideHQ;

	format["Teleported following players to HQ: %1", _playersOutsideHQ] remoteExec ["hint", _caller];
} else 
{
	composeText ["Nobody to teleport back to HQ", lineBreak, "or Enemies nearby"] remoteExec ["hint", _caller];
};