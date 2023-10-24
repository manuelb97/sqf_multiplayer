//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_debug"];
missionNamespace setVariable ["SideMissionActive", true, true];

//prep stats
_oldStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];

//find pos with enough cover to work 
_pos = [];

while {count _pos == 0} do 
{
	_randPos = [nil, ["water"]] call BIS_fnc_randomPos;
	_terrainObjects = nearestTerrainObjects [_randPos, [], 50, false, true];

	if (count _terrainObjects > 100) then 
	{
		_pos = _randPos;
	};
};

//mark zone
_radius = 2000;
_startMarker = "RandomInsertionStart";
createMarker [_startMarker, _pos];
_startMarker setMarkerTypeLocal "selector_selectedEnemy";
_startMarker setMarkerColorLocal "ColorRed";
_startMarker setMarkerSize [1.5, 1.5];

_zoneMarker = "RandomInsertionZone";
createMarker [_zoneMarker, _pos];
_zoneMarker setMarkerShapeLocal "ELLIPSE";
_zoneMarker setMarkerColorLocal "colorOPFOR";
_zoneMarker setMarkerAlphaLocal 0.25;
_zoneMarker setMarkerSize [_radius, _radius];

_markers = [_startMarker, _zoneMarker];

//set weather 
[true, true, false, false, false, 0, _debug] spawn bia_change_weather; //_includeNight _includeFog _forceNight _forceFogTwilight _timeToChange _debug

//give time to plan route 
_delay = 10; //60
[format["Position determined, plan your route (%1s remaining)", _delay]] remoteExec ["hint", 0];
_countdown = [serverTime + _delay, "SideMissionActive", _debug] spawn bia_countdown;
uiSleep _delay;

//teleport to pos
{_x setPos _pos;} forEach allPlayers;

//spawn friendly squad 
_classes = [
	"rhsusf_army_ocp_rifleman", 10,
	"rhsusf_army_ocp_grenadier", 5,
	"rhsusf_army_ocp_autorifleman", 3, 
	"rhsusf_army_ocp_machinegunner", 2
];

/*
_classArr = [];
for "_i" from 1 to 4 do 
{
	_classArr pushBack (selectRandomWeighted _classes);
};

_grp = createGroup [west, true];
{
	_class = _x;
	_soldier = _grp createUnit [_class, _pos vectorAdd [random 5, random 5, 0.5], [], 0, "NONE"];
	_soldier disableAI "AUTOCOMBAT";
} forEach _classArr;
(units _grp) joinSilent (group _caller);
*/

//start spawning enemies 
uiSleep 5;
_dir = random 360;
_infantry = [["Tier_4", "Tier_3"], "Infantry", _debug] call bia_get_tier_cat;
[250, 400, (count allPlayers) * 10, 500, 60, _dir, _infantry, _debug] spawn bia_random_insertion_enemies; // _minSpawnDistance _maxSpawnDistance _maxEnemies _despawnDistance _delay 60

//check if player didnt move for a while, mortar barrage that old area
_playersInZone = allPlayers select {_x inArea _zoneMarker};
_startTime = serverTime;
_counter = 1;
_minDist = 200;
_checkPos = _pos;
_delay = 180; //180

while {count _playersInZone > 0} do 
{
	if (serverTime > (_startTime + _counter * _delay)) then 
	{
		// hint format["Arty poss, ServerTime: %1, NecessaryTime: %2", serverTime, _startTime + _counter * _delay];

		if (_caller distance2D _checkPos < _minDist) then 
		{
			["Enemy Artillery fired", -0.15, -0.4, 5, 0, 0, 85, "Red"] remoteExecCall ["bia_spawn_text", 0];

			_rounds = selectRandom[3,4,5,6,7,8];
			_safeZone = 40;
			_radius = _safeZone + random[0, 10, 20];
			_blacklistPos = allPlayers apply {[_x, _safeZone]};

			_txt = "";
			_ammo = "Sh_82mm_AMOS";
			_altitude = 400;
			_speed = 50;

			for "_i" from 1 to _rounds do 
			{
				_impactPos = [getPos _caller, _safeZone, _radius, 0, 0, 0, 0, _blacklistPos, []] call BIS_fnc_findSafePos;
				[_txt, selectRandom allPlayers, _impactPos, 0, _ammo, _altitude, _speed, true] spawn bia_drop_projectile;
				uiSleep selectRandom[3,5,7,9];
			};
		};

		_counter = _counter + 1;
		_checkPos = getPos _caller;
	};

	uiSleep 1;
};

//End mission
missionNamespace setVariable ["SideMissionActive", false, true];
{deleteMarker _x} forEach _markers;

{
	_x setPos (getPos hq_pos);
} forEach (allPlayers select {!(_x inArea _zoneMarker)});

_finalStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];
_missionStats = [];
for "_i" from 0 to (count _finalStatsArr - 1) do 
{
	_oldPlayerStats = _oldStatsArr select _i;
	_newPlayerStats = _finalStatsArr select _i;
	_missionPlayerStats = [_newPlayerStats select 0, (_newPlayerStats select 1) - (_oldPlayerStats select 1)];

	_missionStats set [_i, _missionPlayerStats];
};

{
	_player = _x;
	_playerUID = getPlayerUID _player;
	_playerStats = (_missionStats select {(_x select 0) == _playerUID}) select 0;
	_marker = "playerDeathMarker_" + (str _playerUID);

	[format["You killed %1 Enemies and travelled %2 meters", _playerStats select 1, _pos distance2D (getMarkerPos _marker)]] remoteExec ["hint", _player];
} forEach allPlayers;