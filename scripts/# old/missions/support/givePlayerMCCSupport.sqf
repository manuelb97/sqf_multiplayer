/*
[selectRandom ["Liberation", "Defence", "HVT", "Heist", "Escape","Sniper","Sabotage","Zombie"],
selectRandom["small","medium","big","huge"],
selectRandom["Tier_4","Tier_3","Tier_2","Tier_1"],
selectRandom[50,100,150,200],
selectRandom[[],["1"],["1","2"],["1","2","3"],["1","2","3","4"]]
] execVM "scripts\missions\support\givePlayerMCCSupport.sqf";
*/

//Execute before faction selection

//Paras
params [
["_missionType","Liberation"],
["_missionArea","small"],
["_tier","Tier_4"],
["_radius",50],
["_defVehicles",1]
];

////To give feedback about available supports
_hintStr = format["Available Supports:\n"];

/*
////Evac
if (_missionType in ["HVT", "Heist","Sniper","Sabotage"]) then {
	{	if (typeOf _x == "RHS_UH60M_d") then {
			_crew = crew _x;
			{ deleteVehicle _x; } forEach _crew;
			deleteVehicle _x;
		};
	} forEach vehicles;
	["RHS_UH60M_d", getPosASL heli_pos] remoteExec ["MCC_fnc_evacSpawn", selectRandom allPlayers, true];
	
	uiSleep 1;
	
	//Make it respawn, disable dmg for crew
	{	if (typeOf _x == "RHS_UH60M_d") then {
			_veh = _x;
		
			//Make crew unkillable
			_crew = crew _veh;
			{ _x allowDamage false; } forEach _crew;
			
			//Add respawn (_unit, _delay,_deserted,_respawns,_explode,_dynamic,_createCrew,_disableCrewDamage,_mccEvac,_unitinit
			[_veh, 10, 0, 1, false, false, true, true, true] execVM "scripts\missions\support\vehicleRespawn.sqf";
		};
	} forEach vehicles;
	
	//Add to hint
	_hintStr = _hintStr + format["Blackhawk Evac\n"];
};
*/

////Arty and CAS
//Determine the need of combat support
_suppHelpCoef 	= 0;

switch (_missionArea) do {
    case "small": 		{ _suppHelpCoef = _suppHelpCoef + 0.25 };
    case "medium":	{ _suppHelpCoef = _suppHelpCoef + 0.5 };
    case "big": 			{ _suppHelpCoef = _suppHelpCoef + 0.75 };
    case "huge": 		{ _suppHelpCoef = _suppHelpCoef + 1 };
};
switch (_tier) do {
    case "Tier_4": 	{ _suppHelpCoef = _suppHelpCoef + 0.25 };
    case "Tier_3":		{ _suppHelpCoef = _suppHelpCoef + 0.5 };
    case "Tier_2": 	{ _suppHelpCoef = _suppHelpCoef + 0.75 };
    case "Tier_1": 	{ _suppHelpCoef = _suppHelpCoef + 1 };
};
switch (_radius) do {
    case 50: 		{ _suppHelpCoef = _suppHelpCoef + 0.25 };
    case 100:	{ _suppHelpCoef = _suppHelpCoef + 0.5 };
    case 150: 	{ _suppHelpCoef = _suppHelpCoef + 0.75 };
    case 200: 	{ _suppHelpCoef = _suppHelpCoef + 1 };
};
switch (count _defVehicles) do {
    case 0: 	{ _suppHelpCoef = _suppHelpCoef + 0 };
    case 1:	{ _suppHelpCoef = _suppHelpCoef + 1 };
    case 2: 	{ _suppHelpCoef = _suppHelpCoef + 1.5 };
    case 3: 	{ _suppHelpCoef = _suppHelpCoef + 2 };
};

//Possible supports
_possArty = ["HE 155mm","HE 155mm"];
_possCAS = ["Gun-Run","Rocket-Run","JDAM","LGB","UAV","AC-130"];

//Lengthen arty array to make cas and arty equally probable
while {count _possCAS > count _possArty} do {_possArty append _possArty;};

//Only use unguided if no strategic attack mission
if (!(_missionType in ["Liberation","HVT","Heist","Sabotage"] && _tier == "Tier_1")) then { 
	_possArty resize 1;
	_possCAS resize 3;
};

//Determine number of supports
_suppNum		= 0;

switch true do {
	case (_suppHelpCoef >= 1 && _suppHelpCoef < 2): {
		_suppNum = selectRandom[1,1,2];
	};
	case (_suppHelpCoef >= 2 && _suppHelpCoef < 3): {
		_suppNum = selectRandom[1,2,2];
	};
	case (_suppHelpCoef >= 3 && _suppHelpCoef < 4): {
		_suppNum = selectRandom[2,2,3];
	};
    case (_suppHelpCoef == 4): { 
		_suppNum = selectRandom[2,3,3];
	};
};

//Select supports
_possArty append _possCAS;
_availSupps = [];

for '_i' from 1 to _suppNum do {
	_addSupp = selectRandom _possArty;
	
	//Several rounds of same arty are ok
	if (_addSupp != "HE 155mm" && _addSupp != "HE Laser") then {
		_possArty deleteAt (_possArty find _addSupp);
	};
	_availSupps pushBack _addSupp;
};

