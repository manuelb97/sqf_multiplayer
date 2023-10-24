// [1,0,0,0,0] execVM "scripts\missions\randomMissionLocation.sqf";

//Paras
params [
["_houses",1],
["_hills",1],
["_meadow",1],
["_sea",1],
["_forest",1]
];

/*
{ deleteMarker _x; } forEach allMapMarkers;
_houses = 1;
_hills = 0;
_meadow = 0;
_sea = 0;
_forest = 0;
*/

//Get random position not on water
_missionPos = [nil, ["water"]] call BIS_fnc_randomPos;

//find location based on criteria
_searchExp = format ["%1*houses + %2*hills + %3*meadow + %4*sea + %5*forest", _houses,_hills,_meadow,_sea,_forest];
_missionLocations = selectBestPlaces [_missionPos, 1000, _searchExp, 1, 1];
_missionLocation = _missionLocations select 0 select 0;

//check quality of search result
_counter = 0;
_buildings = []; 
{ 
	if (str _x find ": i_" > -1 || str _x find "house" > -1 || str _x find "shed" > -1 || str _x find "building" > -1 || str _x find "addon" > -1) then { _buildings pushBack _x; };
} forEach nearestObjects [_missionLocation, [], 50];

if (_houses > 0.5) then {
	while {count _buildings < 10} do {
		_missionPos = [nil, ["water"]] call BIS_fnc_randomPos;
		_searchExp = format ["%1*houses + %2*hills + %3*meadow + %4*sea + %5forest", _houses,_hills,_meadow,_sea,_forest];
		_missionLocations = selectBestPlaces [_missionPos, 1000, _searchExp, 1, 1];
		_missionLocation = _missionLocations select 0 select 0;
		_buildings = []; 
		{ 
			if (str _x find ": i_" > -1 || str _x find "house" > -1 || str _x find "shed" > -1 || str _x find "building" > -1 || str _x find "addon" > -1) then { _buildings pushBack _x; };
		} forEach nearestObjects [_missionLocation, [], 50];

		/*
		//determine comp location
		_compLocation = [_missionLocation, 0, 500, 1, 0, 0.1, 0] call BIS_fnc_findSafePos;
		if (_compLocation isEqualTo [worldSize/2,worldSize/2,0]) then {_compLocation = [_missionLocation, 0, 500, 1, 0, 5, 0] call BIS_fnc_findSafePos;};
		
		//clear area
		_radius = 60;
		_objects = _compLocation nearObjects _radius;
		_objects append (nearestTerrainObjects [_compLocation, [], _radius, false, false]);
		{ hideObjectGlobal _x } forEach _objects;
		
		//determine comp
		_comp = selectRandom[	"buildingRuinsMedium1.sqf",
											"buildingRuinsMedium2.sqf",
											"buildingRuinsMedium3.sqf",
											
											//"concreteBunkerLarge1.sqf",
											//"concreteBunkerLarge2.sqf",
											//"concreteBunkerLarge3.sqf",
											//"concreteBunkerLarge4.sqf",
											//"concreteBunkerLarge5.sqf",
											
											//"concreteBunkerMedium1.sqf",
											//"concreteBunkerMedium2.sqf",
											
											//"concreteTowerMedium1.sqf",
											//"concreteTowerMedium2.sqf",
											
											"constructionSideLarge1.sqf",
											
											"militaryBase1.sqf",
											"militaryBase2.sqf",
											"militaryBase3.sqf"
										];
		_compScript = format["scripts\missions\compositions\%1",_comp];
		
		//spawn comp
		[_compLocation, random 360, call compile preprocessFileLineNumbers _compScript] call BIS_fnc_ObjectsMapper;
		_missionLocation = _compLocation;
		//[format ["Spawned comp"]] remoteExec ["hint", 0, true]; uiSleep 3;
		
		//make comp indestructable
		_objects = _missionLocation nearObjects _radius;
		{ _x allowDamage false; } forEach _objects;
		*/
	};
};

//use search result
_missionLocation