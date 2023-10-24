//[nil,manu] execVM "scripts\range\sniperTraining\sniperTraining.sqf";

//Paras
params ["_target", "_caller", "_actionId", "_arguments"];

//Get into shooting position
_trainingLocation = [0,4,4,0,0] call bia_random_loc; //compile preprocessFileLineNumbers "scripts\missions\randomMissionLocation.sqf";
_caller setPos _trainingLocation;

//Add training actions
_caller setVariable ["points", 0, true];
removeAllActions _caller;
_caller addAction ['New Target with Bullet Trace','scripts\range\sniperTraining\sniperTarget.sqf', 		[true], 1.5, true, true, "", "true", 1];
_caller addAction ['New Target without Bullet Trace','scripts\range\sniperTraining\sniperTarget.sqf',	[true], 1.5, true, true, "", "true", 1];
_caller addAction ['New Location','scripts\range\sniperTraining\sniperTraining.sqf', 							nil, 1.5, true, true, "", "true", 1];
_caller addAction ['Teleport to HQ','scripts\TeleportToPos.sqf',														[hq_pos, HQ_Arsenal, true], 1.5, true, true, "", "true", 1];

//Disable enemy spawns
Training_Arr = [missionNamespace, "Training_Arr", []] call BIS_fnc_getServerVariable;
Training_Arr pushBackUnique _caller;
[missionNamespace, ["Training_Arr", Training_Arr]] remoteExec ["setVariable", 2, false]; 
//publicVariable "Training_Arr";
//varspace setVariable [name, value]