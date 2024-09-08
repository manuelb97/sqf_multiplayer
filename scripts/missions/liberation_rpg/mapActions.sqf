//Params
params [
"_obj"
];

//Insertion tree 
_action = ["Insertion",  "Insertion",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_solo = ["SoloInsertion",  "Solo Insertion",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
_team = ["TeamInsertion",  "Team Insertion",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 

{
	_action = _x;
	[_obj, 0, ["ACE_MainActions", "Insertion"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach [_solo, _team];

//Add insertion actions 
{
	_x params ["_treeLvl", "_teamInsertion"];
	
	_halo = ["HALO",  "HALO",  "", { _this spawn bia_halo; }, {true}, {}, [_teamInsertion]] call ace_interact_menu_fnc_createAction;
	_vehicle = ["VehicleInserion",  "Vehicle Insertion",  "", { _this spawn bia_adaptive_vehicle_insertion; }, {true}, {}, [_teamInsertion]] call ace_interact_menu_fnc_createAction;

	{
		_action = _x;
		[_obj, 0, ["ACE_MainActions", "Insertion", _treeLvl], _action] call ace_interact_menu_fnc_addActionToObject;
	} forEach [_halo, _vehicle];
} forEach [["SoloInsertion", false], ["TeamInsertion", true]];

//Heal yourself
_action = ["HealSelf", "Heal yourself",  "", { _this spawn bia_heal_caller; }, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

/*
///////////////////////////////////////////////////////////
_action = ["Vehicle_Insertion",  "Vehicle Insertion",  "", {}, {true}, {}, [_debug]] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions", "Insertion"], _action] call ace_interact_menu_fnc_addActionToObject;

{
	_x params ["_class", "_solo", "_name", "_tex"];
	_disName = getText(configFile >> "CfgVehicles" >> _class >> "displayName");
	_action = [format["%1_Insertion", _name],  _name,  "", { _this spawn bia_veh_insertion; }, {true}, {}, [_class, _solo, _tex, _debug]] call ace_interact_menu_fnc_createAction; 
	[_obj, 0, ["ACE_MainActions", "Insertion", "Vehicle_Insertion"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach 
[
	["B_Quadbike_01_F", true, "Quadbike", ""]
	, ["B_LSV_01_unarmed_F", true, "Quadbike", ""]
	// , ["B_APC_Wheeled_01_cannon_F", false, "Badger IFV", ""]
	// , ["B_AFV_Wheeled_01_cannon_F", false, "Rooikat (AT)", ""]
	//, ["RHS_M2A2_BUSKI", false, "Bradley", ""]
	// , ["B_Boat_Armed_01_minigun_F", true, "Boat", ""]
	// , ["B_Heli_Light_01_dynamicLoadout_F", true, "Littlebird", ""]

	// rhsusf_mrzr4_d O_LSV_02_unarmed_F 
];

//Side Missions
_action = ["SideMission",  "Side Missions",  "", {}, {true}, {}, [_debug]] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Assassination", "Assasination",  "", { _this spawn bia_assassination; }, {true}, {}, [_debug]] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions", "SideMission"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Sabotage", "Sabotage",  "", { _this spawn bia_sabotage; }, {true}, {}, [_debug]] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions", "SideMission"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Convoy", "Convoy",  "", { _this spawn bia_convoy; }, {true}, {}, [_debug]] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions", "SideMission"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Firefight", "Firefight",  "", { _this spawn bia_firefight; }, {true}, {}, [_debug]] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions", "SideMission"], _action] call ace_interact_menu_fnc_addActionToObject;

//HQ 
_action = ["Teleport_To_Mate",  "Teleport to Team Mate",  "", { _this spawn bia_teleport_to_mate; }, {true}, {}, [_debug]] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions", "BiA_Insertion"], _action] call ace_interact_menu_fnc_addActionToObject;

_action = ["Lamps", "Switch Lights",  "", { _this spawn disable_hq_lamps; }, {true}, {}, [_debug]] call ace_interact_menu_fnc_createAction; 
//[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject; //no need with chem lights

//Mission
_action = ["BiA_Mission", "Mission", "", {}, {true}] call ace_interact_menu_fnc_createAction; 
[_obj, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_action =  ["SelectMission", "Select Main Mission", "", { [] spawn bia_select_marker; }, 
{
	_missionRunning = missionNamespace getVariable ["MissionRunning", false];
	if (_missionRunning) then 
	{
		"A mission is already running" remoteExec ["hint", 0];
	};

	!_missionRunning
}, {}, []] call ace_interact_menu_fnc_createAction;
[_obj, 0, ["ACE_MainActions", "BiA_Mission"], _action] call ace_interact_menu_fnc_addActionToObject;
*/