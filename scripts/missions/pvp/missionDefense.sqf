// [50, 5, 15, 10] spawn compileFinal preprocessFileLineNumbers "scripts\missions\pvp\defense.sqf";

//Paras
params [
"_compoundRadius",
"_minBuildings",
"_maxBuildings",
"_prepTime",
"_minDistance",
"_maxDistance"
];

["PvP_Defense", "Mission Prep started"] spawn bia_to_log;
missionNamespace setVariable ["PvPMissionActive", true, true];
_startTime = serverTime;
_msgDuration = 30;

//weather 
_includeNight = false;
_includeFog = true;
_forceNight = false;
_forceFogTwilight = false;
_forceSpecialWeather = false;
_timeToChange = 0;

[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, _timeToChange, true] spawn bia_change_weather;

//split players, if uneven more attackers 
_players = allPlayers call BIS_fnc_arrayShuffle;

{
	[_x] joinSilent grpNull;
} forEach _players;

_playerCount = count _players;
_attackers = [];
_defenders = [];

if (_playerCount > 1) then 
{
	if (_playerCount mod 2 != 0) then  
	{ 
		_attackers = _players select [0, round(_playerCount / 2)]; 
		_defenders = _players select [round(_playerCount / 2), 1000]; 
	} else  
	{ 
		_attackers = _players select [0, _playerCount / 2];  
		_defenders = _players select [_playerCount / 2, 1000]; 
	}; 
} else 
{
	// _attackers = _players;
	_defenders = _players;
};

//determine mission location 
_missionLocation = [_compoundRadius] call bia_pvp_location_defense;

_areaMarker = str random [11111, 55555, 99999];
createMarker [_areaMarker, _missionLocation];
_areaMarker setMarkerShapeLocal "ELLIPSE";
_areaMarker setMarkerColorLocal "ColorRed";
_areaMarker setMarkerAlphaLocal 0.25;
_areaMarker setMarkerSize [_compoundRadius, _compoundRadius];

//determine side of both groups 
_factions = ["RU", "US"];
_defenderFaction = selectRandom _factions;
_attackerFaction = selectRandom (_factions - [_defenderFaction]);

_text = format["Attacking Faction: %1, Defending Faction: %2", _attackerFaction, _defenderFaction];
["PvP_Defense", _text] spawn bia_to_log;

//setup spawn point
_defenderSpawnPos = [_missionLocation, 0, _compoundRadius / 4, 2, 0, 20, 0, [], [_missionLocation, _missionLocation]] call BIS_fnc_findSafePos;
_defenderRespawn = createMarker ["DefenderRespawn", _defenderSpawnPos];

_defenderRespawnIds = [];
{
	_id = [_x, _defenderRespawn, "Compound"] call BIS_fnc_addRespawnPosition;
	_defenderRespawnIds pushBack _id;
} forEach _defenders;

[_defenderFaction, _defenderSpawnPos] spawn bia_pvp_statics;

//setup arsenals 
_defenderArsenal = [_missionLocation, _compoundRadius, _defenderFaction, _attackerFaction] call bia_pvp_arsenals;

//give defenders fortify tools 
if (_defenderFaction == "RU") then 
{
	[east] spawn bia_pvp_fortifications;
} else 
{
	[west] spawn bia_pvp_fortifications;
};

//spawn defender AI
_usClasses = 
[
	"rhsusf_army_ocp_rifleman_82nd", "rhsusf_army_ocp_rifleman_82nd", "rhsusf_army_ocp_rifleman_82nd", 
	"rhsusf_army_ocp_grenadier", "rhsusf_army_ocp_arb_riflemanat", "rhsusf_army_ocp_arb_maaws", 
	"rhsusf_army_ocp_arb_autorifleman", "rhsusf_army_ocp_arb_machinegunner"//, "rhsusf_army_ocp_arb_marksman"
];
_ruClasses = 
[
	"rhs_vdv_rifleman", "rhs_vdv_rifleman", "rhs_vdv_rifleman", 
	"rhs_vdv_grenadier", "rhs_vdv_RShG2", "rhs_vdv_grenadier_rpg", 
	"rhs_vdv_machinegunner", "rhs_vdv_arifleman"//, "rhs_vdv_marksman"
];

