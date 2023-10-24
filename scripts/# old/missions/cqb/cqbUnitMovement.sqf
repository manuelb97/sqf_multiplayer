/*
_cqbUnitsArr= [];
{if (side _x == east) then {_cqbUnitsArr = units _x};} forEach allGroups;
*/

//Paras
_cqbUnitsArr 		= param [0,[]];
_triggerDistOld	= param [1,40];

//Unit static stand
{
	_x setUnitPos "UP";
	_x disableAI "PATH";
	group _x setVariable ["Vcm_Disable",true];
} forEach _cqbUnitsArr;

//Delete units from the array to have some guards in houses
_remUnit = selectRandom[true, false];
if (_remUnit && (count _cqbUnitsArr > 1)) then
{
	_cqbUnitsArr deleteAt selectRandom[0, count _cqbUnitsArr - 1];
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
		//[format ["Player array: %1", _players]] remoteExec ["hint", 0, true]; uiSleep 3;
		
		_triggerDist = random [_triggerDistOld / 2, (_triggerDistOld / 2) + (_triggerDistOld / 4), _triggerDistOld];
		_idxClosePlayer = _players findIf {_x distance _cqbUnit < _triggerDist};
		//[format ["Index for player search: %1", _idxClosePlayer]] remoteExec ["hint", 0, true]; uiSleep 3;
		
		//_knownTargets = _cqbUnit nearTargets 200; || count _knownTargets > 0
		// if (count _knownTargets > 0) then 	{ _cqbUnit doMove ((selectRandom _knownTargets) select 0) };
		
		if (	!lineIntersects [AGLToASL _cqbUnitPos, (AGLToASL _cqbUnitPos) vectorAdd [0, 0, 3]] && 
				(!lineIntersects [AGLToASL _cqbUnitPos, (AGLToASL _cqbUnitPos) vectorAdd [0, 2, 0]] or 
				!lineIntersects [AGLToASL _cqbUnitPos, (AGLToASL _cqbUnitPos) vectorAdd [2, 0, 0]])) then 
			{
				_cqbUnit enableAI "PATH";
				_cqbUnit setUnitPos "AUTO";
			};
		
		if (_idxClosePlayer != -1 && selectRandom[true,false,false,false]) then 
		{
			_cqbUnit enableAI "PATH";
			_cqbUnit setUnitPos "AUTO";
			_targetPlayer = _players select _idxClosePlayer;
			_cqbUnit doTarget _targetPlayer;
			_cqbUnit doMove (getPos _targetPlayer);
			
			_deleteIdxArr pushBack (_cqbUnitsArr find _cqbUnit);
		};
	} forEach _cqbUnitsArr;
	
	{ _cqbUnitsArr deleteAt _x; } forEach _deleteIdxArr;
};