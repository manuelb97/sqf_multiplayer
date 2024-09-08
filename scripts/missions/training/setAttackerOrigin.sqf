//Params
params [
"_target", 
"_caller", 
"_arguments"
];

//Wait for Input or Cancel
openMap true;
clicked = 0;
onMapSingleClick 
{
	mapPos = _pos; 
	clicked = 1; 
	onMapSingleClick ""; 
	true;
};

while {!visibleMap} do
{
	uiSleep 0.1;
};
	
while {clicked == 0 && visibleMap} do
{
	uiSleep 0.1;
};

if (clicked == 0) exitWith {};
openMap false;

missionNamespace setVariable ["AttackerOrigin", mapPos, true];

_marker = "training_start_" + (str random [11111, 55555, 99999]);
createMarker [_marker, mapPos];
_marker setMarkerTypeLocal "loc_car";
_marker setMarkerColorLocal "colorOPFOR";
_marker setMarkerSize [2,2];

_currentMarkers = missionNamespace getVariable ["TrainingMarkers", []];
_currentMarkers pushBack _marker;
missionNamespace setVariable ["TrainingMarkers", _currentMarkers, true];
 
[
	format["New attacker origin set"], "center_top", 5, 0, 0, 100, "Green"
] remoteExec ["bia_spawn_text", _caller];