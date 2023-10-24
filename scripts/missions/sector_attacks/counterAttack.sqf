//Paras
params [
"_marker",
"_isHQ",
"_debug"
];

_tag = "CounterAttack";
missionNamespace setVariable ["CounterAttackOngoing", true, true];

//Get info
_targetPos = getMarkerPos _marker;
_varName = _marker + "_CounterAttack";
_currAggro = missionNamespace getVariable ["Aggression", 0];
_tier = "Tier_4";
_insertionType = "Ground";
_numCombatVehicles = 2;
_numEnemies = 12;

if (_currAggro >= 25 && _currAggro < 50) then 
{
	_tier = "Tier_3";
	_insertionType = selectRandom["Ground", "Ground", "Air"];
	_numCombatVehicles = 2;
	_numEnemies = 15;
} else 
{
	if (_currAggro >= 50 && _currAggro < 75) then 
	{
		_tier = "Tier_2";
		_insertionType = selectRandom["Ground", "Air"];
		_numCombatVehicles = 3;
		_numEnemies = 18;
	} else 
	{
		if (_currAggro >= 75) then 
		{
			_tier = "Tier_1";
			_insertionType = selectRandom["Ground", "Air", "Air"];
			_numCombatVehicles = 3;
			_numEnemies = 20;
		};
	};
};

_insertionType = "Ground"; // ground only for now 

_infantryClasses = [[_tier], "Infantry", _debug] call bia_get_tier_cat;
_combatVehClasses = [[_tier], "CombatVehicle", _debug] call bia_get_tier_cat;
_transportClasses = [[_tier], "Transport", _debug] call bia_get_tier_cat;
_heliClasses = [[_tier], "Heli", _debug] call bia_get_tier_cat;

//Determine vehicles for attack
_vehicleClasses = [];
if (_insertionType == "Ground") then 
{
	for "_i" from 1 to _numCombatVehicles do 
	{
		_vehicleClasses pushBack [selectRandom _combatVehClasses, "Combat"];
	};

	for "_i" from 1 to 4 do 
	{
		_vehicleClasses pushBack [selectRandom _transportClasses, "Transport"];
	};
} else 
{
	for "_i" from 1 to 4 do 
	{
		_vehicleClasses pushBack [selectRandom _heliClasses, "Transport"];
	};
};

_remainingNumEnemies = _numEnemies;
_finalVehicles = [];
{
	_vehArr = _x;
	_vehicleClass = _vehArr select 0;
	_vehicleType = _vehArr select 1;

	_seats = [_vehicleClass, false] call BIS_fnc_crewCount;
	if (_vehicleType == "Transport") then 
	{
		_seats = [_vehicleClass, true] call BIS_fnc_crewCount;
	};

	if (_remainingNumEnemies >= 0) then 
	{
		_finalVehicles pushBack _vehArr;
	};

	_remainingNumEnemies = _remainingNumEnemies - _seats;
} forEach _vehicleClasses;

[_tag, format["Tier: %1, Type: %2, Number Vehicles: %3", _tier, _insertionType, count _finalVehicles], _debug] spawn bia_to_log;

//Spawn attack groups
_fallBackPos = _targetPos getPos [random[800,1000,1200], random 360];
_spawnPos = [_targetPos, 1000, 1200, 5, 0, 20, 0, [], [_fallBackPos, _fallBackPos]] call BIS_fnc_findSafePos;
_roads = _spawnPos nearRoads 200;

if (count _roads > 0) then
{
	_roads = _roads apply {getPos _x};
	_spawnPos = selectRandom _roads;
};

_radius = 50;
if (_isHQ) then {_radius = 75;};

{
	_vehicleClass = _x select 0;
	_vehType = _x select 1;
	_finalSpawn = [_spawnPos, 0, 50, 8, 0, 20, 0, [], [_spawnPos, _spawnPos]] call BIS_fnc_findSafePos;

	[
		"QRF", _finalSpawn, _targetPos, _radius, _infantryClasses, _vehicleClass, _vehType, _varName, _debug
	] remoteExec ["bia_spawn_veh_group", missionNamespace getVariable ["BiA_Host", 2]];
	//spawn bia_spawn_veh_group; //
} forEach _finalVehicles;

