//Paras
params [
"_debug"
];

_tag = "HQLight";

if (_debug) then 
{
	_text = format["Light turned On"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

_spawnPos = (getPos hq_building) vectorAdd [0,0,7];  
_lightpoint = "#lightpoint" createVehicleLocal _spawnPos;  
_lightpoint setLightColor [1, 0, 0];  
_lightpoint setLightBrightness 40;  
_lightpoint setLightIntensity 20000;  
_lightpoint setLightAttenuation [0, 1, 1, 1, 0, 9, 10];  