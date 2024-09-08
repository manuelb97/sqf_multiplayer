call compileFinal preprocessFileLineNumbers "scripts\bia_funcs.sqf";
_debug = true;

if (isServer) then 
{
	west setFriend [resistance, 0];
	resistance setFriend [west, 0];

	//Determine best host 
	[] execVM "scripts\host\chooseHost.sqf";

	//Enemy Skill 
	missionNamespace setVariable ["InfantrySkill", [0.1, 0.15, 0.2, 0.25], true];
	missionNamespace setVariable ["VehicleSkill", 0.05, true];

	//Arsenal Management
	missionNamespace setVariable ["ArsenalBoxes", [hq_arsenal], true];
	// missionNamespace setVariable ["ActiveArsenals", [], true];
	//[[hq_arsenal, hq_arsenal_2], _debug] execVM "scripts\equipment\loadouts\manageAvailArsenals.sqf";

	//Weather 
	// _now = date;
	// _now set [3, 5];
	// _now set [4, 0];
	// setDate _now;
	_includeNight = true;
	_includeFog = true;
	_forceNight = false;
	_forceFogTwilight = false;
	_forceSpecialWeather = false;
	_timeToChange = 0;
	[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, _timeToChange] spawn bia_change_weather;

	//Player Stats
	_resetPlayerStats = false;
	_playerStatsArr = ["PlayerStatsArr", []] call bia_load_from_profile;

	if (_resetPlayerStats) then 
	{
		_playerStatsArr = [];
	};

	missionNamespace setVariable ["PlayerStatsArr", _playerStatsArr, true];
	[_debug] execVM "scripts\database\savePlayerStatsLoop.sqf";

	//Soundscape
	//[_debug] execVM "scripts\weather\soundscape.sqf";

	//Spawn Chemlights
	// [_debug] execVM "scripts\hq\spawnBunkerChemlights.sqf";

	//Execute Mission Code
	_mission_f = "scripts\missions\";
	_script_f = "\initServerCode.sqf";
	_mission = "liberation_rpg"; // house_raids pvp sector_attacks 
	missionNamespace setVariable ["Mission", _mission, true];
	["initServer", format["Starting %1 mission", _mission]] spawn bia_to_log;

	_resetMissionState = true;
	[_resetMissionState, _debug] spawn (compileFinal preprocessFileLineNumbers (_mission_f + _mission + _script_f));
};

if (hasInterface) then 
{
	//Execute appropriate player local init
	while {missionNamespace getVariable ["Mission", ""] == ""} do
	{
		uiSleep 1;
	};

	switch (missionNamespace getVariable ["Mission", ""]) do
	{
		case "house_raids": 
		{
			[] spawn bia_house_raid_local_init;
		};
		case "pvp": 
		{
			[] spawn bia_pvp_local_init;
		};
		case "sector_attacks": 
		{
			[] spawn bia_sector_attacks_local_init;
		};
		case "training": 
		{
			[] spawn bia_training_local_init;
		};
		case "liberation_rpg": 
		{
			[] spawn bia_rpg_local_init;
		};
	};

	if ((getPlayerUID player) == "76561198010214456") then 
	{
		[] execVM "scripts\misc\addObjsToZeus.sqf";
	};
};

//KillEventHandler
killedManInfo = 
{
	_tag = "KillEventHandler";
	_debug = true;
	
	_victim = _this select 0;
	_playerKill = false;

	if (_victim in allPlayers) then 
	{
		_playerKill = true;
	};

	_killerName = _victim getVariable ["ace_medical_lastDamageSource", objNull];
	_killerUID = getPlayerUID _killerName;
	//hint str [_killerName, _killerUID, crew _killerName];

	_killers = [];
	if (_killerName in allPlayers) then
	{
		_killers pushBack _killerName;
	} else 
	{
		_killers = crew _killerName;
	};

	{
		_killerName = _x;
		_weaponName = getText (configFile >> "cfgWeapons" >> currentWeapon _killerName >> "displayname");
		_distance = round(_victim distance _killerName);
		_killerName addPlayerScores [1,0,0,0,0];
		_oldStatsArr = missionNamespace getVariable ["PlayerStatsArr", []];
		//[_tag, format["Array before Kill: %1", _oldStatsArr]] remoteExec["bia_to_log", 2];
		
		//find stats array of killer
		_statsArrIDs = _oldStatsArr apply {_x select 0};
		_arrIdx = _statsArrIDs find _killerUID;
		
		//hint format["Victim: %1\nKillerName: %2\nKillerUID: %3\nArrIDs: %4, FindRet: %5", _victim, _killerName, _killerUID, _statsArrIDs, _arrIdx];

		//modify stats array of killer
		if (_arrIdx != -1) then
		{
			//[_tag, format["%1: Adding Kill", _killerName]] remoteExec["bia_to_log", 2];
			
			_oldPlayerArr = _oldStatsArr select _arrIdx;
			_oldPlayerArr params ["_uid", "_oldKills", "_oldDeaths"]; // , "_oldPlayerKills", "_oldAttackWins", "_oldDefenseWins"
			_oldStatsArr set [_arrIdx, [_killerUID, _oldKills + 1, _oldDeaths]]; // , _oldPlayerKills, _oldAttackWins, _oldDefenseWins
			/*
			if (_playerKill) then 
			{
				[_tag, format["%1: Adding Player Kill", _killerName]] remoteExec["bia_to_log", 2];
				_oldStatsArr set [_arrIdx, [_killerUID, _oldKills, _oldDeaths, _oldPlayerKills + 1, _oldAttackWins, _oldDefenseWins]];
			} else 
			{
				_oldStatsArr set [_arrIdx, [_killerUID, _oldKills + 1, _oldDeaths, _oldPlayerKills, _oldAttackWins, _oldDefenseWins]];
			};
			*/
			missionNamespace setVariable ["PlayerStatsArr", _oldStatsArr, true];
		} else
		{
			//killer not found, add new array for him
			[_tag, format["Killer %1 not found in Stats Arr, adding new Entry", _killerName]] remoteExec["bia_to_log", 2];
			
			_oldStatsArr pushBack [_killerUID, 1, 0]; // , 0, 0, 0
			missionNamespace setVariable ["PlayerStatsArr", _oldStatsArr, true];
		};
	} forEach _killers;
};