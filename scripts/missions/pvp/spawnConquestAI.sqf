//Paras
params [
"_attackerAICountInput",
"_attackerFaction",
"_defenderUnits",
"_missionLocation",
"_compoundRadius",
"_ruClasses",
"_usClasses",
"_dir",
"_minDistance",
"_maxDistance"
];

_grpSizes = [1,2,3,4,5];
_attackerGrpSizes = [];
_attackerAICount = _attackerAICountInput;

while {_attackerAICount > 0} do 
{
	_grpSize = selectRandom _grpSizes;

	if (_grpSize <= _attackerAICount) then 
	{
		_attackerAICount = _attackerAICount - _grpSize;
		_attackerGrpSizes pushBack _grpSize;
	};
};

_classes = _ruClasses;

if (_attackerFaction == "US") then 
{
	_classes = _usClasses;
};

{
	_size = _x;
	// _spawnPos = [_missionLocation, 500, 750, 1, 0, 20, 0, [], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;
	_posCorrectDir = false;
	private "_spawnPos";

	while {!_posCorrectDir} do 
	{
		_spawnPos = [_missionLocation, _defenderUnits, 1, _minDistance, _maxDistance] call bia_concealed_pos;

		if (count _spawnPos < 1) then 
		{
			_fallBackPos = _missionLocation getPos [selectRandom [_minDistance, _maxDistance], random 360];
			_spawnPos = [_missionLocation, _minDistance, _maxDistance, 1, 1, 20, 0, [], [_fallBackPos, _fallBackPos]] call BIS_fnc_findSafePos;
		};

		_spawnDir = _missionLocation getDir _spawnPos;

		if (_dir select 0 < _dir select 1) then 
		{
			if (_spawnDir >= (_dir select 0) && _spawnDir <= (_dir select 1)) then 
			{
				_posCorrectDir = true;
			};
		} else 
		{
			if (_spawnDir >= (_dir select 0) || _spawnDir <= (_dir select 1)) then 
			{
				_posCorrectDir = true;
			};
		};
	};

	[
		["pvpAttack", _size, _spawnPos, _missionLocation, [], _classes, "pvp_attack", _compoundRadius]
	] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]]; //spawn bia_spawn_group; //
} forEach _attackerGrpSizes;

_text = format["Attackers have %1 supporting AIs", _attackerAICountInput];
["PvP_Defense", _text] spawn bia_to_log;