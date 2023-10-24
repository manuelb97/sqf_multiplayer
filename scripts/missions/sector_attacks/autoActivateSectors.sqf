//Paras
params [
"_radius",
"_sectorRadii",
"_maxAddPerSector",
"_delayBetweenActivations",
"_debug"
];

_autoMarkerTag = "activeSectorsLoop";
_oldActiveMarkers = [];
_recentlyDeactivatedSectors = [];
_relMarkerTypes = missionNamespace getVariable ["MarkerTypes", []];
missionNamespace setVariable ["AutoActivateSectors", true, true];

while {true} do 
{
	_maxEnemies = missionNamespace getVariable ["MaxEnemies", 30];

	//need to include guys in parachute otherwise zone deactiavtion
	_westArr = allPlayers select 
	{
		_player = _x;
		_class =  typeOf (vehicle _player);
		_kindArr = [];
		{
			_kindArr pushBack (_class isKindOf _x);
		} forEach ["Car", "Tank", "Ship", "Helicopter", "Plane"];

		_player distance2D hq_pos > 100 
		&& ((vehicle _player) == _player || typeOf (vehicle _player) == "B_Parachute" || _kindArr select 0 || _kindArr select 1)
	};
	_friendlyAIUnits = allUnits select {side _x == west && !isPlayer _x && _x distance2D hq_pos > 100 && _x getVariable["TriggerSectors", false]};
	_westArr = _westArr + _friendlyAIUnits; // allow drones / ai squads to trigger zones

	_activeMarkers = allMapMarkers select {missionNamespace getVariable [format["%1_active", _x], false]};

	if (!(_oldActiveMarkers isEqualTo _activeMarkers)) then 
	{
		[_autoMarkerTag, format["Active Markers: %1", _activeMarkers], _debug] spawn bia_to_log;
		_oldActiveMarkers = _activeMarkers;
	};
	
	if (count _westArr > 0) then 
	{
		//activate close sectors 
		_closeMarkers = allMapMarkers select 
		{
			_closestDist = [getMarkerPos _x, _westArr] call bia_closest_dist;

			_closestDist <= _radius
			&& !(missionNamespace getVariable [format["%1_active", _x], false])
			&& !("Temp" in _x)
			&& (getMarkerPos _x) distance2D hq_pos > 200
			&& (markerColor _x) != "colorBLUFOR"
			&& (markerType _x) in _relMarkerTypes
		};

		if (count _closeMarkers > 0 && !(missionNamespace getVariable ["SideMissionActive", false])) then 
		{
			_currActiveEnemies = allUnits select 
			{
				side _x == east && 
				!(_x getVariable ["patrolBool", false]) &&
				!(_x getVariable ["guardBool", false])
			};

			if (((count _currActiveEnemies) + _maxAddPerSector) <= _maxEnemies) then 
			{
				_dists = _closeMarkers apply {[getMarkerPos _x, _westArr] call bia_closest_dist};
				_closestMarker = _closeMarkers select (_dists find (selectMin _dists));

				[_closestMarker, _sectorRadii, _maxEnemies, _debug] spawn bia_sectors_activate_sector;
				[_autoMarkerTag, format["Activating Marker (%1)", _closestMarker], _debug] spawn bia_to_log;
				
				missionNamespace setVariable ["ReduceEnemies", false, true];
				[_autoMarkerTag, format["Unblocked spawning of random Units"], _debug] spawn bia_to_log;
			};
		};
		
		if 
		(
			count(allUnits select {side _x == east}) > _maxEnemies &&
			!(missionNamespace getVariable ["ReduceEnemies", false])
		) then
		{
			missionNamespace setVariable ["ReduceEnemies", true, true];
			[_autoMarkerTag, format["Blocked spawning of random Units"], _debug] spawn bia_to_log;
		};

		//deactivate far sectors 
		_farActiveSectors = allMapMarkers select 
		{
			_markerPos = getMarkerPos _x;
			_nearestPlayer = [_westArr, _markerPos] call BIS_fnc_nearestPosition;

			_markerPos distance2D _nearestPlayer > (_radius + 200)
			&& missionNamespace getVariable [format["%1_active", _x], false]
		};

		if (count _farActiveSectors > 0) then 
		{
			[_autoMarkerTag, "Deactivating far sectors", _debug] spawn bia_to_log;

			{
				missionNamespace setVariable [format["%1_active", _x], false, true];
			} forEach _farActiveSectors;

			_farActiveSectors = _farActiveSectors apply {[_x, serverTime]};
			_recentlyDeactivatedSectors append _farActiveSectors;
		};
	} else 
	{
		//deactivate sectors
		_activeSectors = allMapMarkers select {missionNamespace getVariable [format["%1_active", _x], false]};

		if (count _activeSectors > 0) then 
		{
			[_autoMarkerTag, "Deactivating all sectors", _debug] spawn bia_to_log;

			{
				missionNamespace setVariable [format["%1_active", _x], false, true];
			} forEach _activeSectors;

			_activeSectors = _activeSectors apply {[_x, serverTime]};
			_recentlyDeactivatedSectors append _activeSectors;
		};
	};

	//check which sectors can be enabled again
	if (count _recentlyDeactivatedSectors > 0) then 
	{
		_reanableSectors = [];
		{
			_sectorInfo = _x;
			_deactiTime = _sectorInfo select 1;

			if (serverTime >= (_deactiTime + _delayBetweenActivations)) then 
			{
				_reanableSectors append (_sectorInfo);
			};
		} forEach _recentlyDeactivatedSectors;
		_recentlyDeactivatedSectors = _recentlyDeactivatedSectors - _reanableSectors;
	};

	uiSleep 5;
};

/* 
{
	//check if deleting patrols + house guards change something 
	_nonSectorUnits = allUnits select 
	{
		(side _x == east) &&
		(
			_x getVariable ["patrolBool", false] ||
			_x getVariable ["guardBool", false]
		)
	};
	_numNonSectorUnits = count _nonSectorUnits;
	_numSectorUnits = count (_currActiveEnemies - _nonSectorUnits);

	if 
	(
		_numNonSectorUnits > 0 && 
		(_numSectorUnits + _maxAddPerSector) <= _maxEnemies
	) then 
	{
		_nonSectorUnits = [_nonSectorUnits, [], 
		{
			_pos = getPos _x;
			_nearestPlayer = ([_westArr, [], {_x distance2D _pos}, "ASCEND"] call BIS_fnc_sortBy) select 0;
			_pos distance2D _nearestPlayer
		}, "DESCEND"] call BIS_fnc_sortBy;

		_toDelete = (count _currActiveEnemies - _maxEnemies) + _maxAddPerSector;
		_unitsToDelete = _nonSectorUnits select [0, _toDelete];

		{
			deleteVehicle _x;
		} forEach _unitsToDelete;
	};
};
*/

// _activeSectors = allMapMarkers select 
// {
// 	_sectorPos = getMarkerPos _x;
// 	_minDist = selectMin(_westArr apply {_x distance2D _sectorPos});
	
// 	if (typeName _minDist != "SCALAR") then 
// 	{
// 		_minDist = 0;
// 	};

// 	missionNamespace getVariable [format["%1_active", _x], false] 
// 	&& _minDist > (_radius + 200) 
// };