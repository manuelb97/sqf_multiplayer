//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_missionType"];

if !(missionNamespace getVariable ["PvPMissionActive", false]) then 
{
	switch (_missionType) do
	{
		case "defense": 
		{
			// _compoundRadius _minBuildings _maxBuildings _prepTime", minDistance, maxDistance
			[50, 5, 15, 5, 500, 600] remoteExec ["bia_pvp_defense", 2];
		};
		case "conquest": 
		{
			// _compoundRadius _minBuildings _maxBuildings _prepTime", minDistance, maxDistance
			[50, 5, 15, 5, 500, 600] remoteExec ["bia_pvp_conquest", 2];
		};
	};
} else 
{
	["Mission already in Progress", "center", 2, 0, 0, 100, "Red"] remoteExec ["bia_spawn_text", _caller];
};