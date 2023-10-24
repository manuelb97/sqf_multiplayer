//Paras
params [
"_target", 
"_caller", 
"_arguments"
];

if (missionNamespace getVariable ["SideMissionActive", false]) exitWith 
{
	"There is already an active side mission you fucking retard" remoteExec ["hint", 0];
};

missionNamespace setVariable ["SideMissionActive", true, true];
"Preparing Side Mission (Convoy)" remoteExec ["hint", 0];

_debug = _arguments select 0;
_tag = "SideMissionConvoy";
_varName = "side_mission_opfor";
[_tag, "Started", _debug] spawn bia_to_log;

//Determine mission location
_missionLocation = [];
_radius = 200;

while {count _missionLocation < 1} do 
{
	_pos = [nil, ["water"]] call BIS_fnc_randomPos;
	_nearRoads = _pos nearRoads _radius;
	_nearestMarker = [allMapMarkers, _pos] call BIS_fnc_nearestPosition;

	if (count _nearRoads > 0 && _pos distance2D (getMarkerPos _nearestMarker) > 500) then 
	{
		_missionLocation = getPos(selectRandom _nearRoads);
	};
};

//Create route
missionNamespace setVariable ["ConvoyReady", false, true];
missionNamespace setVariable ["ConvoyPathReady", false, true];
missionNamespace setVariable ["ConvoyPlanNewRoute", false, true];
[_missionLocation] spawn bia_convoy_path;

while {!(missionNamespace getVariable ["ConvoyPathReady", false])} do 
{
	uiSleep 1;
};

_pathArr = call bia_path_info;
_pathStart = getMarkerPos (_pathArr select 0);
_pathEnd = getMarkerPos (_pathArr select 1);
_pathMarkers = _pathArr select 2;
[_pathStart, 75, false] remoteExec ["bia_clear_ground", 0, true];

//Create Task 
_taskName = str random [11111, 55555, 99999];
[_taskName, allPlayers, ["Assault the Convoy", "Convoy Ambush", "ATTACK"], _pathEnd, "ASSIGNED", 0, true, true, "destroy"] remoteExec ["BIS_fnc_setTask", 0, true];

//Change Weather 
_includeNight = true;
_includeFog = true;
_forceNight = false;
_forceFogTwilight = selectRandom[true, false];
_forceSpecialWeather = false;

[_includeNight, _includeFog, _forceNight, _forceFogTwilight, _forceSpecialWeather, 0, _debug] spawn bia_change_weather;

//Allow prep
_prepTime = 60;
format["The convoy will start in %1 minutes", round(_prepTime / 60)] remoteExec ["hint", 0];
_endTime = serverTime + _prepTime;
_countdown = [_endTime, "SideMissionActive", _debug] spawn bia_countdown;
uiSleep (_endTime - serverTime);

//Create convoy
_tier = [_debug] call bia_get_curr_tier;
_infantry = [[_tier], "Infantry", _debug] call bia_get_tier_cat;
_transport = [[_tier], "Transport", _debug] call bia_get_tier_cat;
_combatVeh = [[_tier], "CombatVehicle", _debug] call bia_get_tier_cat;

_defVehicles = [[], []]; //arr1 = combat vehcs, arr2 = transports
_numCombatVehs = 1;
if (_tier in ["Tier_2", "Tier_1"]) then 
{
	_numCombatVehs = 2;
};

for "_i" from 1 to _numCombatVehs do 
{
	(_defVehicles select 0) pushBack (selectRandom _combatVeh);
};

(_defVehicles select 1) append [selectRandom _transport, selectRandom _transport];

_convoySpeed = 70; //40
_convoySeparation = 15;
_pushThrough = selectRandom[true, false];
[_pathStart, _pathEnd, _pathMarkers, _infantry, _defVehicles, _convoySpeed, _convoySeparation, _pushThrough, _varName, _debug] spawn bia_spawn_convoy; //remoteExec ["bia_spawn_convoy", missionNamespace getVariable ["BiA_Host", manu], false];

while {!(missionNamespace getVariable ["ConvoyReady", false])} do 
{
	uiSleep 1;
};

//Start Mission Loop
_missionRunning = true;
_newAggro = 0;

while {_missionRunning} do 
{
	//check convoy status
	_convoyVehicles = vehicles select 
	{
		_crew = (crew _x) select {alive _x};

		_x getVariable [_varName, false] 
		&& count _crew > 0
	};
	_convoyUnits = _convoyVehicles + (allUnits select {_x getVariable [_varName, false] && side _x == east});
	_escapedVehicles = _convoyVehicles select {_x distance2D _pathEnd < 100};

	//check for win
	if (count _convoyUnits < 1) then
	{
		_missionRunning = false;
		[_taskName,"SUCCEEDED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
		
		//Reduce Aggro
		_newAggro = round((missionNamespace getVariable ["Aggression", 0]) * 0.5);
	};

	//Check for loss (discovered and not killed within time window)
	if (count _escapedVehicles > 0) then 
	{
		_missionRunning = false;
		[_taskName,"FAILED", true] remoteExec ["BIS_fnc_taskSetState", 0, true];
		
		//Increase Aggro
		_newAggro = round((missionNamespace getVariable ["Aggression", 0]) * 1.1);
	};
	
	uiSleep 1;
};

missionNamespace setVariable ["SideMissionActive", false, true];
missionNamespace setVariable ["Aggression", _newAggro, true];
["Aggression", _newAggro] call bia_save_to_profile;
[_tag, "Finished", _debug] spawn bia_to_log;

_allPlayersAtBase = false;
while {!_allPlayersAtBase} do 
{
	_numPlayers = count allPlayers;
	_playersInBase = allPlayers select {_x distance2D hq_pos < 100};

	if (count _playersInBase == _numPlayers) then 
	{
		_allPlayersAtBase = true;
	};

	uiSleep 1;
};

//Delete enemies 
{
	deleteVehicle _x;
} forEach (allUnits select {_x getVariable [_varName, false]});

//Delete path markers
{
	deleteMarker _x;
} forEach _pathMarkers;