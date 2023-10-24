//Paras
_tele 		= _this select 0;
_caller 		= _this select 1;
_telePos 	= _this select 3 select 0;
_dirObj 	= _this select 3 select 1;

private _stopTraining = false;
if (count (_this select 3) > 2) then
{
	_stopTraining = _this select 3 select 2;
};

/*
_caller = "";
if (count (_this select 3) > 1) then 
{
	_caller = _this select 3 select 1;
};
*/

//Remove Stuff if teleport to HQ
if (_telePos == hq_pos) then {
	//Reset Loadout
	["", _caller] execVM "scripts\loadouts\tier_base.sqf"; //execVM "scripts\loadouts\tier_base.sqf";

	//Remove all addActions
	{
		UAV_ID1 = [missionNamespace, "UAV_ID1", 100] call BIS_fnc_getServerVariable;
		UAV_ID2 = [missionNamespace, "UAV_ID2", 100] call BIS_fnc_getServerVariable;
		
		if (_x != UAV_ID1 && _x != UAV_ID2) then
		{
			_caller removeAction _x;
		};
	} forEach actionIDs _caller;
	
	//Reset Bullet Trace
	BIS_tracedShooter = nil;

	//Remove second Primary
	if (!isNil "secondPrimary") then {_caller removeAction secondPrimary};
};

//Teleport
//hint str [_caller, _telePos, getposATL _telePos];
_caller setPosATL (getposATL (_telePos));

//Adjust orientation
_orientation = _caller getDir _dirObj;
_caller setDir _orientation;

//Remove from Training Array
Training_Arr = [missionNamespace, "Training_Arr", []] call BIS_fnc_getServerVariable;
if (_stopTraining) then
{
	Training_Arr deleteAt (Training_Arr find _caller);
} else
{
	Training_Arr pushBackUnique _caller;
};
[missionNamespace, ["Training_Arr", Training_Arr]] remoteExec ["setVariable", 2, false]; 