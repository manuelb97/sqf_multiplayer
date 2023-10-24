/* Debug
[] call compileFinal preprocessFileLineNumbers "scripts\sectors\markerLegend.sqf";
[] execVM "scripts\sectors\markerLegend.sqf";
*/

//Create markers with text explaining the mission types
_mapSize = worldName call BIS_fnc_mapSize;
_markerLegendPosX = -2200;
_markerLegendPosY = _mapSize - 500;
_markerSize = [0.75, 0.75];
_markerDistance = 1200;

//Liberation
_markerPos = [_markerLegendPosX, _markerLegendPosY];
_libLegend = str random [11111, 55555, 99999];
createMarker [_libLegend, _markerPos];
_libLegend setMarkerType "mil_marker";
_libLegend setMarkerText " L i b e r a t i o n";
_libLegend setMarkerSize _markerSize;

//Defence
_markerPos = [_markerLegendPosX, _markerLegendPosY - _markerDistance];
_defLegend = str random [11111, 55555, 99999];
createMarker [_defLegend, _markerPos];
_defLegend setMarkerType "mil_flag";
_defLegend setMarkerText " D e f e n c e";
_defLegend setMarkerSize _markerSize;

//HVT
_markerPos = [_markerLegendPosX, _markerLegendPosY - 2 * _markerDistance];
_hvtLegend = str random [11111, 55555, 99999];
createMarker [_hvtLegend, _markerPos];
_hvtLegend setMarkerType "mil_end";
_hvtLegend setMarkerText " H V T";
_hvtLegend setMarkerSize _markerSize;

//Heist
_markerPos = [_markerLegendPosX, _markerLegendPosY - 3 * _markerDistance];
_heistLegend = str random [11111, 55555, 99999];
createMarker [_heistLegend, _markerPos];
_heistLegend setMarkerType "mil_unknown";
_heistLegend setMarkerText " H e i s t";
_heistLegend setMarkerSize _markerSize;

//Escape
_markerPos = [_markerLegendPosX, _markerLegendPosY - 4 * _markerDistance];
_escLegend = str random [11111, 55555, 99999];
createMarker [_escLegend, _markerPos];
_escLegend setMarkerType "mil_pickup";
_escLegend setMarkerText " E s c a p e";
_escLegend setMarkerSize _markerSize;

//Sniper
_markerPos = [_markerLegendPosX, _markerLegendPosY - 5 * _markerDistance];
_snipLegend = str random [11111, 55555, 99999];
createMarker [_snipLegend, _markerPos];
_snipLegend setMarkerType "mil_objective";
_snipLegend setMarkerText " S n i p e r";
_snipLegend setMarkerSize _markerSize;

//Sabotage
_markerPos = [_markerLegendPosX, _markerLegendPosY - 6 * _markerDistance];
_sabLegend = str random [11111, 55555, 99999];
createMarker [_sabLegend, _markerPos];
_sabLegend setMarkerType "mil_join";
_sabLegend setMarkerText " S a b o t a g e";
_sabLegend setMarkerSize _markerSize;

//Zombie
_markerPos = [_markerLegendPosX, _markerLegendPosY - 7 * _markerDistance];
_zomLegend = str random [11111, 55555, 99999];
createMarker [_zomLegend, _markerPos];
_zomLegend setMarkerType "mil_circle";
_zomLegend setMarkerText " Z o m b i e";
_zomLegend setMarkerSize _markerSize;

//Tier legend
_markerSize = [2,2];

//Tier 1
_markerPos = [_markerLegendPosX, _markerLegendPosY - 8 * _markerDistance];
_tier1Sector = str random [11111, 55555, 99999];
createMarker [_tier1Sector, _markerPos];
_tier1Sector setMarkerType "mil_box";
_tier1Sector setMarkerText " T i e r  1";
_tier1Sector setMarkerSize _markerSize;
_tier1Sector setMarkerColor "colorOPFOR";

//Tier 2
_markerPos = [_markerLegendPosX, _markerLegendPosY - 9 * _markerDistance];
_tier2Sector = str random [11111, 55555, 99999];
createMarker [_tier2Sector, _markerPos];
_tier2Sector setMarkerType "mil_box";
_tier2Sector setMarkerText " T i e r  2";
_tier2Sector setMarkerSize _markerSize;
_tier2Sector setMarkerColor "colorBLUFOR";

//Tier 3
_markerPos = [_markerLegendPosX, _markerLegendPosY - 10 * _markerDistance];
_tier3Sector = str random [11111, 55555, 99999];
createMarker [_tier3Sector, _markerPos];
_tier3Sector setMarkerType "mil_box";
_tier3Sector setMarkerText " T i e r  3";
_tier3Sector setMarkerSize _markerSize;
_tier3Sector setMarkerColor "colorIndependent";

//Tier 4
_markerPos = [_markerLegendPosX, _markerLegendPosY - 11 * _markerDistance];
_tier4Sector = str random [11111, 55555, 99999];
createMarker [_tier4Sector, _markerPos];
_tier4Sector setMarkerType "mil_box";
_tier4Sector setMarkerText " T i e r  4";
_tier4Sector setMarkerSize _markerSize;
_tier4Sector setMarkerColor "colorCivilian";

//Legend Markers
legendMarkers = [_libLegend,_defLegend,_hvtLegend,_heistLegend,_escLegend,_snipLegend,_sabLegend,_zomLegend,
						_tier1Sector,_tier2Sector,_tier3Sector,_tier4Sector];
publicVariable "legendMarkers";