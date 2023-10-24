//Paras
params [
"_grpType",
"_size", 			//either int or arr of build pos
"_spawnPos",
"_targetPos",
"_infantry",
"_debug"
];

_grp = createGroup east;

if (_grpType == "Patrol") then
{
	for "_i" from 1 to _size do 
	{
		_infClass = selectRandom _infantry;
		_soldier = _grp createUnit [_infClass, _spawnpos, [], 5, "NONE"];
		
		[_soldier, ["patrolBool", true]] remoteExec ["setVariable", 0, true];
		//_soldier setVariable ["patrolBool", true];
		
		_soldier addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];
	};

	[_grp, getPos leader _grp, _targetPos, _debug] spawn bia_group_patrol;
};

if (_grpType == "Guard") then
{
	{
		_buildingPos = _x;
		
		_infClass = selectRandom _infantry;
		_soldier = _grp createUnit [_infClass, _buildingPos vectorAdd [0,0,0.5], [], 0, "NONE"];
		
		[_soldier, ["guardBool", true]] remoteExec ["setVariable", 0, true];
		//_soldier setVariable ["guardBool", true];
		
		doStop _soldier;
		_soldier disableAI "PATH";
		_soldier addMPEventHandler ["MPKilled", { _nul = _this call killedManInfo; }];
		
		//Turn soldier to the outside (only works for leader since others turn same direction)
		_soldierToHouse = _soldier getRelDir _buildingPos;
		_soldier setDir (direction _soldier + (180 + _soldierToHouse));
	} forEach _size;
	
	//spawnpos here cqb activation distance
	[units _grp, _spawnPos] spawn bia_cqb_control;
};

_grp deleteGroupWhenEmpty true;