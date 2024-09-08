//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_supp = "Infantry";
_cd = missionNamespace getvariable [format["%1SupportCD", _supp], 300];
_lastExe = missionNamespace getvariable [format["Last%1Support", _supp], serverTime - _cd];

if (servertime >= (_lastExe + _cd)) then 
{
	_lastExe = missionNamespace setvariable [format["Last%1Support", _supp], serverTime, true];
	_arguments params ["_classArr"];

	//Wait for Input or Cancel
	openMap true;
	clicked = 0;
	onMapSingleClick 
	{
		mapPos = _pos; 
		clicked = 1; 
		onMapSingleClick ""; 
		true;
	};

	while {!visibleMap} do
	{
		uiSleep 0.1;
	};
		
	while {clicked == 0 && visibleMap} do
	{
		uiSleep 0.1;
	};

	if (clicked == 0) exitWith {};
	openMap false;

	_enemyMarkers = allMapMarkers select {markerColor _x == "colorOPFOR"};
	_nearestMarker = [_enemyMarkers, mapPos] call BIS_fnc_nearestPosition;

	if (getMarkerPos _nearestMarker distance2D mapPos > 500) then 
	{
		[
			"Spawned Infantry Team"
		] remoteExec ["bia_spawn_text", _caller];

		//Spawn Group
		_grp = createGroup [west, true];

		{
			_class = _x;
			_soldier = _grp createUnit [_class, mapPos vectorAdd [0,0,0.5], [], 0, "NONE"];
			_soldier disableAI "AUTOCOMBAT";
		} forEach _classArr;

		// [units _grp, 0.4] call bia_set_skill;
		//[mapPos, west, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> "BUS_InfSquad")] call BIS_fnc_spawnGroup;

		_enemyMarkers = allMapMarkers select {markerColor _x == "colorOPFOR"};
		_nearestMarker = [_enemyMarkers, mapPos] call BIS_fnc_nearestPosition;
		
		_wpPos = getMarkerPos _nearestMarker;
		_formation = selectRandom ["LINE", "WEDGE", "ECH LEFT", "ECH RIGHT"];
		[_grp, _wpPos, 10, "SAD", _formation, "FULL", "AWARE", "YELLOW"] call bia_add_wp;

		while 
		{
			count (units _grp) > 0 || 
			markerColor _nearestMarker != "colorBLUFOR" || 
			count (allPlayers select {_x distance (getMarkerPos _nearestMarker) < 200}) > 0
		} do 
		{
			uiSleep 1;
		};

		if (count (units _grp) > 0) then 
		{
			{
				deletevehicle _x;
			} forEach (units _grp);
		};
	} else 
	{
		[
			"Cant spawn Infantry Team this close to sectors"
		] remoteExec ["bia_spawn_text", _caller];
	};
} else 
{
	[
		format["Infantry Support denied, remaining Cooldown: %1", round((_lastExe + _cd) - serverTime)]
	] remoteExec ["bia_spawn_text", _caller];
};