//Paras
params [
"_target", 
"_caller", 
"_arguments"
];

_timeToHeal = [_target] call ace_medical_treatment_fnc_getHealTime;
hint format["Treatment will take %1 seconds", _timeToHeal];
uiSleep _timeToHeal;
[_caller, _target] call ace_medical_treatment_fnc_fullHeal;

if (_target getVariable ["ace_isunconscious", false]) then 
{
	//dmg random parts so not fully healed 
	uiSleep 1;
	_parts = ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"] select {selectRandom[true,true,true,false,false]};
	{
		[_target, 0.4, _x, "bullet"] remoteExec ["ace_medical_fnc_addDamageToUnit", _target];
	} forEach _parts;
};