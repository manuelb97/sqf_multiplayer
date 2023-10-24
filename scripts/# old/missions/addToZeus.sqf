//Add all enemies to zeus
{
	_x addCuratorEditableObjects [allUnits select {side _x == east}, true];
	_x addCuratorEditableObjects [vehicles select {side ((crew _x) select 0) == east},true];
} forEach allCurators;