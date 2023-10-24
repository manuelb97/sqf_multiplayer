//Paras
params [
"_missionLocation",
"_missionMarkers",
"_reinforcements_max",
"_unitsArray"
];

//Prep stuff
_missionAreaMarker	= _missionMarkers select 0;
_infantry				= (_unitsArray select 3) + (_unitsArray select 4) + (_unitsArray select 5);

//Spawn reinforcement group
_grpParameter = 	selectRandom	[	[5,2],
												[4,2],
												[3,3]
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
	
	//Give respawns
	[_grp,_reinforcements_max * 2] spawn GAIA_fnc_respawnSet;
	
	//Add reinforcements to GAIA
	[_grp, _missionAreaMarker, "MOVE"] remoteExec ["bia_give_to_gaia", 0, true];
	
	//Set skill
	uiSleep 1;
	[_grp] remoteExec ["bia_set_skill", 0, true];
};