_maxEnemies = missionNamespace getVariable ["MaxEnemies", 20];
_attackerAICount = round (_maxEnemies * 0.7);

if (count _attackers > count _defenders) then 
{
	_attackerAICount = round (_maxEnemies * 0.4);
};

_defenderAICount = _maxEnemies - _attackerAICount;

[_defenderAICount, _defenderFaction, _missionLocation, _compoundRadius, _usClasses, _ruClasses] spawn bia_pvp_ai_defenders;

//equip players 
[_attackers, _attackerFaction, false] spawn bia_pvp_equip_players;
[_defenders, _defenderFaction, true] spawn bia_pvp_equip_players;

//teleport defenders 
private "_defenderGrp";

if (_defenderFaction == "RU") then 
{
	_defenderGrp = createGroup [east, true];
} else 
{
	_defenderGrp = createGroup [west, true];
};

[
	format["Teleporting defenders: %1", _defenders], "center_top", 5, 0, 0, 100, "Red"
] remoteExec ["bia_spawn_text", 0];
uiSleep 5;

{
	_player = _x;
	forceRespawn _player;
	// _player setPos (_defenderSpawnPos getPos [1, random 360]);
	// _player setDir (_player getDir _defenderSpawnPos);
	[_player] joinSilent _defenderGrp;
	_player setvariable ["pvp_defend", true, true];
	_player setvariable ["pvp_attack", false, true];
} forEach _defenders;

//give indicator about mission state 
_endTime = serverTime;
_text = format["Computations took %1 seconds", _endTime - _startTime];
["PvP_Defense", _text] spawn bia_to_log;

//spawn attacking AIs
_directions = 
[
	[[345, 15], "North"],
	[[30, 60], "NorthWest"],
	[[75, 105], "East"],
	[[120, 150], "SouthEast"],
	[[165, 195], "South"],
	[[210, 240], "SouthWest"],
	[[255, 285], "West"],
	[[300, 330], "NorthWest"]
];

_attackDir = (selectRandom _directions) params ["_dir", "_dirName"];

[
	format["Preparation Time: %1 seconds<br/>Attackers will approach from the %2", _prepTime, _dirName], "center_top", _msgDuration, 0, 0, 100, "Red"
] remoteExec ["bia_spawn_text", 0];
uiSleep _prepTime;

_defenderUnits = allUnits select {_x distance2D _missionLocation <= _compoundRadius};
_defenderUnits = _defenderUnits + (allPlayers select {_x distance2D _missionLocation <= _compoundRadius});

[
	_attackerAICount, 
	_attackerFaction, _defenderUnits, 
	_missionLocation, _compoundRadius, 
	_ruClasses, _usClasses, 
	_dir, _minDistance, _maxDistance
] spawn bia_pvp_ai_attackers;

//setup attacking players 
_meanDir = ((_dir select 0) + (_dir select 1)) / 2;

if (_dirName == "North") then 
{
	_meanDir = 0;
};

_attackerStartRaw = _missionLocation getPos [_minDistance, _meanDir];
_attackerStart = [_attackerStartRaw, 0, 50, 1, 0, 20, 0, [], [_attackerStartRaw, _attackerStartRaw]] call BIS_fnc_findSafePos;
_attackerRespawn = createMarker ["AttackerRespawn", _attackerStart];

_attackerRespawnIds = [];
{
	_id = [_x, _attackerRespawn, "Compound"] call BIS_fnc_addRespawnPosition;
	_attackerRespawnIds pushBack _id;
} forEach _attackers;

_spawnInBoat = false;
private "_newvehicle";

