//Paras
params [
"_target", 
"_caller", 
"_arguments"
];

if (missionNamespace getVariable ["SideMissionActive", false]) exitWith 
{
	"There is already an active side mission you fucking retard" remoteExec ["hint", 0];
};

missionNamespace setVariable ["SideMissionActive", true, true];
"Preparing Side Mission (Firefight)" remoteExec ["hint", 0];

_debug = _arguments select 0;
_tag = "SideMissionFirefight";
_varName = "side_mission_opfor";
[_tag, "Started", _debug] spawn bia_to_log;

//Change Weather 
_includeNight = true;
_includeFog = true;
_forceNight = false;
_forceFogTwilight = false;
_forceSpecialWeather = true;

[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, 0, _debug] spawn bia_change_weather;

//Determine mission location
_missionType = selectRandom ["TreeLineAmbush", "FortificationsAssault", "FortificationsDefense"];
_missionLocation = [];
[_tag, format["Trying to find suitable mission location for %1", _missionType], _debug] spawn bia_to_log;

_missionLocs = [];
_vals = [];

if (_missionType == "TreeLineAmbush") then 
{
	_missionLocation = [8, 10, true] call compileFinal preprocessFileLineNumbers "scripts\firefight\findForrest.sqf";
} else 
{
	while {count _missionLocs < 1} do 
	{
		_possPos = [_pos, 0, 200, 20, 0, 1, 0, [], [_pos, _pos]] call BIS_fnc_findSafePos;

		if !(_possPos isEqualTo _pos) then 
		{
			_missionLocation = _possPos;
		};
	};
};

//Prep mission location
_playerStartPos = [];
_enemyFinalPositions = [];

if (_missionType == "TreeLineAmbush") then 
{
	//find player pos 
	// position that can be overwatched from some of the tree edge line emptyPositions
	//within 500 m of tree line positions
	//maybe simple Z check (forrest higher than player pos)
		//check if player pos has cover objs?
} else 
{
	//Spawn fortifications
};

//Spawn enemies 
if (_missionType == "TreeLineAmbush") then 
{
	//spawn enemies slightly behind tree line 
	//give move command to tree lines edges (spread across the edge)
	//make them go into combat  mode 
} else 
{
	if (_missionType == "FortificationsAssault") then 
	{
		//spawn enemies in fortifications
	} else 
	{
		//spawn enemies in front of fortifications in hidden pos 
	};
};

//Create Task 
_taskName = str random [11111, 55555, 99999];

switch (_missionType) do
{
	case "TreeLineAmbush":
	{
		[_taskName, allPlayers, ["Survive and repell the enemy Ambush", "Ambush", "DEFEND"], _missionLocation, "ASSIGNED", 0, true, true, "danger"] remoteExec ["BIS_fnc_setTask", 0, true];
	};
	case "FortificationsAssault":
	{
		[_taskName, allPlayers, ["Assault the enemy Fortifications", "Assault", "ATTACK"], _missionLocation, "ASSIGNED", 0, true, true, "attack"] remoteExec ["BIS_fnc_setTask", 0, true];
	};
	case "FortificationsDefense":
	{
		[_taskName, allPlayers, ["Defend the friendly Fortifications", "Defence", "DEFEND"], _missionLocation, "ASSIGNED", 0, true, true, "defend"] remoteExec ["BIS_fnc_setTask", 0, true];
	};
};

//Teleport players
["Standby for Teleportation", -0.15, -0.4, 5, 0, 0, 85, "Green"] remoteExecCall ["bia_spawn_text", 0];

uiSleep 5;

{
	_x setPos _playerStartPos;
} forEach allPlayers;

//Start Mission Loop
_missionRunning = true;

while {_missionRunning} do 
{
	_playerArr = allPlayers select {_x distance2D _missionLocation <= 500};
	_remainingEnemies = allUnits select {_x getVariable [_varName, false]};

	//check for win
	if (count _playerArr > 0 && count _remainingEnemies < 1) then
	{
		_missionRunning = false;
		[_taskName,"SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
	};

	//Check for loss (discovered and not killed within time window)
	if (count _playerArr < 1) then 
	{
		_missionRunning = false;
		[_taskName,"FAILED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
	};
	
	uiSleep 1;
};

missionNamespace setVariable ["SideMissionActive", false, true];
missionNamespace setVariable ["Aggression", _newAggro, true];
[_tag, "Finished", _debug] spawn bia_to_log;

_allPlayersAtBase = false;
while {!_allPlayersAtBase} do 
{
	_numPlayers = count allPlayers;
	_playersInBase = allPlayers select {_x distance2D hq_pos < 100};

	if (count _playersInBase == _numPlayers) then 
	{
		_allPlayersAtBase = true;
	};

	uiSleep 1;
};

//Delete enemies 
{
	deleteVehicle _x;
} forEach (allUnits select {_x getVariable [_varName, false]});

//Change Weather 
_includeNight = false;
_includeFog = false;
_forceNight = false;
_forceFogTwilight = false;
_forceSpecialWeather = false;

[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, 0, _debug] spawn bia_change_weather;


/*
//force enemies to fire at friendly bunkers if base defense mission 
_planeDriver forceweaponfire _forceWeapInfo; // _unit forceWeaponFire ["arifle_MX_F", "Single"];
_planeDriver fireattarget [_target, _weapon]; // inf_unit fireAtTarget [_helicopter, currentWeapon inf_unit];
*/