//Params
params [
	"_parent",
	"_player",
	"_kitName"
];

_valid = [_parent, _player, _kitName] isEqualTypeParams ["", objNull, ""];
if !(_valid) exitWith
{
	["scripts\support\misc\change_kit.sqf", _parent, [_parent, _player, _kitName]] spawn bia_input_msg;
};

_pistolMag = "rhsusf_mag_15Rnd_9x19_FMJ";
_frag = "HandGrenade";
_smoke = "rhs_mag_m18_green";

_loadout = 
[
	[], [], 
	["rhsusf_weap_m9", "","","", [_pistolMag, [_pistolMag] call bia_mag_bullets], ["", 0], ""],
	["U_BG_Guerrilla_6_1", [["ACE_EarPlugs", 1], ["ACE_Flashlight_XL50", 1], ["ACE_fieldDressing", 30], ["ACE_morphine", 10], ["ACE_personalAidKit", 1]]],
	["rhs_6b3", [[_pistolMag, 3, [_pistolMag] call bia_mag_bullets], [_frag, 2, [_frag] call bia_mag_bullets], [_smoke, 2, [_smoke] call bia_mag_bullets]]], 
	["rhs_sidor", [["rhs_rpg7_OG7V_mag", 1], ["rhs_rpg7_PG7VM_mag", 1]]],
	"rhs_6b7_1m_olive", 
	"G_Balaclava_TI_blk_F",
	["rhs_pdu4", "", "", "", ["", 0], [], ""],
	["ItemMap", "ItemGPS", "ItemRadio", "ItemCompass", "ACE_Altimeter", "rhs_1PN138"] // O_NVGoggles_ghex_F O_NVGoggles_hex_F
];

switch (_kitName) do 
{
	case "AK": 
	{
		_primMag = "rhs_30Rnd_545x39_7N10_camo_AK";
		_primSecMag = "";
		_atMag = "rhs_rpg7_OG7V_mag";
		_vestMags = [[_primMag, 15, [_primMag] call bia_mag_bullets]];
		_backMags = [[_atMag, 1, 1], ["rhs_rpg7_PG7VM_mag", 1, 1]];

		_loadout set [0, ["rhs_weap_ak74m_camo", "rhs_acc_dtk", "", "", [_primMag, [_primMag] call bia_mag_bullets], [_primSecMag, [_primMag] call bia_mag_bullets], ""]];
		_loadout set [1, ["rhs_weap_rpg7", "","","", [_atMag, [_atMag] call bia_mag_bullets], ["", 0], ""]];
		(_loadout select 4 select 1) append _vestMags;
		(_loadout select 5 select 1) append _backMags;
	};
	case "AKGP": 
	{
		_primMag = "rhs_30Rnd_545x39_7N10_camo_AK";
		_primSecMag = "rhs_VOG25";
		_vestMags = [[_primMag, 15, [_primMag] call bia_mag_bullets], [_primSecMag, 20, [_primSecMag] call bia_mag_bullets]];

		_loadout set [0, ["rhs_weap_ak74m_gp25", "rhs_acc_dtk", "", "", [_primMag, [_primMag] call bia_mag_bullets], [_primSecMag, [_primMag] call bia_mag_bullets], ""]];
		(_loadout select 4 select 1) append _vestMags;
	};
	case "PKM": 
	{
		_primMag = "rhssaf_250Rnd_762x54R";
		_vestMags = [[_primMag, 2, [_primMag] call bia_mag_bullets]];

		_loadout set [0, ["rhs_weap_pkm", "", "", "", [_primMag, [_primMag] call bia_mag_bullets], [], ""]];
		(_loadout select 4 select 1) append _vestMags;
	};
	case "SVD": 
	{
		_primMag = "ACE_10Rnd_762x54_Tracer_mag";
		_vestMags = [[_primMag, 2, [_primMag] call bia_mag_bullets]];

		_loadout set [0, ["rhs_weap_svdp", "", "", "rhs_acc_pso1m2", [_primMag, [_primMag] call bia_mag_bullets], [], ""]];
		(_loadout select 4 select 1) append _vestMags;
	};
};

_player setUnitLoadout _loadout;
[_player] join grpNull;
(group _player) setVariable ["Vcm_Disable", true, true];
_player disableAI "SUPPRESSION";

[format["Kit changed to %1", _kitName]] spawn bia_spawn_text;