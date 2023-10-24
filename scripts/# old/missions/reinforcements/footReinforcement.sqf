/*
[getPos manu,["test1"],["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf"] execVM "scripts\missions\reinforcements\footReinforcement.sqf";
*/

//Paras
params [
"_missionLocation",
"_missionMarkers",
"_unitsArray"
];

//Prep stuff
_missionAreaMarker	= _missionMarkers select 0;
_infantry				= (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);

//Spawn reinforcement group
_grpParameter = 	selectRandom	[	[2,6],
												[2,7],
												[2,8],
												[3,4],
												[3,5],
												[4,4]
											];

_numGroups	= _grpParameter select 0;
_grpSize 		= _grpParameter select 1;

for "_i" from 1 to _numGroups do {
	//find pos without water
	_landPos = _missionLocation getPos [450, random 360];
	while {surfaceIsWater _landPos} do {
		_landPos = _missionLocation getPos [450, random 360];
	};
	
	//Determine spawn pos
	_bestPlaces = selectBestPlaces [_landPos, 100, "2*houses + 0*meadow + 4*forest - 10*sea", 1, 1];
	_bestPlace = _bestPlaces select 0 select 0;
	_spawnpos = [_bestPlace, 0, 50, 1, 0, 10, 0] call BIS_fnc_findSafePos;
	
	_grp = createGroup east;
	
	for "_i" from 1 to _grpSize do {
		_infantryClass	= selectRandom _infantry;
		_soldier 			= _grp createUnit [_infantryClass, _spawnpos, [], 0, "NONE"];
	};
	
	//Add reinforcements to GAIA
	[_grp, _missionAreaMarker, "MOVE"] remoteExec ["bia_give_to_gaia", 0, true];
	
	//Set skill
	uiSleep 1;
	[_grp] remoteExec ["bia_set_skill", 0, true];
};
