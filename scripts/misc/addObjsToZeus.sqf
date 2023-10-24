while {true} do
{
	//add all relevant objects
	_objs = entities [[], ["Logic"], true, false];
	_objs = _objs select 
	{
		!("cutter" in (str _x))
		&& _x != hq_pos
		&& !("invisible" in (str _x))
	};

	{
		_x addCuratorEditableObjects [_objs, true];
	} forEach allCurators;

	/*
	//remove all enemies 
	_remObjs = allUnits select {side _x != west};
	{
		_x removeCuratorEditableObjects [_remObjs, true];
	} forEach allCurators;
	*/

	uiSleep 20;
};