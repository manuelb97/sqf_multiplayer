//Paras
_missionType 		= param [0,""];
_missionLocation	= param [1,[]];
_missionArea 		= param [2,""];
_tier 					= param [3,"Tier_4"];

//Privates
private [	"_radius","_mobileEnemies","_cqbEnemies","_reinforcements_max","_defVehicles","_mortar","_mortarPatrols",
			"_suicideBomber","_suicideBomberNum","_countdown","_mortar_chance","_escapeVehicles","_GroupSizes","_returnArray"];

//Liberation, HVT, Heist
if (_missionType in ["Liberation","HVT","Heist","Sniper","Sabotage","Zombie"]) then 
{
	_defVehicles = [_tier] call compile preprocessFileLineNumbers "scripts\missions\sectorVehicles.sqf";
	
	if (_missionArea == "small") then {
		_totalEnemies 	= selectRandom[11,13,15];
		_mobileEnemies 	= round(_totalEnemies * 0.7);
		_cqbEnemies		= round(_totalEnemies * 0.3);
		
		_radius = 50;
		if (_missionType == "HVT" || _missionType == "Heist") then { _radius = 150; };
		_reinforcements_max = selectRandom[1,1,2];
		
		_mortar = selectRandom[0,0,0,0,1];
		_mortarPatrols = selectRandom[1,1,2];
		
		_suicideBomber = selectRandom[0,1];
		_suicideBomberNum = selectRandom[1,1,2];
		
		_countdown = 25;
	};
		
	if (_missionArea == "medium") then {
		_totalEnemies = selectRandom[13,15,17];
		_mobileEnemies 	= round(_totalEnemies * 0.7);
		_cqbEnemies		= round(_totalEnemies * 0.3);
		
		_radius = 100;
		if (_missionType == "HVT" || _missionType == "Heist") then { _radius = 150; };
		_reinforcements_max = selectRandom[1,2,2];
		
		_mortar = selectRandom[0,0,0,1];
		_mortarPatrols = selectRandom[1,2,2];
		
		_suicideBomber = selectRandom[0,1,1];
		_suicideBomberNum = selectRandom[1,1,2,2];
		
		_countdown = 30;
	}; 

	if (_missionArea == "big") then {
		_totalEnemies = selectRandom[15,17,19];
		_mobileEnemies 	= round(_totalEnemies * 0.7);
		_cqbEnemies		= round(_totalEnemies * 0.3);
		
		_radius = 150;
		_reinforcements_max = selectRandom[2,2,3];
		
		_mortar = selectRandom[0,0,1];
		_mortarPatrols = selectRandom[2,2,3];
		
		_suicideBomber = selectRandom[0,1,1,1];
		_suicideBomberNum = selectRandom[1,2,2,3];
		
		_countdown = 35;
	}; 

	if (_missionArea == "huge") then {
		_totalEnemies = selectRandom[21,23,25];
		_mobileEnemies 	= round(_totalEnemies * 0.7);
		_cqbEnemies		= round(_totalEnemies * 0.3);
		
		_radius = 200;
		_reinforcements_max = selectRandom[2,3,3];
		
		_mortar = selectRandom[0,1];
		_mortarPatrols = selectRandom[2,3,3];
		
		_suicideBomber = selectRandom[0,1,1,1,1];
		_suicideBomberNum = selectRandom[2,3];
		
		_countdown = 40;
	};
	
	_suicideBomber = 0;
	
	// force players into small area in zombie missions
	if (_missionType in ["Zombie"]) then {
		_radius = 50;
	};
	
	_returnArray = [_radius,
					_mobileEnemies,
					_cqbEnemies,
					_reinforcements_max,
					_defVehicles,
					_mortar,
					_mortarPatrols,
					_suicideBomber,
					_suicideBomberNum,
					_countdown];
};

