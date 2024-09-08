//Params
params [
"_player"
];

//set training setting
_action = ["Training",  "Training",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_startMission = ["StartMission",  "Start mission",  "", {_this spawn bia_training_mission_state;}, {true}, {}, [true]] call ace_interact_menu_fnc_createAction; 
_endMission = ["StopMission",  "Stop mission",  "", {_this spawn bia_training_mission_state;}, {true}, {}, [false]] call ace_interact_menu_fnc_createAction; 
_defenceCenter = ["DefenceCenter",  "New defence center",  "", {_this spawn bia_training_center;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;
_attackerStart = ["AttackOrigin",  "New attacker origin",  "", {_this spawn bia_training_attacker_start;}, {true}, {}, []] call ace_interact_menu_fnc_createAction;

{
	[_player, 1, ["ACE_SelfActions", "Training"], _x] call ace_interact_menu_fnc_addActionToObject;
} forEach [_startMission, _endMission, _defenceCenter, _attackerStart];

//set max enemies
_action = ["MaxEnemies",  "Max enemies",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_player, 1, ["ACE_SelfActions", "Training"], _action] call ace_interact_menu_fnc_addActionToObject;
{
	_action = [format["Enemies%1", _x],  format["%1 enemies", _x],  "", {_this spawn bia_training_max_enemies;}, {true}, {}, [_x]] call ace_interact_menu_fnc_createAction;
	[_player, 1, ["ACE_SelfActions", "Training", "MaxEnemies"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach [10, 20, 30];

//set kills to achieve
_action = ["KillGoal",  "Kill goal",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_player, 1, ["ACE_SelfActions", "Training"], _action] call ace_interact_menu_fnc_addActionToObject;

{
	_action = [format["Kills%1", _x],  format["%1 kills", _x],  "", {_this spawn bia_training_kill_goal;}, {true}, {}, [_x]] call ace_interact_menu_fnc_createAction;
	[_player, 1, ["ACE_SelfActions", "Training", "KillGoal"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach [100, 200, 300];


//select enemy faction
_action = ["EnemyFaction",  "Enemy faction",  "", {}, {true}, {}, []] call ace_interact_menu_fnc_createAction; 
[_player, 1, ["ACE_SelfActions", "Training"], _action] call ace_interact_menu_fnc_addActionToObject;

{
	_action = [format["Faction%1", _x],  format["%1", _x],  "", {_this spawn bia_training_set_faction;}, {true}, {}, [_x]] call ace_interact_menu_fnc_createAction;
	[_player, 1, ["ACE_SelfActions", "Training", "EnemyFaction"], _action] call ace_interact_menu_fnc_addActionToObject;
} forEach ["Tier_4", "Tier_3", "Tier_2", "Tier_1"];