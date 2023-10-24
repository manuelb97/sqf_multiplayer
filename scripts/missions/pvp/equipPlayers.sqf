// [[manu], "US", false] spawn compileFinal preprocessFileLineNumbers "scripts\missions\pvp\equipPlayers.sqf";

//Paras
params [
"_players",
"_faction",
"_defending"
];

_itemVariables = ["_uniform", "_vest", "_backpack", "_helmet", "_glasses", "_bino", "_nvg", "_frag", "_smoke", "_flashbang"];

_ruItems = 
[
	"rhs_uniform_vkpo_gloves", "rhs_6b23_6sh116", "rhs_rd54_emr1", "rhs_6b7_1m_bala1_emr", "",
	"rhs_pdu4", "rhs_1PN138",
	"rhs_mag_rgd5", "SmokeShellRed", "rhs_mag_zarya2"
];

_usItems = 
[
	"rhs_uniform_cu_ocp", "rhsusf_iotv_ocp_Rifleman", "rhsusf_assault_eagleaiii_ocp", "rhsusf_ach_helmet_headset_ocp_alt", "rhs_googles_black",
	"rhsusf_bino_lrf_Vector21", "rhsusf_ANPVS_14",
	"rhs_mag_m67", "SmokeShellBlue", "rhs_mag_mk84"
];

_uniformItems = 
[
	["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], 
	["ACE_fieldDressing", 12], ["ACE_morphine", 4]
];

if (_defending) then 
{
	_uniformItems = _uniformItems + [["ACE_EntrenchingTool", 1], ["ACE_Fortify", 1]];
};

//equip defenders  
_items = _ruItems;
if (_faction == "US") then 
{
	_items = _usItems;
};
_items params _itemVariables;
_vestItems = [[_frag, 2, 1], [_smoke, 1, 1], [_flashbang, 2, 1]];
_backpackItems = [];

// ["PvP_Arsenals", str [_players, _faction, _uniform, _vest, _backpack, _helmet, _glasses, _bino, _nvg, _frag, _smoke, _flashbang]] spawn bia_to_log;

_startLoadout = 
[
	[], [], [],
	[_uniform, _uniformItems],
	[_vest, _vestItems], 
	[_backpack, _backpackItems], 
	_helmet, _glasses,
	[_bino, "", "", "", ["", 0], [], ""],
	["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ItemWatch", _nvg]
];

{
	_player = _x;
	_player setUnitLoadout _startLoadout;
	[_player] call ace_weaponselect_fnc_putWeaponAway;
} forEach _players;