if (_attackerStart isEqualTo _attackerStartRaw) then 
{
	if (surfaceIsWater _attackerStart) then 
	{
		_spawnInBoat = true;
		_boatClass = "I_C_Boat_Transport_02_F";
		_newvehicle = createVehicle [_boatClass, _attackerStart, [], 0, "NONE"];
		clearWeaponCargoGlobal 		_newvehicle;
		clearMagazineCargoGlobal 	_newvehicle;
		clearItemCargoGlobal 		_newvehicle;
		clearBackpackCargoGlobal	_newvehicle;
	};
};

private "_attackerGrp";

if (_attackerFaction == "RU") then 
{
	_attackerGrp = createGroup [east, true];
} else 
{
	_attackerGrp = createGroup [west, true];
};

{
	_player = _x;
	_player setPos _attackerStart;
	[_player] joinSilent _attackerGrp;
	_player setvariable ["pvp_defend", false, true];
	_player setvariable ["pvp_attack", true, true];

	if (_spawnInBoat) then 
	{
		_player moveInAny _newvehicle;
	};
} forEach _attackers;

//wait for mission to be preped
/*
[
	format[
		"Attackers: %1, Defenders: %2, MissionActive: %3", 
		count (allUnits select {_x getVariable ["pvp_attack", false]}),
		count (allUnits select {_x getVariable ["pvp_defend", false]}),
		missionNamespace getVariable ["PvPMissionActive", false]
	]
] remoteExec ["hint", 0];
*/
while 
{
	count (allUnits select {_x getVariable ["pvp_attack", false]}) < 1
	|| count (allUnits select {_x getVariable ["pvp_defend", false]}) < 1
} do 
{
	uiSleep 1;
};

{
	_grp = _x;
	
	if (count units _grp < 1) then 
	{
		deleteGroup _grp;
	};
} forEach allGroups;

[_missionLocation, "PvPMissionActive", _compoundRadius, 10] remoteExec ["bia_pvp_progress_bar", 0];

while {count allPlayers > count (allPlayers select {_x distance2D _missionLocation <= _maxDistance + 100})} do 
{
	uiSleep 1;
};

{
	_x call BIS_fnc_removeRespawnPosition;
} forEach _defenderRespawnIds;
{
	_x call BIS_fnc_removeRespawnPosition;
} forEach _attackerRespawnIds;

[_missionLocation, _meanDir] spawn bia_pvp_spectators;

//stop mission 
_defenderWin = false;
_winAdded = false;

while {missionNamespace getVariable ["PvPMissionActive", false]} do 
{
	_attackUnits = allUnits select {_x getVariable ["pvp_attack", false] && _x distance _missionLocation < (_maxDistance + 100)};
	_attackUnits = _attackUnits + (_attackers select {_x distance _missionLocation < (_maxDistance + 100)});
	
	_defendUnits = allUnits select {_x getVariable ["pvp_defend", false] && _x distance _missionLocation < _compoundRadius};
	_defendUnits = _defendUnits + (_defenders select {_x distance _missionLocation < (_compoundRadius + 100)});

	if (count _attackUnits == 0) then 
	{
		missionNamespace setVariable ["PvPMissionActive", false, true];

		if (!_winAdded) then 
		{
			_defenderWin = true;
			[_defenders, true] spawn bia_pvp_add_win;
		};
	} else 
	{
		if (count _defendUnits == 0) then 
		{
			missionNamespace setVariable ["PvPMissionActive", false, true];

			if (!_winAdded) then 
			{
				[_attackers, false] spawn bia_pvp_add_win;
			};
		};
	};

	uiSleep 1;
};

[_missionLocation, 1000, true] spawn bia_sweep_area;

_text = "Attackers win";
if (_defenderWin) then 
{
	_text = "Defenders win";
};

[
	_text, "center_top", _msgDuration, 0, 0, 100, "Green"
] remoteExec ["bia_spawn_text", 0];
["PvP_Defense", _text] spawn bia_to_log;

uiSleep 10;

{
	_player = _x;
	_player setPosATL getPosATL hq_pos;
} forEach allPlayers;