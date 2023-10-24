//Paras
params [
"_unitArr",
["_skill", 0.3]
];

_skills = 
[
	["aimingAccuracy", _skill],
	["aimingSpeed", _skill],
	["aimingShake", _skill],
	["general", _skill],
	["spotTime", 0.7],
	["spotDistance", 0.8],
	["endurance", 1],
	["courage", 1],
	["reloadSpeed", 1],
	["commanding", 1]
];

{
	_unit = _x;
	{
		//["Skill", str [_unit, _x select 0, _x select 1], true] spawn bia_to_log;

		[_unit, [_x select 0, _x select 1]] remoteExec ["setSkill", 0];
		// _unit setSkill [_x select 0, _x select 1];
	} forEach _skills;
} forEach _unitArr;