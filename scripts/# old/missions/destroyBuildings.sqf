//Paras
params [
"_missionLocation",
["_radius",100]
];

//Destroy buildings
_buildingsInZone = (nearestObjects [_missionLocation, ["House","Building"], _radius, true]);
{ 
	if (selectRandom[true,false]) then { 
		_x setDamage [1, false];
	};
} foreach _buildingsInZone;