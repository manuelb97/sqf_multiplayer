//Params
params [
"_target", 
"_caller", 
"_arguments"
];

//_heliSpawn = getMarkerPos "heli_spawn";

_minDist = 1000;
_class = typeOf (vehicle _caller);

if (_class isKindOf "Helicopter" || _class isKindOf "Plane") then 
{
	_minDist = 3000;
};

_enemies = allUnits select {side _x != west && _x distance2D _caller < _minDist};

if (count _enemies < 1) then 
{
	_vehicle = vehicle _caller;
	_vehicle setVehicleArmor 1;
	_vehicle setVehicleAmmo 1;
	_vehicle setFuel 1;

	"Vehicle restored" remoteExec ["hint", _caller];
} else 
{
	"Too close to enemy forces" remoteExec ["hint", _caller];
};