//Paras
params [
"_missionLocation",
"_missionMarkers",
["_radius",100],
["_enemyObjCount",20],
["_reinforcements_max",1],
"_unitsArray"
];

// Set up Stuff
_reinforcements = 0;

//Wait for Mission to start
while {isNil "missionLoop"} do {uiSleep 5;};
//[format ["Starting Reinforcement Loop"]] remoteExec ["hint", 0, true]; uiSleep 3;

//Start Loop
while {missionLoop == 1 && _reinforcements < _reinforcements_max} do {
	uiSleep 10;
	
	_players = allPlayers;
	_host = selectRandom _players;
	if (count _players > 1) then {
		_players = _players - [manu];
		_host = selectRandom _players;
	};
	
	//Get Number of Current Enemies
	_objOpforLoop = [];
	{if ((side _x) == east && ((getPos _x) distance _missionLocation) < (_radius + 200) && !(_x getVariable ["patrolBool", false])) then {_objOpforLoop pushBack _x}} forEach allUnits;
	_newEnemyObjCount = count _objOpforLoop;
	//[format ["New enemy count: %1, old enemy count: %2",_newEnemyObjCount,_enemyObjCount]] remoteExec ["hint", 0, true]; uiSleep 3;
	
	//Check if Reinforcements should be spawned
	if (_newEnemyObjCount < (_enemyObjCount * 0.8)) then 
	{
		[_missionLocation,_missionMarkers,_reinforcements,_reinforcements_max,_unitsArray] remoteExec ["bia_reinforcements", _host, true];
		_reinforcements = _reinforcements + 1;
		//[format ["Spawning reinforcements"]] remoteExec ["hint", 0, true]; uiSleep 3;
		uiSleep 90;
		//[format ["Reinforcements can spawn again"]] remoteExec ["hint", 0, true]; uiSleep 3;
	};
};