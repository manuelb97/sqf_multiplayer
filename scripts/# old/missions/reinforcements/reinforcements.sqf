//[getPos manu,["test1"],0,2,["Tier_4"] call compile preprocessFileLineNumbers "scripts\missions\factionUnits.sqf"] execVM "scripts\missions\reinforcements\reinforcements.sqf";

//Paras
params [
"_missionLocation",
"_missionMarkers",
"_reinforcements",
["_reinforcements_max",1],
"_unitsArray"
];

//Reinforcement Type
_reinforcements = _reinforcements + 1;
_reinforcementType = selectRandom["air","ground","foot"]; //"artillery"
[format ["Calling %1 reinforcement",_reinforcementType]] remoteExec ["hint", 0, true]; uiSleep 3;

//air or ground reinforcement
if (_reinforcementType == "air" or _reinforcementType == "ground") then 
{	
	//[format ["Calling vehicle reinforcement"]] remoteExec ["hint", 0, true]; uiSleep 3;
	[_missionLocation,_missionMarkers,_reinforcementType,_unitsArray] execVM "scripts\missions\reinforcements\reinforcementVehicle.sqf";
};

//foot reinforcement
if (_reinforcementType == "foot") then {
	//[format ["Calling foot reinforcement"]] remoteExec ["hint", 0, true]; uiSleep 3;
	[_missionLocation,_missionMarkers,_unitsArray] execVM "scripts\missions\reinforcements\footReinforcement.sqf";

	_players = [];
	{ 
		if (side _x == west && _x inArea Flare_Trigger) then {_players pushBack _x};
	} forEach allPlayers;
	
	if (count _players > 0) then {
		"Heavy Artillery inbound" remoteExec ["hint", 0, true];
		uiSleep 7;
		
		_playerPos = getPos (selectRandom _players);
		_targetPos = _playerPos getPos[selectRandom[20,30,40],selectRandom[0,45,90,135,180,225,270,315]];
		_radius = selectRandom[80,90,100,110,120];
		_rounds = selectRandom[4,5,6,7];
		_delay = [3,8];
		_altitude = 500;
		[_targetPos, 'Sh_82mm_AMOS', _radius, _rounds, _delay, nil, selectRandom[50,60,70], 400, 80, []] spawn BIS_fnc_fireSupportVirtual;
	};
};

//reinforcement loop
private ["_allReinforcementsSpawned"];
if (_reinforcements == _reinforcements_max) then { 
	_allReinforcementsSpawned = 1; 
} else {
	_allReinforcementsSpawned = 0; 
};

_returnArray = [_allReinforcementsSpawned, _reinforcements];
_returnArray