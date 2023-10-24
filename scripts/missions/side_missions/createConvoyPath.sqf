// [getPos manu] call compileFinal preprocessFileLineNumbers "scripts\missions\convoy\createConvoyPath.sqf";

//Paras
params [
"_missionLocation"
];

//Get close road
_radius = 50;
_nearRoads = _missionLocation nearRoads _radius;

while {count _nearRoads < 1} do
{
	_radius = _radius + 50;
	_nearRoads = _missionLocation nearRoads _radius;
};

_nearestRoad = [_nearRoads, _missionLocation] call BIS_fnc_nearestPosition;

//Calculate path
_agent = createAgent [typeOf (allPlayers select 0), getPos _nearestRoad, [], 0, "NONE"];
_car = "B_Quadbike_01_F" createVehicle (getPos _nearestRoad); //rhs_btr60_msv
_agent moveInDriver _car;

_agent setVariable ["Agent", true, true];
_car setVariable ["Agent", true, true];

_agent addEventHandler ["PathCalculated",
{
	_elements = _this select 1;
	_len = (count _elements) - 1;

	{
		if (_forEachIndex % 15 == 0 || _forEachIndex == _len || _forEachIndex == 0) then
		{
			_marker = createMarker ["path_marker" + str _forEachIndex, _x];
			_marker setMarkerSizeLocal [1.5, 1.5];
			
			if (_forEachIndex == 0) then
			{
				_marker setMarkerTextLocal "Start";
				_marker setMarkerTypeLocal "loc_car"; //mil_circle_noShadow
				_marker setMarkerColor "ColorRed";
			} else
			{
				if (_forEachIndex == _len) then
				{
					_marker setMarkerTextLocal "Destination";
					_marker setMarkerTypeLocal "mil_circle_noShadow";
					_marker setMarkerColor "ColorRed";
				} else 
				{
					if ((getMarkerPos _marker) distance2D (_elements select 0) > 100) then
					{
						_marker setMarkerTypeLocal "mil_triangle_noShadow";
						_marker setMarkerColor "ColorGreen";
					};
				};
			};
		};
	} forEach _elements;
}];

_dest = [];

while {count _dest < 1} do
{
	_randomPos = [[[_missionLocation, 4000]], ["Water", [_missionLocation, 2000]]] call BIS_fnc_randomPos;
	_closeRoads = _randomPos nearRoads 200;
	
	if (count _closeRoads > 0) then
	{
		_dest = getPos (selectRandom _closeRoads);
	};
};

//_dest = [3371.67,7688.95,-2.16885]; //intentionally on water on tanoa to test with initial bad destination / failed path creation

_agent setDestination [_dest, "LEADER PLANNED", true];

//Start creating new paths until one gets created
uiSleep 5;
_startMarkers = allMapMarkers select {"Start" in markerText _x};

while {count _startMarkers < 1} do
{
	_dest = [];

	while {count _dest < 1} do
	{
		_randomPos = [[[_missionLocation, 3000]], ["Water", [_missionLocation, 1000]]] call BIS_fnc_randomPos;
		_closeRoads = _randomPos nearRoads 200;
		
		if (count _closeRoads > 0) then
		{
			_dest = getPos (selectRandom _closeRoads);
		};
	};
	
	_agent setDestination [_dest, "LEADER PLANNED", true];
	uiSleep 5;
	_startMarkers = allMapMarkers select {"Start" in markerText _x};
};
	
//finish path creation
missionNamespace setVariable ["ConvoyPathReady", true, true];