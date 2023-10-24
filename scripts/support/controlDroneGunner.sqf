//Params
params [
"_target", 
"_caller", 
"_arguments"
];

private ["_gunner", "_gunnerFound"];
{
	if (_x getVariable ["UAV_Active", false]) then
	{
		_gunner = _x;
		_gunnerFound = true;
	};
} forEach allUnits;

if (_gunnerFound) then
{
	_caller remoteControl _gunner;
	_gunner switchCamera "Internal";
};

while {alive _gunner} do
{
	uiSleep 1;
};

objNull remoteControl _gunner;
_caller switchCamera "Internal";