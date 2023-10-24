//Paras
_inputArray = param [3,[]];
_action = _inputArray select 0;

//Spawn cqb stuff
if (_action) then {
	//Prep CQB Training
	0 = [getPosATL cqb_training, 0, call (compile (preprocessFileLineNumbers "scripts\range\cqbTraining\cqbBuilding.sqf"))] call BIS_fnc_ObjectsMapper;

	_targets = cqb_training nearObjects 50;
	_targets = _targets select {"target" in str _x};

	//Reset points
	{ 
		_x setVariable ["points", 0, true]; 
	} forEach allPlayers;

	//Check start time
	_startTime = serverTime;

	//Add targets
	_grp = createGroup east;
	{
		_targetPos = getPosATL _x;
		_targetDir = (getDir _x) + 180;
		deleteVehicle _x;
		
		_unit = _grp createUnit ["O_bia_bandits_rifleman_akm", [0,0,0], [], 0, "NONE"];
		_unit setPosATL _targetPos;
		_unit setDir _targetDir;
		[_unit, true] call ACE_captives_fnc_setHandcuffed;
		
		//Add hit event handler to target
		[_unit] execVM "scripts\range\targetScoreEventHandler.sqf";
	} forEach _targets;

	//Wait till all targets died
	_targetsLeft = (units _grp) select {alive _x};
	while { count _targetsLeft > 0 } do 
	{ 
		uiSleep 1;
		_targetsLeft = (units _grp) select {alive _x};
	};

	//Show time needed to eliminate all
	_stopTime = serverTime;
	_totalTime = [_stopTime - _startTime, 2] call BIS_fnc_cutDecimals;
	hint format["Time taken to finish training: %1s", _totalTime];
} else {
	//Delete cqb stuff
	_cqbTrainingObjs = cqb_training nearObjects 50;
	_cqbTrainingObjs = _cqbTrainingObjs select {"O " in str _x};
	{deleteVehicle _x;} forEach _cqbTrainingObjs;
	//deleteVehicle cqb_building;
	{ deleteVehicle _x; } forEach allDeadMen;
};