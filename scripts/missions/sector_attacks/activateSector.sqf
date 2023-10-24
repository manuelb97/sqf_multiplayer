//Paras
params [
"_marker",
"_sectorRadii",
"_maxTotalEnemies",
"_debug"
];

_sectorTag = "ManageSector";
missionNamespace setVariable [format["%1_active", _marker], true, true];

_markerType = markerType _marker;
_radius = _sectorRadii select 0;
_aggroLvl = missionNamespace getVariable ["Aggression", 0];
_numReinforcements = 1;
_defVehNum = selectRandom[1,1,2];
_maxEnemies = 15 - (_defVehNum * 3);

switch (_markerType) do 
{
	case "loc_Ruin": 
	{
		_radius = _sectorRadii select 1;
		_aggroLvl = _aggroLvl + 12.5;
		_numReinforcements = 2;
		_defVehNum = selectRandom[1,2,2];
		_maxEnemies = 20 - (_defVehNum * 3);
	};
	case "KIA": 
	{
		_radius = _sectorRadii select 2;
		_aggroLvl = _aggroLvl + 25;
		_numReinforcements = 3;
		_defVehNum = selectRandom[2,2,3];
		_maxEnemies = 25 - (_defVehNum * 3);
	};
};

//adjust for solo plays 
if ((count allPlayers) == 1) then 
{
	_maxEnemies = _maxEnemies + (_defVehNum * 3);
	_defVehNum = 0;
};

_tier = "Tier_4";
if (_aggroLvl >= 25 && _aggroLvl < 50) then 
{
	_tier = "Tier_3";
} else 
{
	if (_aggroLvl >= 50 && _aggroLvl < 75) then 
	{
		_tier = "Tier_2";
	} else 
	{
		if (_aggroLvl >= 75) then 
		{
			_tier = "Tier_1";
		};
	};
};

//check for close markers to call reinforcements from 
_currentSupportMarkers = allMapMarkers select 
{
	_x != _marker
	&& ("village" in _x || "military" in _x || "city" in _x)
	&& !("Temp" in _x)
	&& markerColor _x == "colorOPFOR"
	&& getMarkerPos _x distance2D (getMarkerPos _marker) <= 1000
	&& getMarkerPos _x distance2D hq_pos > 200
};

if (count _currentSupportMarkers < 1) then 
{
	_numReinforcements = 0;
};

_sectorInfo = format
[
	"Sector (%1): %2, Num Enemies: %3, Num Vehicles: %4, Num Reinforcements: %5", 
	_marker, _tier, _maxEnemies, _defVehNum, _numReinforcements
];
[_sectorTag, _sectorInfo, _debug] spawn bia_to_log;

//mark as active 
_actiMarker = "Temp_Activated" + "_" + _marker;
createMarker [_actiMarker, getMarkerPos _marker];
_actiMarker setMarkerTypeLocal "selector_selectedEnemy";
_actiMarker setMarkerColorLocal "colorBLUFOR";
_actiMarker setMarkerSize [1.5, 1.5];

_areaMarker = "Temp_Area" + "_" + _marker;
createMarker [_areaMarker, getMarkerPos _marker];
_areaMarker setMarkerShapeLocal "ELLIPSE";
_areaMarker setMarkerColorLocal "colorOPFOR";
_areaMarker setMarkerAlphaLocal 0.25;
_areaMarker setMarkerSize [_radius, _radius];

//spawn enemies
_varName = _marker + "_opfor";
_enemiesPrepared = [_marker, _tier, _maxEnemies, _defVehNum, _radius, _varName, _debug] spawn bia_sectors_sector_enemies;

while {!(scriptDone _enemiesPrepared)} do 
{
	uiSleep 1;
};
[_sectorTag, format["Marker %1: Enemies prepared", _marker], _debug] spawn bia_to_log;

//wait for sector to deactivate
_cleared = false; // set variable can take longer than 1 sec to be set for all 
_supportCalled = false;
_sectorActiStartTime = serverTime;
_sectorReactTime = _sectorActiStartTime + 60;
_sectorActive = missionNamespace getVariable [format["%1_active", _marker], false];
_lastEffort = false;

