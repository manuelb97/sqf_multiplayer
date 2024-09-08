// ["Executing AT Strike", player, player getPos [100, 150], 0, "ammo_bomb_bia", 400, 50, true] spawn compileFinal preprocessFileLineNumbers "scripts\support\dropProjectile.sqf";

/*
[] spawn {
	for "_i" from 0 to 10 do {
		["HE", player, player getPos [867, 104], 100, "Sh_155mm_AMOS", 400, 50, false] spawn compileFinal preprocessFileLineNumbers "scripts\support\dropProjectile.sqf";
		uiSleep 2;
	}
}
*/

params [
"_delay",
"_player", 
"_dist", 
"_dir",
"_radiusX",
"_radiusY",
"_ammo",
"_height",
"_velocity",
"_debug"
];

_basePos = _player getPos [_dist , _dir];
playSound3D [
	"\jsrs_soundmod_complete\JSRS_Soundmod_Soundfiles\weapons\Shot\Distance\cannon\shot_very_far_1.ogg",
	objNull, false, _basePos, 1, 1, 0, 0, true
];
uiSleep _delay;

_x = random 1 * (selectRandom [-1 * _radiusX, _radiusX]);
_y = random 1 * (selectRandom [-1 * _radiusY, _radiusY]);
// _x = [-1 * _radiusX, 0, _radiusX];
// _y = [-1 * _radiusY, 0, _radiusY];

// _randPos = _pos vectorAdd [random[-1 * _radius, 0, _radius], random[-1 * _radius, 0, _radius], _height];
// _randPos = _pos vectorAdd [random _radius, random _radius, _height];
_randPos = _basePos getPos [random _x, _dir] getPos [random _y, _dir + 90];
_missile = createVehicle [_ammo, _randPos, [], 0, "CAN_COLLIDE"];  
_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
_missile setVelocity [0, 0, _velocity * -1]; 
[_missile, [(selectRandom ["mortar1", "mortar2"]), 3000]] remoteExec ["say3D"];