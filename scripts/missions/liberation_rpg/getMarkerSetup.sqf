// [] call compileFinal preprocessFileLineNumbers "scripts\markers\getMarkerSetup.sqf"

_sectorMarkers = allMapMarkers select 
{
	_x != "respawn_west"
	&& !("fps" in (markerText _x))
	&& getMarkerPos _x distance2D hq_pos > 100
};

_sectorMarkers apply {getMarkerPos _x}