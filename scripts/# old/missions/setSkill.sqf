/*
//Set skill
remoteExec ["bia_set_skill", 0, true];
*/

//Paras
params [
"_group",
"_skill"
];

//Set skill
if (isNil "_skill") then {
	{
		_x setSkill ["aimingAccuracy",	0.3];
		_x setSkill ["aimingShake", 	0.3];
		_x setSkill ["aimingSpeed", 	0.3];
		_x setSkill ["endurance", 		1];
		_x setSkill ["spotDistance", 	0.5];
		_x setSkill ["spotTime", 			0.5];
		_x setSkill ["courage", 			1];
		_x setSkill ["reloadSpeed", 	1];
		_x setSkill ["commanding", 	1];
		_x setSkill ["general", 			0.4];
	} forEach (units _group);
};

//Use given skill preset or int
if (!isNil "_skill") then {
	if (typeName _skill == "ARRAY") then {
		{
			_x setSkill ["aimingAccuracy",	_skill select 0];
			_x setSkill ["aimingShake", 	_skill select 1];
			_x setSkill ["aimingSpeed", 	_skill select 2];
			_x setSkill ["endurance", 		_skill select 3];
			_x setSkill ["spotDistance", 	_skill select 4];
			_x setSkill ["spotTime", 			_skill select 5];
			_x setSkill ["courage", 			_skill select 6];
			_x setSkill ["reloadSpeed", 	_skill select 7];
			_x setSkill ["commanding", 	_skill select 8];
			_x setSkill ["general", 			_skill select 9];
		} forEach (units _group);
	};

	if (typeName _skill == "SCALAR") then {
		{
			_x setSkill ["aimingAccuracy",	_skill];
			_x setSkill ["aimingShake", 	_skill];
			_x setSkill ["aimingSpeed", 	_skill];
			_x setSkill ["endurance", 		_skill];
			_x setSkill ["spotDistance", 	_skill];
			_x setSkill ["spotTime", 			_skill];
			_x setSkill ["courage", 			_skill];
			_x setSkill ["reloadSpeed", 	_skill];
			_x setSkill ["commanding", 	_skill];
			_x setSkill ["general", 			_skill];
		} forEach (units _group);
	};
};