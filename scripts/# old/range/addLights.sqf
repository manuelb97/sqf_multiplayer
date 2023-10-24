params [
["_obj",LR_Arsenal]
];

//Create Light Sources above long range targets at test range
_btrs = _obj nearObjects ["car", 1000];

{  
	if ("btr" in (str _x)) then {
		_spawnPos = (getPos _x) vectorAdd [-8,4,8];;  
		_lightpoint = "#lightpoint" createVehicleLocal _spawnPos;  
		_lightpoint setLightColor [1, 1, 1];  
		_lightpoint setLightBrightness 50;  
		_lightpoint setLightIntensity 20000;  
		_lightpoint setLightAttenuation [0, 1, 1, 1, 0, 9, 10];  
	}; 
} forEach _btrs;