//Paras
params [
"_debug"
];

_currentSupps = ["Supports",[[], 0, []]] call compile preprocessFileLineNumbers "scripts\patrolsGuards\NewSaving\loadFromProfile.sqf";

_artyTypes = _currentSupps select 0;
_artyShells = _currentSupps select 1;
_casTypes = _currentSupps select 2;

//Give Artillery
HW_arti_types = _artyTypes;
publicVariable "HW_arti_types";
MCC_server setVariable ["Arti_WEST_shellsleft",_artyShells,true];
(missionNamespace getVariable ["MCC_server",objNull]) setVariable ["Arti_WEST_shellsleft",_artyShells,true];

//Give CAS
MCC_CASConsoleArrayWEST = _casTypes;
publicVariable "MCC_CASConsoleArrayWEST";

if (_debug) then
{
	_text = format["Arty Types: %1", HW_arti_types];
	["Support", _text] remoteExec ["bia_to_log", 2, false]; 
	
	_text = format["Num Shells: %1", _artyShells];
	["Support", _text] remoteExec ["bia_to_log", 2, false]; 
	
	_text = format["CAS Types: %1", MCC_CASConsoleArrayWEST];
	["Support", _text] remoteExec ["bia_to_log", 2, false]; 
};

//Add Actions for UAV CAS
_wait = true;
while {isNil "manu" || _wait} do
{
	if (manu distance hq_pos < 20) then
	{
		_wait = false;
	};
	uiSleep 1;
};

if (!isNil "manu" && [["UAV"],["B_UAV_02_dynamicLoadout_F"]] in MCC_CASConsoleArrayWEST) then {
	UAV_ID1 = manu addAction ["Remote Control Support (UAV)","scripts\missions\support\remoteControl.sqf", ["B_UAV_02_dynamicLoadout_F"], 1.5,true,false,"","true",5,false,"",""];
};

if (!isNil "manu" && [["UAV"],["B_T_VTOL_01_armed_F"]] in MCC_CASConsoleArrayWEST) then {
	UAV_ID2 = manu addAction ["Remote Control Support (AC-130)","scripts\missions\support\remoteControl.sqf", ["B_T_VTOL_01_armed_F"], 1.5,true,false,"","true",5,false,"",""];
};
