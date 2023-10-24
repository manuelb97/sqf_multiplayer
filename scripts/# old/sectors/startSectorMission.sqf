//Select mission on map and start it according to sector and mission type
openMap true;
clicked = 0;
_selectedPos = [];
hint "Select the Mission you want to play next";
onMapSingleClick "selectedPos = _pos; clicked = 1; openMap false;; openmap false;onMapSingleClick ''; true;";

while { clicked != 1 } do { sleep 2; };

//Use only red Markers
_allMarkers = allMapMarkers;
_nearestMarker = [_allMarkers, selectedPos] call BIS_fnc_nearestPosition;

//Get info from marker
private ["_missionType","_markerZone"];
_missionLocation = getMarkerPos _nearestMarker;
_markerType = markerType _nearestMarker;

switch (_markerType) do {
		case "mil_marker": 	{ 
			_missionType = "Liberation";
		};
		case "mil_flag": 	{ 
			_missionType = "Defence";
		};
		case "mil_end": 	{ 
			_missionType = "HVT";
		};
		case "mil_unknown": 	{ 
			_missionType = "Heist";
		};
		case "mil_pickup": 	{ 
			_missionType = "Escape";
		};
		case "mil_objective": 	{ 
			_missionType = "Sniper";
		};
		case "mil_join": 	{ 
			_missionType = "Sabotage";
		};
		case "mil_circle": 	{ 
			_missionType = "Zombie";
		};
};

//Find best pos if non urban mission
if (_missionType in ["Defence","HVT","Heist","Zombie"]) then {
	_searchExp = "1*houses + 0.1*hills + 0.1*forest + 0*meadow + 0*sea";
	_missionLocations = selectBestPlaces [_missionLocation, 200, _searchExp, 1, 1];
	_missionLocation = _missionLocations select 0 select 0;
};
if (_missionType in ["Liberation","Sabotage"]) then {
	_searchExp = "0.5*houses + 0.1*hills + 0.1*forest + 0*meadow + 0*sea";
	_missionLocations = selectBestPlaces [_missionLocation, 200, _searchExp, 1, 1];
	_missionLocation = _missionLocations select 0 select 0;
};
if (_missionType in ["Escape"]) then {
	_searchExp = "0*houses + 0.1*hills + 1*forest + 0*meadow + 0*sea";
	_missionLocations = selectBestPlaces [_missionLocation, 200, _searchExp, 1, 1];
	_missionLocation = _missionLocations select 0 select 0;
};
if (_missionType in ["Sniper"]) then {
	_searchExp = "0*houses + 0.1*hills + 0.5*meadow + 0.25*forest + 0*sea";
	_missionLocations = selectBestPlaces [_missionLocation, 200, _searchExp, 1, 1];
	_missionLocation = _missionLocations select 0 select 0;
};

private "_markerZone";
if (_missionLocation inArea (sectors select 0)) then {
	_markerZone = "Tier_4";
};
if (_missionLocation inArea (sectors select 1)) then {
	_markerZone = "Tier_3";
};
if (_missionLocation inArea (sectors select 2)) then {
	_markerZone = "Tier_2";
};
if (_missionLocation inArea (sectors select 3)) then {
	_markerZone = "Tier_1";
};

//Get remaining info for mission
_missionArea = selectRandom["small","medium","big","huge"];
_tier = _markerZone;

//Execute with same values for all
[[_tier],"scripts\loadouts\tier_loadoutSelection.sqf"] remoteExec ["execVM", 0, true];

_missionParams = [_missionType,_missionLocation,_missionArea,_tier] call compile preprocessFileLineNumbers "scripts\missions\sectorParams.sqf";
_radius = _missionParams select 0;
_unitsArray = [_tier] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf";

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

//Prep weather & buildings
_weatherParas = [_tier,_missionType] call compile preprocessFileLineNumbers "scripts\missions\weather\randomWeatherParas.sqf";
[[_weatherParas],"scripts\missions\weather\randomWeatherTime.sqf"] remoteExec ["execVM", 0, true];
uiSleep 0.1;
[_missionLocation,_radius] remoteExec ["bia_destroy_buildings", selectRandom allPlayers, true];
uiSleep 0.1;

//Prep mission markers
_missionMarkers = [_missionType, _missionLocation, _radius] call compile preprocessFileLineNumbers "scripts\missions\missionMarkers.sqf";
_missionMarkers = _missionMarkers + [_nearestMarker];

//Add supports
if (isNil "_defVehicles") then {_defVehicles = [];};
[_missionType,_missionArea,_tier,_radius,_defVehicles] execVM "scripts\missions\support\givePlayerMCCSupport.sqf";
uiSleep 5;

//Start mission with according parameters
_players = allPlayers;
_host = selectRandom _players;
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
		
		[_missionLocation,_missionArea, _missionMarkers,_radius,_escapeVehicles,_groupSizes, _unitsArray] remoteExec ["bia_escape", _host, true];
		//[_missionLocation,_missionArea, _missionMarkers,_radius,_escapeVehicles,_groupSizes, _unitsArray] execVM "scripts\missions\mission_scripts\5. escape.sqf";
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
		[_missionLocation,_missionMarkers,_radius,_countdown,_tier] remoteExec ["bia_zombie", _host, true];
	};
};