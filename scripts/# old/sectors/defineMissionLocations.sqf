/* Debug
[] call compileFinal preprocessFileLineNumbers "scripts\sectors\defineMissionLocations.sqf";
[] execVM "scripts\sectors\defineMissionLocations.sqf";
*/

/*
{ 
	if (!(_x in sectors) && !(_x in legendMarkers)) then {
		deleteMarker _x; 
	};
} forEach allMapMarkers;
*/

//Find positions for mission types and mark with respective marker
//Mission Types
_urban = ["Defence", "Defence", "HVT", "Heist", "Zombie"];
_semiUrban = ["Liberation", "Sabotage"];
_nonUrban = ["Liberation", "Escape", "Escape", "Sabotage"]; //, "Sniper"

//Markers
_urbanMarkers = ["mil_flag","mil_flag","mil_end","mil_unknown","mil_circle"];
_sUrbanMarkers = ["mil_marker","mil_join"];
_nUrbanMarkers = ["mil_marker","mil_pickup","mil_pickup","mil_join"]; //,"mil_objective"
_markerColors = ["ColorCIV","ColorGUER","ColorWEST","ColorEAST"];

//"Lib: 41, Def: 16, HVT: 13, Heist: 16, Sab: 35, Esc: 29, Zombie: 17"

//
_mapSize = worldName call BIS_fnc_mapSize;
_radius =  (_mapSize / 4) + 3000; // have to add since nearestLocations searches in circle, we use rectangles
_urbanTypes = ["NameCityCapital", "NameCity", "NameVillage"]; //"CityCenter" leads to duplicates
_sUrbanTypes = ["NameLocal"];
_missionPerSector = 40;
_numUrbanMissions = _missionPerSector / 2;
_numSUrbanMissions = (_missionPerSector - _numUrbanMissions) / 2;
_numNUrbanMissions = _missionPerSector - _numUrbanMissions - _numSUrbanMissions;

_counter = 0;

hint format["Number of Sectors: %1",count(sectors)];