while {_sectorActive && !_cleared} do 
{
	_sectorActive = missionNamespace getVariable [format["%1_active", _marker], false];

	//check if sector cleared
	_sectorOpfor = allUnits select {_x getVariable [_varName, false] && side _x == east}; //&& _x distance2D (getMarkerPos _marker) < _radius};
	_sectorBlufor = allPlayers select 
	{
		_player = _x;
		_kindArr = [];

		{
			_type = _x;
			_kindArr pushBack ((vehicle _player) isKindOf _type);
		} forEach ["Car", "Tank", "Ship", "Helicopter", "Plane"];

		_x distance2D (getMarkerPos _marker) <= _radius 
		&& (vehicle _player == _player || _kindArr select 0 || _kindArr select 1)
	};

	{
		[_marker, _radius, _varName, _debug] remoteExec ["bia_progress_bar", _x];
	} forEach _sectorBlufor;

	if ((count _sectorOpfor) < (count _sectorBlufor)) then 
	{
		_cleared = true;
		missionNamespace setVariable [format["%1_active", _marker], false, true];
		_marker setMarkerColor "colorBLUFOR";
		
		_clearedPosArr = ["ClearedPosArr",[]] call bia_load_from_profile;
		_clearedPosArr pushBack (getMarkerPos _marker);
		["ClearedPosArr", _clearedPosArr] call bia_save_to_profile;
		[_sectorTag, "Saved newly cleared Sector", _debug] spawn bia_to_log;

		["Sector captured", "center_top", 5, 0, 0, 85, "Green"] remoteExec ["bia_spawn_text", 0];
	};

	//mobilize enemies when very few left 
	if (count _sectorOpfor <= 5 && serverTime > _sectorReactTime && !_lastEffort) then 
	{
		[_sectorTag, "Mobilizing last remaining defenders", _debug] spawn bia_to_log;
		_lastEffort = true;

		//_minDist = [getMarkerPos _marker, allPlayers] call bia_closest_dist;
		_dists = allPlayers apply {_x distance2D (getMarkerPos _marker)};
		_targetPlayer = allPlayers select (_dists find (selectMin _dists));

		if (!isNull _targetPlayer) then 
		{
			[_sectorTag, "Target player found for remaining defenders", _debug] spawn bia_to_log;

			_allGrps = _sectorOpfor apply {group _x};
			_grps = _allGrps arrayIntersect _allGrps;

			{
				[_x, _targetPlayer, _debug] spawn bia_hunt_target;
			} forEach _grps;
		};
	};

	//recheck how many support markers are usable since sector can be active for long and some might be taken already
	_newSupportMarkers = allMapMarkers select 
	{
		_x != _marker
		&& ("village" in _x || "military" in _x || "city" in _x)
		&& !("Temp" in _x)
		&& markerColor _x == "colorOPFOR"
		&& getMarkerPos _x distance2D (getMarkerPos _marker) <= 1000
		&& getMarkerPos _x distance2D hq_pos > 200
	};

	if (!(_currentSupportMarkers isEqualTo _newSupportMarkers)) then 
	{
		_currentSupportMarkers = _newSupportMarkers;

		if (count _newSupportMarkers < count _currentSupportMarkers) then 
		{
			_numReinforcements = _numReinforcements - 1;
		};
		if (count _newSupportMarkers > count _currentSupportMarkers) then 
		{
			_numReinforcements = _numReinforcements + 1;
		};
	};

	//call for reinforcements
	_maxTotalEnemies = missionNamespace getVariable ["MaxEnemies", 30];
	_currTotalEnemies = count(allUnits select {side _x == east});
	_numSuppEnemies = _maxEnemies / 2;

	if 
	(
		count _newSupportMarkers > 0 
		&& (count _sectorOpfor) < (_maxEnemies * 0.25)
		//&& !_supportCalled
		&& serverTime > _sectorReactTime
		&& _numReinforcements > 0
		&& (_currTotalEnemies + _numSuppEnemies) <= _maxTotalEnemies
	) then 
	{
		[_sectorTag, format["Marker %1 calling for support", _marker], _debug] spawn bia_to_log;
		["Enemy Reinforcements spotted", "center_top", 5, 0, 0, 85, "Red"] remoteExecCall ["bia_spawn_text", 0];

		//_supportCalled = true;
		_supportMarker = selectRandom _newSupportMarkers;
		[_marker, _supportMarker, _tier, _numSuppEnemies, _varName, _debug] spawn bia_sectors_sector_reinforcements;

		_numReinforcements = _numReinforcements - 1;
		_sectorReactTime = _sectorReactTime + 60; //avoid all reinforcements at once 
	};

	//check if marker should be deactivated due to too many active enemies 
	_totalActiveEnemies = allUnits select 
	{
		side _x == east &&
		!(_x getVariable ["patrolBool", false]) &&
		!(_x getVariable ["guardBool", false])
	};

	if (count _totalActiveEnemies > _maxTotalEnemies) then 
	{
		_activeMarkers = allMapMarkers select {missionNamespace getVariable [format["%1_active", _x], false]};
		_playerArr = allPlayers select {_x distance2D hq_pos > 200};

		_closestMarker = "";
		if (count _playerArr > 0) then 
		{
			_dists = _activeMarkers apply {[getMarkerPos _x, _playerArr] call bia_closest_dist};
			_idx = _dists find (selectMin _dists);
			_closestMarker = _activeMarkers select _idx;
		};

		if (_marker != _closestMarker || count _playerArr < 1) then 
		{
			missionNamespace setVariable [format["%1_active", _marker], false, true];
			[_sectorTag, format["Deactivated sector (%1): too many active Enemies + not closest Sector", _marker], _debug] spawn bia_to_log;
		};
	};

	uiSleep 1;
};

//delete everything in sector 
_sectorOpfor = allUnits select {_x getVariable [_varName, false]};
{
	deleteVehicle _x;
} forEach _sectorOpfor;

_vehicles = vehicles select {_x getVariable [_varName, false] || _x distance2D (getMarkerPos _marker) <= _radius};
{
	deleteVehicle _x;
} forEach _vehicles;

//delete acti marker 
_tempMarkers = allMapMarkers select {"Temp" in _x && _marker in _x};
{
	deleteMarker _x;
} forEach _tempMarkers;