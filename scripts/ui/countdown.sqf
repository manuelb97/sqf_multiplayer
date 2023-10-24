//Paras
params [
"_endTime", 
"_varName",
"_debug"
];

while {serverTime < _endTime && missionNamespace getVariable [_varName, false]} do 
{
	{
		[format["Countdown: %1", round(_endTime - serverTime)], 0.9, -0.2, 2, 0, 0, 89, "Red"] remoteExecCall ["bia_spawn_text", _x];
	} forEach allPlayers;

	uiSleep 1;
};