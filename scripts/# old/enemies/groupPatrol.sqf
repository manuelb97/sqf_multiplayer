//Paras
params [
"_grp",
"_pos",
"_targetPos",
"_debug"
];

_grpPos = getPos leader _grp;
_numWPs = selectRandom [3, 3, 3, 4, 4, 5];
_formations = ["COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"];
_speeds = ["NORMAL", "FULL"];

_wpPosArr = [];
for "_i" from 1 to _numWPs do 
{
	_pos = [[[_targetPos, random [100, 150, 200]]], ["water"]] call BIS_fnc_randomPos;
	_wpPosArr pushBack _pos;
};

_idx = 0;
{
	_idx = _idx + 1;
	_pos = _x;
	_wp = _grp addWaypoint [_pos, 10];
	
	if (_idx == _numWPs) then
	{
		_wp setWaypointType "CYCLE";
	};
	
	_wp setWaypointFormation selectRandom _formations;
	_wp setWaypointSpeed selectRandom _speeds;
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCombatMode "YELLOW";
} forEach _wpPosArr;