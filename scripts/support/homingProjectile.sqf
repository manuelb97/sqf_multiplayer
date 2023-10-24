[] spawn 
{
	_groundPos = [getPos test select 0, getPos test select 1, 0]; 
  _pos = _groundPos;
  _ammo = "M_PG_AT"; //M_PG_AT 400, M_Scalpel_AT 300, Missile_AGM_02_F 1100, Rocket_04_AP_F 400, M_Titan_AT 
 
  _target = createVehicle ["LaserTargetE", _pos, [], 0, "CAN_COLLIDE"]; 
  
  _rocket = createVehicle [_ammo, (_pos getPos [2000, random 360]) vectorAdd [0,0,2000], [], 0, "CAN_COLLIDE"];
  _speed = 500;
  
  _marker = "test";
	createMarker [_marker, getPos _rocket];
	_marker setMarkerTypeLocal "mil_dot";
	_marker setMarkerColorLocal "colorGreen";
	_marker setMarkerSize [1, 1];
	
	hint str [!isNull _rocket, !isNull _target];
  
	while {!isNull _rocket && !isNull _target} do
	{
		private _currentPos = getPosASLVisual _rocket;
		private _targetPos = getPosASLVisual _target;
		
		_marker setMarkerPos (getPos _rocket);

		private _forwardVector = vectorNormalized (_targetPos vectorDiff _currentPos);
		private _rightVector = (_forwardVector vectorCrossProduct [0,0,1]) vectorMultiply -1;
		private _upVector = _forwardVector vectorCrossProduct _rightVector;

		private _targetVelocity = _forwardVector vectorMultiply _speed;

		_rocket setVectorDirAndUp [_forwardVector, _upVector];
		_rocket setVelocity _targetVelocity;

		if (isNull _rocket || isNull _target) exitWith
		{
			if (!isNull _rocket) then {_rocket setDamage 1; _rocket = objNull;};
		};

		sleep 0.01;
	};
	
	//hint "done";
};