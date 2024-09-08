//def funcs
call compileFinal preprocessFileLineNumbers "scripts\bia_funcs.sqf";

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
			_oldPlayerArr params ["_uid", "_oldKills", "_oldDeaths", "_oldPlayerKills", "_oldAttackWins", "_oldDefenseWins"];

			if (_playerKill) then 
			{
				[_tag, format["%1: Adding Player Kill", _killerName]] remoteExec["bia_to_log", 2];
				_oldStatsArr set [_arrIdx, [_killerUID, _oldKills, _oldDeaths, _oldPlayerKills + 1, _oldAttackWins, _oldDefenseWins]];
			} else 
			{
				_oldStatsArr set [_arrIdx, [_killerUID, _oldKills + 1, _oldDeaths, _oldPlayerKills, _oldAttackWins, _oldDefenseWins]];
			};
			missionNamespace setVariable ["PlayerStatsArr", _oldStatsArr, true];
		} else
		{
			//killer not found, add new array for him
			[_tag, format["Killer %1 not found in Stats Arr, adding new Entry", _killerName]] remoteExec["bia_to_log", 2];
			
			_oldStatsArr pushBack [_killerUID, 1, 0, 0, 0, 0];
			missionNamespace setVariable ["PlayerStatsArr", _oldStatsArr, true];
		};
	} forEach _killers;
};

endLoadingScreen;