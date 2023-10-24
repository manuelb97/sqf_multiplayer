//Paras
params [
["_cqbUnitsArr", []],
["_triggerDistOld", 15],
"_chanceToLeaveBuilding"
];

//only select units which are covered by building 
_cqbUnitsArr = _cqbUnitsArr select 
{
	_cqbUnit = _x;
	_cqbUnitPos = AGLToASL(getPos _cqbUnit) vectorAdd [0,0,1.8];
	lineIntersects [_cqbUnitPos, _cqbUnitPos vectorAdd [0, 0, 3]] 
	&& 
	(
		lineIntersects [_cqbUnitPos, _cqbUnitPos vectorAdd [0, 2, 0]]
		|| lineIntersects [_cqbUnitPos, _cqbUnitPos vectorAdd [2, 0, 0]]
	)
};

//disable ai pathing and force standing 
{
	_x setUnitPos "UP";
	_x disableAI "PATH";
	group _x setVariable ["Vcm_Disable", true];
} forEach _cqbUnitsArr;

//Delete units from the array to have some guards in houses
if (count _cqbUnitsArr > 1) then 
{
	// only allow X% to leave their pos
	_delUnits = [];
	{
		if (random 1 >= _chanceToLeaveBuilding) then 
		{
			_delUnits pushBack _x;
		};
	} forEach _cqbUnitsArr;

	_cqbUnitsArr = _cqbUnitsArr - _delUnits;
};

//Movement system
while {count _cqbUnitsArr > 0} do 
{
	uiSleep 1;
	
	_deleteIdxArr = [];
	{
		_cqbUnit = _x;
		_cqbUnitPos = getPos _cqbUnit;
		_players = allPlayers;
		
		_triggerDist = random [_triggerDistOld * 0.5, _triggerDistOld * 0.75, _triggerDistOld];
		_idxClosePlayer = _players findIf {_x distance _cqbUnit < _triggerDist};
		
		if (_idxClosePlayer != -1 && selectRandom[true,false,false,false]) then 
		{
			_cqbUnit enableAI "PATH";
			//_cqbUnit setUnitPos "AUTO";
			_targetPlayer = _players select _idxClosePlayer;
			_cqbUnit doTarget _targetPlayer;
			_cqbUnit doMove (getPos _targetPlayer);
			
			_deleteIdxArr pushBack _forEachIndex;
		};
	} forEach _cqbUnitsArr;
	
	{ _cqbUnitsArr deleteAt _x; } forEach _deleteIdxArr;
};