//Defence
if (_missionType == "Defence") then 
{
	if (_missionArea == "small") then {
		_radius = 50;
		_reinforcements_max = selectRandom [3,4];
		_mortar_chance = [selectRandom [true, false, false, false], random [2, 3, 5]];
		_countdown = 15;
	};
		
	if (_missionArea == "medium") then {
		_radius = 100;
		_reinforcements_max = selectRandom [4,5];
		_mortar_chance = [selectRandom [true, true, false, false], random [3, 5, 7]];
		_countdown = 20;
	}; 

	if (_missionArea == "big") then {
		_radius = 150;
		_reinforcements_max = selectRandom [6,7];
		_mortar_chance = [selectRandom [true, true, true, false], random [6, 8, 10]];
		_countdown = 25;
	}; 

	if (_missionArea == "huge") then {
		_radius = 200;
		_reinforcements_max = selectRandom [8,9];
		_mortar_chance = [selectRandom [true, true, true, false], random [8, 10, 12]];
		_countdown = 30;
	};
	
	_returnArray = [	_radius, 
							_reinforcements_max,
							_mortar_chance,
							_countdown];
};

//Escape
if (_missionType == "Escape") then 
{
	_escapeVehicles = [_tier] call compile preprocessFileLineNumbers "scripts\missions\sectorVehicles.sqf";
	_possible_GroupSizes = [1,2,3,4];
	
	if (_missionArea == "small") then {
		_radius = 500;
		
		_maxEnemies = selectRandom[10,12];
		_GroupSizes = [];
		
		_gettingGroups = 1;
		_tmpMaxEnemies = _maxEnemies;
		while {_gettingGroups == 1} do {
			_groupSize = selectRandom _possible_GroupSizes;

			if ((_tmpMaxEnemies - _groupSize) >= 0) then {
				_tmpMaxEnemies = _tmpMaxEnemies - _groupSize;
				_GroupSizes pushBack _groupSize;
			};
			
			if (_tmpMaxEnemies == 0) then {
				_gettingGroups = 0;
			};
		};
	};
		
	if (_missionArea == "medium") then {
		_radius = 1000;
		
		_maxEnemies = selectRandom[12,14];
		_GroupSizes = [];
		
		_gettingGroups = 1;
		_tmpMaxEnemies = _maxEnemies;
		while {_gettingGroups == 1} do {
			_groupSize = selectRandom _possible_GroupSizes;

			if ((_tmpMaxEnemies - _groupSize) >= 0) then {
				_tmpMaxEnemies = _tmpMaxEnemies - _groupSize;
				_GroupSizes pushBack _groupSize;
			};
			
			if (_tmpMaxEnemies == 0) then {
				_gettingGroups = 0;
			};
		};
	}; 

	if (_missionArea == "big") then {
		_radius = 1500;
		
		_maxEnemies = selectRandom[14,16];
		_GroupSizes = [];
		
		_gettingGroups = 1;
		_tmpMaxEnemies = _maxEnemies;
		while {_gettingGroups == 1} do {
			_groupSize = selectRandom _possible_GroupSizes;

			if ((_tmpMaxEnemies - _groupSize) >= 0) then {
				_tmpMaxEnemies = _tmpMaxEnemies - _groupSize;
				_GroupSizes pushBack _groupSize;
			};
			
			if (_tmpMaxEnemies == 0) then {
				_gettingGroups = 0;
			};
		};
	};
	
	if (_missionArea == "huge") then {
		_radius = 2000;
		
		_maxEnemies = selectRandom[16,18];
		_GroupSizes = [];
		
		_gettingGroups = 1;
		_tmpMaxEnemies = _maxEnemies;
		while {_gettingGroups == 1} do {
			_groupSize = selectRandom _possible_GroupSizes;

			if ((_tmpMaxEnemies - _groupSize) >= 0) then {
				_tmpMaxEnemies = _tmpMaxEnemies - _groupSize;
				_GroupSizes pushBack _groupSize;
			};
			
			if (_tmpMaxEnemies == 0) then {
				_gettingGroups = 0;
			};
		};
	};
	
	_returnArray = [	_radius,
							_escapeVehicles,
							_GroupSizes
							];
};

_returnArray