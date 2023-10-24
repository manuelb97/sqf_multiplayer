//Misc
call compileFinal preprocessFileLineNumbers "scripts\bia_funcs.sqf";
west setFriend [resistance, 0];
resistance setFriend [west, 0];
//MCC_server setVariable [format ["CP_commander%1", west], "76561198010214456", true]; //uses steamUID64

//Settings
_debug = true;
_tag = "initServer";
[_tag, "Start", _debug] spawn bia_to_log;

//FPS 
if (hasInterface) then 
{
	[_debug] execVM "scripts\ui\fpsUI.sqf";
};

//Determine best host 
[_debug] execVM "scripts\host\chooseHost.sqf";

//Enemy Skill 
missionNamespace setVariable ["InfantrySkill", [0.1, 0.15, 0.2, 0.25], true];
missionNamespace setVariable ["VehicleSkill", 0.05, true];

//Arsenal Management
missionNamespace setVariable ["ArsenalBoxes", [hq_arsenal], true];
// missionNamespace setVariable ["ActiveArsenals", [], true];
//[[hq_arsenal, hq_arsenal_2], _debug] execVM "scripts\equipment\loadouts\manageAvailArsenals.sqf";

//Weather 
_now = date;
_now set [3, 5];
_now set [4, 0];
setDate _now;

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
_mission = "house_raids"; // house_raids pvp sector_attacks 
missionNamespace setVariable ["Mission", _mission, true];
["initServer", format["Starting %1 mission", _mission]] spawn bia_to_log;

_resetMissionState = false;
[_resetMissionState, _debug] spawn (compileFinal preprocessFileLineNumbers (_mission_f + _mission + _script_f));