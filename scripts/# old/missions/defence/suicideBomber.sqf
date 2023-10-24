//Suicide Bomber Script
//["O_bia_paramilitary_mercenaries_rifleman_m4","settlement_10",100] execVM "scripts\missions\suicideBomber.sqf";

_unitsArray = param [0,[]];
_missionLocation = param [1,""];
_radius = param [2,100];
_suicideBomb = selectRandom ["SatchelCharge_Remote_Ammo","M_AT","DemoCharge_Remote_Ammo"];

//get faction units
_suicideBomber = selectRandom (_unitsArray select 2); 

//create spawn pos
_tryPos = _missionLocation getPos [random _radius, random 360];
_suicideBomberPos = [_tryPos, 0, _radius, 1, 0, 20, 0] call BIS_fnc_findSafePos;

//create suicide bomber
_grp = createGroup east;
_suicideMan = _grp createUnit [_suicideBomber, _suicideBomberPos, [], 0, "NONE"];
removeAllWeapons _suicideMan;

//Set skill
[_grp,1] remoteExec ["bia_set_skill", 0, true];

//find out if buildings nearby
_objects = _missionLocation nearObjects _radius;
_houses = [];
{ if (count (_x call BIS_fnc_buildingPositions) > 0 && !("scaffolding" in str _x)) then {
	_houses pushBack _x;
	};
} forEach _objects;

//find usable positions
_suitablePosPerHouse = [];
if (count _houses > 0) then {
	//find building with most covered positions
	{
		_positions = _x call BIS_fnc_buildingPositions;
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 2, 0]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [2, 0, 0]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, -2, 0]]};
		_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [-2, 0, 0]]};
		if (count _positions > 0) then {_suitablePosPerHouse append _positions;};
	} forEach _houses;
};

if (count _suitablePosPerHouse < 1) then {
	_suitablePosPerHouse = [];
	if (count _houses > 0) then {
		{
			_positions = _x call BIS_fnc_buildingPositions;
			_positions = _positions select {lineIntersects [AGLToASL _x, (AGLToASL _x) vectorAdd [0, 0, 3]]};
			if (count _positions > 0) then {_suitablePosPerHouse append _positions;};
		} forEach _houses;
	};
};

if (count _suitablePosPerHouse > 0) then {
	_suicideMan setPos selectRandom _suitablePosPerHouse;
};

//start the attack
_alive = true;

while {_alive} do {
	//wait for target
	_players = allPlayers;
	while { _players findIf { (getPos _x) distance (getPos _suicideMan) < (_radius / 1.5) } == -1 } do { uiSleep 1; };
	_targetIdx = _players findIf { (getPos _x) distance (getPos _suicideMan) < (_radius / 1.5) };
	_target = _players select _targetIdx;
	
	//give move command
	_suicideMan doMove (getPos _target);
	
	//warn player
	while {_target distance _suicideMan > 35 && alive _suicideMan && alive _target} do { uiSleep 0.1; _suicideMan doMove (getPos _target); };
	if (_target distance _suicideMan <= 35  && alive _target && alive _suicideMan) then {
		[getMissionPath "sounds\suicideSound.wav",_suicideMan,false,getPos _suicideMan,5,1,50] remoteExec ["playSound3D", _target, true];
	};
		
	//detonate charge
	while {_target distance _suicideMan > 16 && alive _suicideMan && alive _target} do { uiSleep 0.1; _suicideMan doMove (getPos _target); };
	if (_target distance _suicideMan < 16) then {
		_suicideCharge = _suicideBomb createVehicle (getPos _suicideMan);
		_suicideCharge setDamage 1;
		_alive = false;
	};
	
	//reset for next opportunity or stop loop
	if (_alive && alive _suicideMan) then {
		_nearestHouse = nearestBuilding getPos _suicideMan;
		_housePos = selectRandom (_nearestHouse call BIS_fnc_buildingPositions);
		_suicideMan doMove _housePos;
	} else {
		_alive = false;
	};
};