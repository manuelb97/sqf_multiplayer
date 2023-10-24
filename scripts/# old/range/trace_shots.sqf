//Paras
_player = _this select 1;

//Enable / Disable Bullet Trace
if (isNil "BIS_tracedShooter") then {
	[_player, 1] spawn BIS_fnc_traceBullets;
} else {
	BIS_tracedShooter = nil;
};