//Paras
params [
"_target",
"_player",
"_actionParams"
];

//Remove action
//[_player, 1, ["ACE_SelfActions", "BiA_Supports", "BiA_Artillery"]] call ace_interact_menu_fnc_removeActionFromObject;

//Setup
_tag = "SupportArtillery";
_debug = true;

_artillery = ["Sh_82mm_AMOS", "Sh_155mm_AMOS"];
_bombs = ["Bo_Mk82"]; //, "R_230mm_Cluster", "Bo_GBU12_LGB", ammo_ShipCannon_120mm_HE_cluster "Cluster_155mm_AMOS",  , "rhs_ammo_gbu32"
_ammo = selectRandom (_artillery + _bombs);
_safeZone = 0;
_altitude = 600;
_speed = 150;

//Get desired map pos
openMap true;
clicked = 0;
onMapSingleClick 
{
	mapPos = _pos; 
	clicked = 1; 
	openMap false;
	onMapSingleClick ""; 
	true;
};

//Wait for player input
if (_debug) then 
{
	_text = format["Waiting for Click"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};
	
while {clicked == 0 } do
{
	uiSleep 0.1;
};

if (_debug) then 
{
	_text = format["Selected MapPos: %1", mapPos];
	[_tag, _text] remoteExec ["bia_to_log", 2, false];
};

//Spawn Artillery
uiSleep 25; //travel time of artillery shell

if (_ammo == "Sh_82mm_AMOS") then
{
	_radius = 40;
	_rounds = selectRandom[7,8,9,10];
	_delay = [2, 4];

	[mapPos, _ammo, _radius, _rounds, _delay, nil, _safeZone, _altitude, _speed, []] spawn BIS_fnc_fireSupportVirtual;
};

if (_ammo == "Sh_155mm_AMOS") then
{
	_radius = 60;
	_rounds = selectRandom[3,4,5,6];
	_delay = [3, 8];

	[mapPos, _ammo, _radius, _rounds, _delay, nil, _safeZone, _altitude, _speed, []] spawn BIS_fnc_fireSupportVirtual;
};

if (_ammo in _bombs) then
{
	_radius = 0;
	_rounds = 1;
	_delay = 0;
	_delay = random[10, 20, 30];
	uiSleep _delay;
	
	_missile = createVehicle [_ammo, mapPos vectorAdd [0, 0, 600], [], 0, "CAN_COLLIDE"]; 
	_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]]; 
	_missile setVelocity [0, 0, -50];
};