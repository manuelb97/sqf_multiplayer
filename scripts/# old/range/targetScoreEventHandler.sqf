//[target] execVM "scripts\range\targetScoreEventHandler.sqf";

//Paras
params [
["_target",nil]
];

//Make Handcuffed
[_target, true] call ACE_captives_fnc_setHandcuffed;

//Add hit event handler to target
_target addEventHandler ["HitPart", { 
	(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"]; 
	
	//Velocity info
	_velocity 	= round(_velocity select 0);
	if (_velocity < 0) then {_velocity = _velocity * -1;};
	
	//Body part info
	_selection	= _selection select 0;
	_points		= 0;
	if ("head" in _selection) 								then {_selection = "Head"; 	_points = 8;};
	if ("spine" in _selection || "pelvis" in _selection)	then {_selection = "Torso";	_points = 2;};
	if ("leg" in _selection) 									then {_selection = "Leg"; 		_points = 1;};
	if ("arm" in _selection) 									then {_selection = "Arm"; 		_points = 1;};
	
	//Ammo used
	_ammo = _ammo select 4;
	
	//Add points
	_currentPoints	= _shooter getVariable ["points", 0];
	_newPoints 	= _currentPoints + _points;
	_shooter setVariable ["points", _newPoints, true];
	
	//Give hint
	hint format["Shooter: %1\nVelocity: %2m/s\nBodypart: %3\nAmmo: %4\nPoints added: %5\nPoints total: %6", _shooter, _velocity, _selection, _ammo, _points, _newPoints];
}];