//Paras
params [
"_marker",
"_radius",
"_varName",
"_debug"
];

_x = 35; 
_y = 5;
_dur = 2;
_fade = 0;
_delta = 0;
_layer = 88;
_numLines = 40;

#define SCALEFACTOR getNumber( configFile >> "uiScaleFactor" ) 
#define GRID_X( gridType, gridScale, num ) ( pixelW * gridType * ((( num ) * ( gridScale )) / SCALEFACTOR )) 
#define GRID_Y( gridType, gridScale, num ) ( pixelH * gridType * ((( num ) * ( gridScale )) / SCALEFACTOR )) 
#define GRID_SCALE 8 //Size of a grid cell 

_lines = "";
for "_i" from 1 to _numLines do 
{
	_lines = _lines + "|";
};

//string select [start, length]

while {missionNamespace getVariable [format["%1_active", _marker], false]} do 
{
	_sectorOpfor = allUnits select {_x getVariable [_varName, false] && side _x == east};
	_sectorBlufor = allPlayers select 
	{
		_player = _x;
		
		_kindArr = [];
		{
			_type = _x;
			_kindArr pushBack ((vehicle _player) isKindOf _type);
		} forEach ["Car", "Tank", "Ship", "Helicopter", "Plane"];

		_x distance2D (getMarkerPos _marker) <= _radius
		&& (vehicle _player == _player || _kindArr select 0 || _kindArr select 1)
	};

	if (count _sectorBlufor > 0) then 
	{
		_numOpf = count _sectorOpfor;
		_numBlu = count _sectorBlufor;
		_total = _numOpf + _numBlu;

		_numBlueLines = round(((_numLines / _total) * _numBlu) * 1.9); // *1.9 since we want 50/50 to be close 95%
		_numRedLines = _numLines - _numBlueLines;

		_inputBlu = parseText format ["<t color='#0000FF' size = '.8' align='center'>%1</t>", _lines select [0, _numBlueLines]];
		_inputOpf = parseText format ["<t color='#FF0000' size = '.8' align='center'>%1</t>", _lines select [_numBlueLines + 1]];
		_text = composeText [_inputBlu, _inputOpf];

		[
			_text, 
			safeZoneXAbs + GRID_X( pixelGrid, GRID_SCALE, _x), //_x, 
			safeZoneY + GRID_Y( pixelGrid, GRID_SCALE, _y), //_y,  
			_dur, _fade, _delta, _layer
		] spawn BIS_fnc_dynamicText;
	};

	uiSleep 1;
};