for "_i" from 1 to count(sectors) do {
	hint format["Started Sector %1",_i];
	
	_sectorNum = _i - 1;
	_sector = sectors select _sectorNum;
	_pos = getMarkerPos (sectors select (_i - 1));
	_urbanLocs = nearestLocations [_pos, _urbanTypes, _radius, _pos];
	_sUrbanLocsInitial = nearestLocations [_pos, _sUrbanTypes, _radius, _pos];
	
	// remove locations surrounded by water
	_sUrbanLocs = [];
	{
		_loc = _x;
		_locPos = locationPosition _x;
		_waterArr = [];
		
		if (surfaceIsWater (_locPos getPos [150, 45])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_locPos getPos [150, 135])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_locPos getPos [150, 225])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_locPos getPos [150, 315])) then { _waterArr pushBack true;};
		
		if (count _waterArr < 2) then {_sUrbanLocs pushBack _loc; };
	} forEach _sUrbanLocsInitial;
	
	//remove locs outside of sector
	{
		_element = _x;
		_loc = locationPosition _element;
		_loc = [_loc select 0, _loc select 1];
		if (!(_loc inArea _sector)) then {
			//_urbanLocs deleteAt (_urbanLocs find _element);
			_urbanLocs = _urbanLocs - [_element];
			_counter = _counter + 1;
		};
	} forEach _urbanLocs;
	
	{
		_element = _x;
		_loc = locationPosition _element;
		_loc = [_loc select 0, _loc select 1];
		if (!(_loc inArea _sector)) then {
			//_sUrbanLocs deleteAt (_sUrbanLocs find _element);
			_sUrbanLocs = _sUrbanLocs - [_element];
			_counter = _counter + 1;
		};
	} forEach _sUrbanLocs;
	
	_numUrban = count _urbanLocs;
	_numSUrban = count _sUrbanLocs;
	
	//check if we have to adjust mission numbers
	if (_numUrban == 0 && _numSUrban == 0) then {
		_numUrbanMissions = 0;
		_numSUrbanMissions = 0;
		_numNUrbanMissions = _missionPerSector;
	} else {
		if (_numUrban == 0) then {
			_numUrbanMissions = 0;
			_numSUrbanMissions = _missionPerSector / 2;
			_numNUrbanMissions = _numSUrbanMissions - _numSUrbanMissions;
		};
		
		if (_numSUrban == 0) then {
			_numNUrbanMissions = _missionPerSector - _numUrbanMissions;
		};
	};
	
	hint format["Urban Missions Sector %1",_i];
	//build urban mission markers
	if (_numUrban != 0) then {
		{
			_loc = _x;
			_missionLoc = locationPosition _loc;
			_missionType = selectRandom _urban;
			_markerType = _urbanMarkers select (_urban find _missionType);
			
			_marker = str random [11111, 55555, 99999];
			createMarker [_marker, _missionLoc];
			_marker setMarkerType _markerType;
			_marker setMarkerColor (_markerColors select _sectorNum);
		} forEach _urbanLocs;
	};
	
	hint format["Sub-Urban Missions Sector %1",_i];
	//build sub urban mission markers
	if (_numSUrban != 0) then {
		{
			_loc = _x;
			_missionLoc = locationPosition _loc;
			_missionType = selectRandom _semiUrban;
			_markerType = _sUrbanMarkers select (_semiUrban find _missionType);
			
			_marker = str random [11111, 55555, 99999];
			createMarker [_marker, _missionLoc];
			_marker setMarkerType _markerType;
			_marker setMarkerColor (_markerColors select _sectorNum);
		} forEach _sUrbanLocs;
	};
	
	hint format["Non-Urban Missions Sector %1",_i];
	//build non urban mission markers
	_nUrbanMissionNum= _missionPerSector - _numUrban - _numSUrban;
	hint format["Non-Urban Missions to build in Sector %1: %2",_i,_nUrbanMissionNum];
	_nUrbanLocs = [];
	
	while {(count _nUrbanLocs) < _nUrbanMissionNum} do {
		_missionPos = [nil, ["water"]] call BIS_fnc_randomPos;
		_inSector = _missionPos inArea _sector;
		
		// remove locations surrounded by water
		_waterSurrounded = false;
		_waterArr = [];
			
		if (surfaceIsWater (_missionPos getPos [150, 0])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_missionPos getPos [150, 45])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_missionPos getPos [150, 90])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_missionPos getPos [150, 135])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_missionPos getPos [150, 180])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_missionPos getPos [150, 225])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_missionPos getPos [150, 270])) then { _waterArr pushBack true;};
		if (surfaceIsWater (_missionPos getPos [150, 315])) then { _waterArr pushBack true;};
			
		if (count _waterArr > 4) then {_waterSurrounded = true; };
		
		//check if pos close to any other marker in the sector
		if (_inSector && !_waterSurrounded) then {
			_closeCounter = 0;
			{
				if ((_missionPos distance _x ) < 500) then { //1000
					_closeCounter = _closeCounter + 1;
				};
			} forEach _urbanLocs;
			{
				if ((_missionPos distance _x ) < 500) then {
					_closeCounter = _closeCounter + 1;
				};
			} forEach _sUrbanLocs;
			{
				if ((_missionPos distance _x ) < 500) then {
					_closeCounter = _closeCounter + 1;
				};
			} forEach _nUrbanLocs;
			
			//if not close to other markers add to non urban markers
			if (_closeCounter < 1) then {
				_nUrbanLocs = _nUrbanLocs + [_missionPos];
			};
		};
	};
	hint format["Non-Urban Missions found in Sector %1: %2",_i,count(_nUrbanLocs)];
	
	{
		_missionLoc = _x;
		_missionType = selectRandom _nonUrban;
		_markerType = _nUrbanMarkers select (_nonUrban find _missionType);
		
		_marker = str random [11111, 55555, 99999];
		createMarker [_marker, _missionLoc];
		_marker setMarkerType _markerType;
		_marker setMarkerColor (_markerColors select _sectorNum);
	} forEach _nUrbanLocs;
	
	hint format["Finished Sector: %1",count(sectors)];
};