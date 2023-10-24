//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_class", "_solo", "_tex", "_debug"];

_veh = createVehicle [_class, [0,0,1000], [], 0, "NONE"];
_turretMags = (_veh magazinesTurret [-1]) + (_veh magazinesTurret [0]);
deleteVehicle _veh;

if (count _turretMags > 0 && missionNamespace getVariable ["SideMissionActive", false]) exitWith
{
	hint "This vehicle cant be used in side missions";
};

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

if (getMarkerPos _nearestMarker distance2D mapPos > 1000) then 
{
	private "_veh";
	//check how to spawn
	_kindArr = [];

	{
		_kindArr pushBack (_class isKindOf _x);
	} forEach ["Car", "Tank", "Ship", "Helicopter", "Plane"];

	//Spawn
	if (_kindArr select 0 || _kindArr select 1) then 
	{
		_spawnPos = [mapPos, 0, 100, 10, 0, 20, 0, [], [mapPos, mapPos]] call BIS_fnc_findSafePos;

		if (count _spawnPos == 2) then 
		{
			_veh = createVehicle [_class, _spawnpos, [], 0, "NONE"];

			if (!_solo) then //cant use cars as wheeled tanks = cars
			{
				_grp = createGroup west;
				_soldier = _grp createUnit ["B_Soldier_F", getpos _veh, [], 0, "NONE"];
				_soldier moveInDriver _veh;
				_soldier disableAI "all";

				[_caller] joinSilent _grp;
				_grp selectLeader _caller;

				_caller moveInGunner _veh;
			} else 
			{
				_caller moveInDriver _veh;
			};
		} else 
		{
			hint "No suitable Position found";
		};
	} else 
	{
		//Boat
		if (_kindArr select 2) then 
		{
			_spawnPos = [mapPos, 0, 100, 10, 2, 20, 0, [], [mapPos, mapPos]] call BIS_fnc_findSafePos;

			if (count _spawnPos == 2) then 
			{
				_veh = createVehicle [_class, _spawnpos, [], 0, "NONE"];
				_caller moveInDriver _veh;
			} else 
			{
				hint "No suitable Position found";
			};
		};

		//Air
		if (_kindArr select 3 || _kindArr select 4) then 
		{
			_spawnPos = [mapPos, 0, 100, 0, 2, 20, 0, [], [mapPos, mapPos]] call BIS_fnc_findSafePos;
			_veh = createVehicle [_class, _spawnpos, [], 0, "FLY"];
			_veh setPosATL [mapPos select 0, mapPos select 1, 200];
			_caller moveInDriver _veh;
		};
	};

	_ret = [_veh, _tex] call BIS_fnc_initVehicle;
} else 
{
	hint "Too close to Enemy Sectors";
};