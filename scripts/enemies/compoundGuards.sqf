//Paras
params [
"_posArr",
"_cqbDist",
"_infantry",
"_varName",
"_debug"
];

_tag = "CompoundHouseGuards";

//spawn guards 
_chanceToLeaveBuilding = 0.33;
[
	["Guard", _posArr, _cqbDist, _chanceToLeaveBuilding, _infantry, _varName, _debug]
] remoteExec ["bia_spawn_group", missionNamespace getVariable ["BiA_Host", 2]]; //spawn bia_spawn_group; //
[_tag, "Spawned house guards", _debug] spawn bia_to_log;

/*

"_grpType",
"_size", 			//either int or arr of build pos
"_spawnPos",
"_targetPos",
"_positions",
"_infantry",
"_debug"