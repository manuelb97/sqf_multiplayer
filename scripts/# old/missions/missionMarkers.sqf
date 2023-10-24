//bia_markers = ["",getPos test,200] call compile preprocessFileLineNumbers "scripts\missions\missionMarkers.sqf";

//Paras
_missionType = param [0,""];
_missionLocation = param [1,[]];
_radius = param [2,300];

//Create mission area marker
_missionAreaMarker = str random [11111, 55555, 99999];
createMarker [_missionAreaMarker, _missionLocation];
_missionAreaMarker setMarkerType "Empty";
_missionAreaMarker setMarkerSize [_radius, _radius];
_missionAreaMarker setMarkerShape "ELLIPSE";
_missionAreaMarker setMarkerBrush "FDiagonal";
_missionAreaMarker setMarkerColor "colorOPFOR";
_missionAreaMarker setMarkerAlpha 0.8;

//Create mission objective marker
_missionMarker = str random [11111, 55555, 99999];
_textMarkerPos = getMarkerPos _missionAreaMarker;
createMarker [_missionMarker,_textMarkerPos];
_missionMarker setMarkerType "mil_warning";
_missionMarker setMarkerColor "colorOPFOR";

//Define return array in case no escape mission
_returnArray = [_missionAreaMarker, _missionMarker];

if (_missionType == "Escape") then {
	//Create escape marker
	_escapeMarker = str random [11111, 55555, 99999];
	
	//escape zone must not be on water
	_escapeMarkerLocation = _missionLocation getPos [_radius, selectRandom[45,90,135,180,225,270,315,360]];
	while {surfaceIsWater _escapeMarkerLocation} do {
		_escapeMarkerLocation = _missionLocation getPos [_radius, selectRandom[45,90,135,180,225,270,315,360]];
	};
	
	createMarker [_escapeMarker, _escapeMarkerLocation];
	_escapeMarker setMarkerType "Empty";
	_escapeMarker setMarkerSize [75, 75];
	_escapeMarker setMarkerShape "ELLIPSE";
	_escapeMarker setMarkerBrush "SolidBorder";
	_escapeMarker setMarkerColor "ColorGreen";

	//Mission markers
	_returnArray = [_missionAreaMarker, _missionMarker, _escapeMarker];
};

_returnArray