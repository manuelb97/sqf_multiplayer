//Set some variables
(group player) setVariable ["Vcm_Disable", true, true];

//Add cool google effect 
call ace_goggles_fnc_applyDustEffect;

//Play sound
[player] spawn bia_respawn_sound;

//Death Marker 
// [player, _oldUnit] spawn bia_respawn_marker;

//Respawn code 
switch (missionNamespace getVariable ["Mission", ""]) do
{
	case "house_raids": 
	{
		// [player] call bia_respawn_loadout; //execVM "scripts\equipment\respawnLoadout.sqf";
	};
	case "pvp": 
	{
		player selectWeapon primaryWeapon player;
	};
	case "sector_attacks": 
	{
		[player] spawn bia_sector_attacks_resp_load;
	};
};

//Set pos and orientation
player setPosATL getPosATL hq_pos;
_orientation = player getDir HQ_Arsenal;
player setDir _orientation;