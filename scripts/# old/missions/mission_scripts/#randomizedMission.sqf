//[0,0,0,"Escape"] execVM "scripts\missions\mission_scripts\#randomizedMission.sqf";

//Paras
_inputArray = param [3,[]];

private ["_missionType"];
if (count _inputArray > 0) then {
	_missionType = _inputArray select 0;
} else {
	_missionType = selectRandom ["Liberation", "Defence", "HVT", "Heist", "Escape","Sniper","Sabotage","Zombie"]; //"Zombie_Clear", "Zombie_Escape"
};

//Define location params
_locationParas = [_missionType] call compile preprocessFileLineNumbers "scripts\missions\locationParams.sqf";
_houses			= _locationParas select 0;
_hills 				= _locationParas select 1;
_meadow 		= _locationParas select 2;
_sea 				= _locationParas select 3;
_forest 			= _locationParas select 4;
uiSleep 0.5;

//Define mission location
_missionLocation = [_houses,_hills,_meadow,_sea,_forest] call compile preprocessFileLineNumbers "scripts\missions\randomMissionLocation.sqf";
uiSleep 0.5;

//Define zone type
_missionArea = selectRandom["small","medium","big","huge"];
/*
private ["_missionArea"];
_radius = 500;
if (_missionType != "Escape") then {
	_houses = count (nearestObjects [_missionLocation , ["house"], _radius ]);
	if (_houses <= 10) 							then { _missionArea = "small"};
	if (_houses >= 10 && _houses < 20) 	then { _missionArea = "medium"};
	if (_houses >= 20 && _houses < 30) 	then { _missionArea = "big"};
	if (_houses >= 30) 							then { _missionArea = "huge"};
} else {
	_missionArea = selectRandom["small","medium","big","huge"];
};
*/

//Tier selection
_tier = selectRandom["Tier_4","Tier_3","Tier_2","Tier_1"];

//Add loadout actions
[[_tier],"scripts\loadouts\tier_loadoutSelection.sqf"] remoteExec ["execVM", 0, true];
uiSleep 0.5;

//Create Random Time + Weather
_weatherParas = [_tier,_missionType] call compile preprocessFileLineNumbers "scripts\missions\weather\randomWeatherParas.sqf";
[[_weatherParas],"scripts\missions\weather\randomWeatherTime.sqf"] remoteExec ["execVM", 0, true];
uiSleep 0.5;

//Mission Params
_missionParams = [_missionType,_missionLocation,_missionArea,_tier] call compile preprocessFileLineNumbers "scripts\missions\sectorParams.sqf";
_radius = _missionParams select 0;

private ["_mobileEnemies","_cqbEnemies","_reinforcements_max","_defVehicles","_mortar","_mortarPatrols","_suicideBomber","_suicideBomberNum","_countdown"];
if (_missionType in ["Liberation","HVT","Heist","Sniper","Sabotage","Zombie"]) then {
	_mobileEnemies 		= _missionParams select 1;
	_cqbEnemies 			= _missionParams select 2;
	_reinforcements_max= _missionParams select 3;
	_defVehicles 			= _missionParams select 4;
	_mortar					= _missionParams select 5;
	_mortarPatrols 		= _missionParams select 6;
	_suicideBomber 		= _missionParams select 7;
	_suicideBomberNum 	= _missionParams select 8;
	_countdown			= _missionParams select 9;
};
uiSleep 0.5;

//Destroy buildings
[_missionLocation,_radius] remoteExec ["bia_destroy_buildings", selectRandom allPlayers, true];
uiSleep 0.5;

//Mission markers
_missionMarkers = [_missionType, _missionLocation, _radius] call compile preprocessFileLineNumbers "scripts\missions\missionMarkers.sqf";
uiSleep 0.5;

//Add Supports
if (isNil "_defVehicles") then {_defVehicles = [];};
[_missionType,_missionArea,_tier,_radius,_defVehicles] execVM "scripts\missions\support\givePlayerMCCSupport.sqf";
uiSleep 5;

//Get tier specific faction units
if (_tier == "Tier_2") then {_tier = selectRandom ["Tier_3","Tier_2"]};
if (_tier == "Tier_1") then {_tier = selectRandom ["Tier_2","Tier_2","Tier_1"]};
_unitsArray = [_tier] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf";

//Start respective mission
_players = allPlayers;
_host = selectRandom allPlayers;
if (count _players > 1) then {
	_players = _players - [manu];
	_host = selectRandom _players;
};

switch _missionType do {
    case "Liberation": {
		[_missionLocation,_missionMarkers,_mobileEnemies,_cqbEnemies,_radius,_reinforcements_max,
		_defVehicles,_mortar,_mortarPatrols,_suicideBomber,_suicideBomberNum,_countdown,
		_unitsArray] remoteExec ["bia_liberation", _host, true];
	};
    case "Defence": {
		_reinforcements_max= _missionParams select 1;
		_mortar_chance 		= _missionParams select 2;
		_countdown 			= _missionParams select 3;
		
		[_missionLocation,_missionMarkers,_radius,_reinforcements_max,_mortar_chance,_countdown,
		_unitsArray] remoteExec ["bia_defence", _host, true];
	};
    case "HVT": {
		[_missionLocation,_missionMarkers,_mobileEnemies, _cqbEnemies,_radius,_reinforcements_max,
		_defVehicles,_mortar,_mortarPatrols,_suicideBomber,_suicideBomberNum,_countdown,
		_unitsArray] remoteExec ["bia_hvt", _host, true];
	};
    case "Heist": {
		[_missionLocation,_missionArea,_missionMarkers,_mobileEnemies, _cqbEnemies,_radius,
		_reinforcements_max,_defVehicles,_mortar,_mortarPatrols,_suicideBomber,_suicideBomberNum,
		_countdown,_unitsArray] remoteExec ["bia_heist", _host, true];
	};
    case "Escape": {
		_escapeVehicles	= _missionParams select 1;
		_groupSizes		= _missionParams select 2;
		
		[_missionLocation,_missionArea, _missionMarkers,_radius,_escapeVehicles,_groupSizes,
		_unitsArray] remoteExec ["bia_escape", _host, true];
	};
    case "Sniper": {
		[_missionLocation,_missionMarkers,_mobileEnemies,_radius,_defVehicles,_countdown,
		_unitsArray] remoteExec ["bia_sniper", _host, true];
	};
    case "Sabotage": {
		[_missionLocation,_missionMarkers,_mobileEnemies,_cqbEnemies,_radius,_reinforcements_max,
		_defVehicles, _countdown,_unitsArray] remoteExec ["bia_sabotage", _host, true];
	};
    case "Zombie": {
		[_missionLocation,_missionMarkers,_radius,_countdown] remoteExec ["bia_zombie", _host, true];
	};
};