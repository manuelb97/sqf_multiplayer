params [
"_grp",
"_target"
];

(leader _grp) reveal [_target, random[1,2.5,4]];
(leader _grp) dowatch _target;
(leader _grp) dotarget _target;

[_grp, getPos _target, 0, "MOVE", "LINE", "FULL", "AWARE", "YELLOW"] call bia_add_wp;

while {alive _target} do 
{
	[_grp, 0] setWaypointPosition [getPos _target, 0];
	uiSleep 5;
};