//Paras
params [
"_defenderAICountInput",
"_defenderFaction",
"_missionLocation",
"_compoundRadius",
"_usClasses",
"_ruClasses"
];

_grpSizes = [1,2,3,4,5];
_defenderGrpSizes = [];
_defenderAICount = _defenderAICountInput;

while {_defenderAICount > 0} do 
{
	_grpSize = selectRandom _grpSizes;

	if (_grpSize <= _defenderAICount) then 
	{
		_defenderAICount = _defenderAICount - _grpSize;
		_defenderGrpSizes pushBack _grpSize;
	};
};

//spawn defender groups 
_classes = _ruClasses;

if (_defenderFaction == "US") then 
{
	_classes = _usClasses;
};

{
	_size = _x;
	_spawnPos = [_missionLocation, 0, _compoundRadius, 1, 0, 20, 0, [], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;

	[
		["pvpDefend", _size, _spawnPos, _missionLocation, [], _classes, "pvp_defend", _compoundRadius]
	] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]]; //spawn bia_spawn_group; //
} forEach _defenderGrpSizes;

_text = format["Defenders have %1 supporting AIs", _defenderAICountInput];
["PvP_Defense", _text] spawn bia_to_log;