//AC-130 so op, we gotta cut the rest if selected
if ("AC-130" in _availSupps) then {
	_availSupps = ["AC-130"];
};

//Add selected supports to commander
_numShells = 0;
HW_arti_types = [];
publicVariable "HW_arti_types";
HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + _numShells; 
publicVariable "HW_arti_number_shells_per_hour";
MCC_server setVariable ["Arti_WEST_shellsleft",HW_arti_number_shells_per_hour,true];
_sideVar = format ["Arti_%1_shellsleft",west];
(missionNamespace getVariable ["MCC_server",objNull]) setVariable [_sideVar,_numShells,true];

MCC_CASConsoleArrayWEST = [];
publicVariable "MCC_CASConsoleArrayWEST";

//No support in sniper & zombie missions
if (!(_missionType in ["Sniper","Zombie"])) then {
	if ("HE 155mm" in _availSupps) then {
		HW_arti_types pushBack ["HE 155mm","Sh_155mm_AMOS"];
		_numShells = _numShells + ({_x == "HE 155mm"} count _availSupps);
	};
	if ("HE Laser" in _availSupps) then {
		HW_arti_types pushBack ["HE Laser-guided","Bo_GBU12_LGB"];
		_numShells = _numShells + ({_x == "HE Laser"} count _availSupps);
	};

	//Special treatment for arty
	if ("HE 155mm" in _availSupps && "HE Laser" in _availSupps) then { 
		_hintStr = _hintStr + format["%1 guided & unguided Artillery Shells\n",_numShells];
	} else {
		if ("HE 155mm" in _availSupps) then { 
			_hintStr = _hintStr + format["%1 unguided Artillery Shells\n",_numShells];
		};
		if ("HE Laser" in _availSupps) then { 
			_hintStr = _hintStr + format["%1 guidedArtillery Shells\n",_numShells];
		};
	};

	//CAS
	if ("Gun-Run" in _availSupps) then {
		MCC_CASConsoleArrayWEST pushBack [["Gun-run (Direct)"],["B_Plane_CAS_01_dynamicLoadout_F"]];
		_hintStr = _hintStr + format["CAS Gun-Run\n"];
	};
	if ("Rocket-Run" in _availSupps) then {
		MCC_CASConsoleArrayWEST pushBack [["Rockets-run (Direct)"],["B_Plane_CAS_01_dynamicLoadout_F"]];
		_hintStr = _hintStr + format["CAS Rocket-Run\n"];
	};
	if ("JDAM" in _availSupps) then {
		MCC_CASConsoleArrayWEST pushBack [["JDAM"],["B_Plane_CAS_01_dynamicLoadout_F"]];
		_hintStr = _hintStr + format["JDAM Strike\n"];
	};
	if ("LGB" in _availSupps) then {
		MCC_CASConsoleArrayWEST pushBack [["LGB"],["B_Plane_CAS_01_dynamicLoadout_F"]];
		_hintStr = _hintStr + format["Guided Bomb\n"];
	};
	if ("UAV" in _availSupps) then {
		MCC_CASConsoleArrayWEST pushBack [["UAV"],["B_UAV_02_dynamicLoadout_F"]];
		_hintStr = _hintStr + format["UAV Overwatch\n"];
	};
	if ("AC-130" in _availSupps) then {
		MCC_CASConsoleArrayWEST pushBack [["UAV"],["B_T_VTOL_01_armed_F"]];
		_hintStr = _hintStr + format["AC-130 Overwatch\n"];
	};

	//Extra code to add supps
	publicVariable "HW_arti_types";
	HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + _numShells; 
	publicVariable "HW_arti_number_shells_per_hour";
	MCC_server setVariable ["Arti_WEST_shellsleft",HW_arti_number_shells_per_hour,true];
	_sideVar = format ["Arti_%1_shellsleft",west];
	(missionNamespace getVariable ["MCC_server",objNull]) setVariable [_sideVar,_numShells,true];

	publicVariable "MCC_CASConsoleArrayWEST";

	//Add remote control action to commander if supps need it
	if (!isNil "manu" && [["UAV"],["B_UAV_02_dynamicLoadout_F"]] in MCC_CASConsoleArrayWEST) then {
		manu addAction ["Remote Control Support","scripts\missions\support\remoteControl.sqf", ["B_UAV_02_dynamicLoadout_F"], 1.5,true,false,"","true",5,false,"",""];
	};
	if (!isNil "manu" && [["UAV"],["B_T_VTOL_01_armed_F"]] in MCC_CASConsoleArrayWEST) then {
		manu addAction ["Remote Control Support","scripts\missions\support\remoteControl.sqf", ["B_T_VTOL_01_armed_F"], 1.5,true,false,"","true",5,false,"",""];
	};

	//Give info about what supps are available
	//hint format["MissionType: %1, MissionArea: %2, Tier: %3, Radius: %4, Vehicles: %5\nSupps: %6",_missionType,_missionArea,_tier,_radius,count _defVehicles, _supports]; uiSleep 5;
	if (_hintStr != "Available Supports:\n") then {
		[_hintStr] remoteExec ["hint", 0, true];
	} else {
		["No Supports available"] remoteExec ["hint", 0, true];
	};
};