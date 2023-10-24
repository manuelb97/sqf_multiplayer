//Paras
params [
"_missionLocation",
"_missionMarkers",
"_defVehicles",
["_radius",100],
"_unitsArray"
];
_missionAreaMarker = _missionMarkers select 0;

_VehGr = (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);

if (count _defVehicles > 0) then {
	{
		_spawnpos = [(_missionLocation) getPos [random 100, random 360], 0, 200, 10, 0, 20, 0] call BIS_fnc_findSafePos;
		_nearRoads = _spawnpos nearRoads 300;
		if (count _nearRoads > 0) then {
			_spawnRoad = selectRandom _nearRoads;
			_spawnpos = [getPos _spawnRoad, 0, 100, 10, 0, 20, 0, [], getPos _spawnRoad] call BIS_fnc_findSafePos;
		};
		_spawnpos = [_spawnpos select 0, _spawnpos select 1, 0] vectorAdd [0,0,1];
		_newvehicle = _x createVehicle _spawnpos;
		_newvehicle setpos _spawnpos;

		_newvehicle allowdamage false;
		
		clearWeaponCargoGlobal _newvehicle;
		clearMagazineCargoGlobal _newvehicle;
		clearItemCargoGlobal _newvehicle;
		clearBackpackCargoGlobal _newvehicle;

		private _grp = createGroup [east, true];
		
		_crewSeats = [_x,false] call BIS_fnc_crewCount;
		while {count units _grp <= _crewSeats} do {
				(selectRandom _VehGr) createUnit [getpos _newvehicle, _grp];
		};
		{
			_x moveInAny _newvehicle;
		} forEach units _grp;
		
		_newvehicle allowdamage true;
		_newvehicle setdamage 0;
		
		//hopefully avoids them being unable to follow waypoints
		sleep 1;
		{
			moveOut _x;
		} forEach units _grp;
		sleep 1;
		{
			_x moveInAny _newvehicle;
		} forEach units _grp;
		sleep 1;
		{
			moveOut _x;
		} forEach units _grp;
		sleep 1;
		{
			_x moveInAny _newvehicle;
		} forEach units _grp;
		
		//Give to gaia
		[_grp, _missionAreaMarker, "NOFOLLOW"] remoteExec ["bia_give_to_gaia", 0, true];
		//[_grp, _missionLocation, selectRandom[_radius/5,_radius/4,_radius/3]] call BIS_fnc_taskPatrol;
		
		//Set skill
		[_grp] remoteExec ["bia_set_skill", 0, true];
	} forEach _defVehicles;
};