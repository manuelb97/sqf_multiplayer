//Params
params [
"_loc", 
"_radius",
"_debug"
];

_lampClasses = ["Land_LampShabby_F","Land_LampIndustrial_01_F"];
_numLamps = ceil((_radius / 50) * 2);

//check if there are already lamps / light at the loc 
_closeBuilds = _loc nearObjects ["Building", _radius];
_initialLamps = _closeBuilds select {"lamp" in str _x};

if (count _initialLamps >= _numLamps) then 
{
	["SpawnLamps", "Enough Lamps already present", _debug] spawn bia_to_log;
} else 
{
	// avoid lamps too close to each other 
	_initialLampArr = _initialLamps apply {[getPos _x, 10]};

	_lampsToSpawn = _numLamps - (count _initialLamps);
	for "_i" from 1 to _lampsToSpawn do 
	{
		_spawnPos = [_loc, 0, _radius, 2, 0, 20, 0, _initialLampArr, [_loc, _loc]] call BIS_fnc_findSafePos;
		_lamp = createVehicle [selectRandom _lampClasses, _spawnpos, [], 0, "NONE"];

		if (lightIsOn _lamp == "OFF") then 
		{
			[_lamp, "ON"] remoteExec ["switchLight", 0, true];
		};

		_initialLampArr pushBack [_spawnPos, 10];
	};

	["SpawnLamps", "Spawned Lamps around the Location", _debug] spawn bia_to_log;
};