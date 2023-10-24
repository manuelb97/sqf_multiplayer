//Paras
_missionType = param [0,""];

//set default values
_houses = 3;
_hills = 1;
_meadow = 1;
_forest = 1;
_sea = -3;

//set values based on mission
switch _missionType do {
    case "Liberation": {
		_houses = 0.4; // values above 0.5 trigger forced building search
		_hills = 0;
		_meadow = 0;
		_forest = 0;
	};
    case "Defence": {
		_houses = 1;
		_hills = 0;
		_meadow = 0;
		_forest = 0;
	};
    case "Heist": {
		_houses = 1;
		_hills = 0;
		_meadow = 0;
		_forest = 0;
	};
    case "HVT": { 
		_houses = 1; 
		_hills = 0;
		_meadow = 0;
		_forest = 0;
	};
    case "Escape": {
		_houses = 0;
		_hills = 0.25;
		_meadow = 0;
		_forest = 1;
	};
    case "Sniper": {
		_houses = 0;
		_hills = 0.3;
		_meadow = 1;
		_forest = 0.3;
	};
    case "Sabotage": {
		_houses = 0.3;
		_hills = 0;
		_meadow = 0;
		_forest = 0.3;
	};
    case "Zombie": {
		_houses = 1;
		_hills = 0;
		_meadow = 0;
		_forest = 0.3;
	};
};

//return paras
_returnArray = [_houses, _hills, _meadow, _sea, _forest];
_returnArray