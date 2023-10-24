//Paras
params [
"_position",
"_radius",
"_includeMarkers"
];

_allUnits = allUnits select {_x distance2D _position <= _radius};
_allDead = allDead select {_x distance2D _position <= _radius};
_vehicles = vehicles select {_x distance2D _position <= _radius}; 
_allObjs = _allUnits + _allDead + _vehicles;

{
	deleteVehicle _x;
} forEach _allObjs;

if (_includeMarkers) then 
{
	_markersToDelete = allMapMarkers select {getMarkerPos _x inArea [_position, _radius, _radius, 0, false]};

	{
		deleteMarker _x;
	} forEach _markersToDelete;
};