[_tag, "Waiting for units to spawn", _debug] spawn bia_to_log;

//Wait till units spawned 
while {count(allUnits select {_x getVariable [_varName, false]}) < 1} do 
{
	uiSleep 1;
};

//create indication markers
_prefix = "CounterAttack";

_tempMarkerStart = _prefix + "_start_" + (str random [11111, 55555, 99999]);
createMarker [_tempMarkerStart, _spawnPos];
_tempMarkerStart setMarkerTypeLocal "loc_car";
_tempMarkerStart setMarkerColorLocal "colorOPFOR";
_tempMarkerStart setMarkerSize [2,2];

_tempMarkerTarget = _prefix + "_target_" + (str random [11111, 55555, 99999]);
createMarker [_tempMarkerTarget, _targetPos];
_tempMarkerTarget setMarkerTypeLocal "selector_selectedEnemy";
_tempMarkerTarget setMarkerColorLocal "colorOPFOR";
_tempMarkerTarget setMarkerSize [2,2];

[
	composeText["Enemy Assault group spotted", lineBreak, "Sector can be lost in 10 Minutes"],
	"center_top",
	5, 0, 0, 86, "Red"
] remoteExec ["bia_spawn_text", 0];

[_tag, "Enemies spawned waiting for outcome", _debug] spawn bia_to_log;

_capturePossTime = serverTime + 600;
_countdown = [_capturePossTime, "CounterAttackOngoing", _debug] spawn bia_countdown;

//Check if counter attack still going 
_failure = false;
while {count(allUnits select {_x getVariable [_varName, false] && alive _x}) > 0} do 
{
	if (!_isHQ) then 
	{
		_enemiesInSector = allUnits select {_x getVariable [_varName, false] && _x distance2D _targetPos < 100};
		_defendersInSector = allPlayers select {_x distance2D _targetPos < 100};

		{
			[_marker, 100, _varName, _debug] remoteExec ["bia_progress_bar", _x];
		} forEach _defendersInSector;

		if 
		(
			_capturePossTime < serverTime 
			&& count _enemiesInSector > 0
			&& count _defendersInSector < 1
		) then 
		{
			_failure = true;
			_marker setMarkerColor "colorOPFOR";
			_clearedPosArr = ["ClearedPosArr",[]] call bia_load_from_profile;
			_clearedPosArr = _clearedPosArr - [getMarkerPos _marker];
			["ClearedPosArr", _clearedPosArr] call bia_save_to_profile;
			[_tag, "Lost one Sector to a Counter Attack", _debug] spawn bia_to_log;
		};
	};

	//if few counter attackers left, make them hunt the players
	_counterAttackUnits = allUnits select {_x getVariable [_varName, false] && alive _x};
	if (count _counterAttackUnits < 10) then 
	{
		_allGrps = _counterAttackUnits apply {group _x};
		_grps = _allGrps arrayIntersect _allGrps;

		_dists = allPlayers apply {_x distance2D (getMarkerPos _marker)};
		_targetPlayer = allPlayers select (_dists find (selectMin _dists));

		{
			[_x, _targetPlayer, _debug] spawn bia_hunt_target;
		} forEach _grps;
	};

	uiSleep 1;
};

missionNamespace setVariable ["LastCounterAttack", serverTime, true];

[_tag, "Attack finished", _debug] spawn bia_to_log;
missionNamespace setVariable ["CounterAttackOngoing", false, true];

{
	deleteMarker _x;
} forEach [_tempMarkerStart, _tempMarkerTarget];

if (!_failure) then 
{
	["Enemy Counter Attack repelled", "center_top", 5, 0, 0, 85, "Green"] remoteExecCall ["bia_spawn_text", 0];
} else 	
{
	["Enemy Counter Attack successful", "center_top", 5, 0, 0, 85, "Red"] remoteExecCall ["bia_spawn_text", 0];
};