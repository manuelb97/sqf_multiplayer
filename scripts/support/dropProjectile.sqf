// ["Executing AT Strike", player, player getPos [100, 150], 0, "ammo_bomb_bia", 400, 50, true] spawn compileFinal preprocessFileLineNumbers "scripts\support\dropProjectile.sqf";

params [
"_txt",
"_caller",
"_pos",
"_radius",
"_ammo",
"_height",
"_velocity",
"_debug"
];

_delay = round(random[2,5,10]);

if (_txt != "") then 
{
	// hint format["%1, ETA %2 seconds", _txt, _delay + round(_height / _velocity)];

	[
		format["%1, ETA %2 seconds", _txt, _delay + round(_height / _velocity)]
	] remoteExec ["bia_spawn_text", _caller];

	uiSleep 3;
};

playSound3D ["\jsrs_soundmod_complete\JSRS_Soundmod_Soundfiles\weapons\Shot\Distance\cannon\shot_very_far_1.ogg", _caller, false, getPos _caller, 1, 1, 0, 0, true];
uiSleep _delay;

_randPos = _pos vectorAdd [random[-1 * _radius, 0, _radius], random[-1 * _radius, 0, _radius], _height];
_missile = createVehicle [_ammo, _randPos, [], 0, "CAN_COLLIDE"];  
_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
_missile setVelocity [0, 0, _velocity * -1]; 
[_missile, [(selectRandom ["mortar1", "mortar2"]), 3000]] remoteExec ["say3D"];