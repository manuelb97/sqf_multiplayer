//Get path start
_startMarkers = allMapMarkers select {"Start" in markerText _x};
while {count _startMarkers < 1} do
{
	_startMarkers = allMapMarkers select {"Start" in markerText _x};
};
_startMarker = _startMarkers select 0;

//Get path end
_destMarkers = allMapMarkers select {"Destination" in markerText _x};
while {count _destMarkers < 1} do
{
	_destMarkers = allMapMarkers select {"Destination" in markerText _x};
};
_destMarker = _destMarkers select 0;

//Get path markers
_pathMarkers = [];
{
	if ("path_marker" in _x) then
	{
		_pathMarkers pushBack _x;
	};
} forEach allMapMarkers;

//Delete agent
_agent = agent ((agents select {_x getVariable ["Agent", false]}) select 0);
_car = vehicle _agent;

deleteVehicle _agent;
deleteVehicle _car;

//Return
_text = format["Start: %1, End: %2, Markers: %3", _startMarker, _destMarker, _pathMarkers];
["ConvoyPath", _text] remoteExec ["bia_to_log", 2, false]; 

[_startMarker, _destMarker, _pathMarkers]