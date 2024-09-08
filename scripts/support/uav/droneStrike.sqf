_drones = vehicles select {_x getVariable ["ActiveDrone", false]};

if (count _drones > 0) then 
{
	_drone = _drones select 0;
	_objs = nearestObjects [getPos _drone, ["LaserTarget"], 3000, true];
	_laserTargets = _objs select {"lasertgt" in str _x};

	if (count _laserTargets > 0) then 
	{
		_laserTarget = _laserTargets select 0;
		_pos = getPosATL _laserTarget;
		_ammo = "Missile_AGM_02_F"; //M_PG_AT 400, M_Scalpel_AT 300, Missile_AGM_02_F 1100, Rocket_04_AP_F 400, M_Titan_AT

		_missile = createVehicle [_ammo, _pos vectorAdd [0, 0, 1000], [], 0, "CAN_COLLIDE"]; //find a way to correct for side of obj targeted: getPos [1, manu getDir _pos]
		_missile setVectorDirAndUp [[0, 0, -1], [0, 1, -1]];  
		_missile setVelocity [0, 0, -10];

		_missile setMissileTargetPos _pos; //[_pos select 0, _pos select 1, 0];
		//_target = createVehicle ["LaserTarget", _pos vectorAdd [0,0,0], [], 0, "NONE"];
		//_missile setMissileTarget _laserTarget;
	};
};