//[nil,manu,"",[true]] execVM "scripts\range\sniperTarget.sqf";

//Paras
params ["_target", "_caller", "_actionId", "_arguments"];
_shooter = _caller;
_traceBullet = _arguments select 0;

//Get appropriate position for sniper target
_targetPos 				= [getPos _shooter, 300, 1000, 5, 0, 20, 0] call BIS_fnc_findSafePos;
_targetShooterDist	= _shooter distance _targetPos;
_aslTargetPos 		= AGLToASL [_targetPos select 0, _targetPos select 1, 0];
_aslShooterPos 		= getPosASL _shooter;
_blockedLine 			= lineIntersects [_aslTargetPos, _aslShooterPos, _shooter];
_terranBlock 			= terrainIntersect[getPos _shooter, _targetPos];
_visibility 				= [objNull, "VIEW"] checkVisibility [AGLToASL [_targetPos select 0,_targetPos select 1, 0], eyePos manu];

while {_blockedLine or _terranBlock or _visibility < 0.7} do {
	_targetPos 				= [getPos _shooter, 300, 1000, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	_targetShooterDist	= _shooter distance _targetPos;
	_aslTargetPos 		= AGLToASL [_targetPos select 0, _targetPos select 1, 0];
	_aslShooterPos 		= getPosASL _shooter;
	_blockedLine 			= lineIntersects [_aslTargetPos, _aslShooterPos, _shooter];
	_terranBlock 			= terrainIntersect[getPos _shooter, _targetPos];
	_visibility 				= [objNull, "VIEW"] checkVisibility [AGLToASL [_targetPos select 0,_targetPos select 1, 0], eyePos manu];
};

//Create target
_grp = createGroup east;
_target = _grp createUnit ["O_bia_bandits_rifleman_akm", _targetPos, [], 0, "NONE"];
_dirToShooter = [_targetPos, getPos _shooter] call BIS_fnc_dirTo;
_target setDir _dirToShooter;
[_target] execVM "scripts\range\targetScoreEventHandler.sqf";

//Give shooter info about pos
_dirToTarget = round([getPos _shooter, _targetPos] call BIS_fnc_dirTo);
hint format["Direction to Target: %1",_dirToTarget];

//Enable / Disable Bullet Trace
if (_traceBullet) then {
	[_shooter, 1] spawn BIS_fnc_traceBullets;
} else {
	BIS_tracedShooter = nil;
};