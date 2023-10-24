//Paras
params [
"_units",
"_veh",
"_numRepeats",
"_debug"
];

_leader = leader (_units select 0);

for "_i" from 1 to _numRepeats do 
{
	{
		moveOut _veh; 
	} forEach _units;

	uiSleep 1;

	_leader moveInDriver _veh;
	{
		_x moveInAny _veh;
	} forEach (_units - [_leader]);
	
	uiSleep 1;
};