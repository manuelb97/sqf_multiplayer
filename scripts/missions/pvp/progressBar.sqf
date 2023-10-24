//Paras
params [
"_missionLocation",
"_activeVarName",
"_radius",
"_delay"
];

uiSleep _delay;

_posX = 35; 
_posY = 5;
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

while {missionNamespace getVariable [_activeVarName, false]} do 
{
	_sectorBlufor = allUnits select {side _x == west && _x distance2D _missionLocation <= _radius};
	_sectorBlufor = _sectorBlufor + (allPlayers select {side _x == west && _x distance2D _missionLocation <= _radius});

	_sectorOpfor = allUnits select {side _x == east && _x distance2D _missionLocation <= _radius};
	_sectorOpfor = _sectorOpfor + (allPlayers select {side _x == east && _x distance2D _missionLocation <= _radius});
	
	_numBlu = selectMax [count _sectorBlufor, 1];
	_numOpf = selectMax [count _sectorOpfor, 1];
	_total = _numBlu + _numOpf;

	_numBlueLines = round((_numLines / _total) * _numBlu);

	_blueLines = _lines select [0, _numBlueLines];
	_redLines = _lines select [_numBlueLines + 1];

	if (count _sectorOpfor < 1) then 
	{
		_blueLines = _lines;
		_redLines = "";
	};

	if (count _sectorBlufor < 1) then 
	{
		_blueLines = "";
		_redLines = _lines;
	};

	_inputBlu = parseText format ["<t color='#0000FF' size = '.8' align='center'>%1</t>", _blueLines];
	_inputOpf = parseText format ["<t color='#FF0000' size = '.8' align='center'>%1</t>", _redLines];
	_text = composeText [_inputBlu, _inputOpf];

	if (player distance2D hq_pos > 100) then
	{
		[
			_text, 
			safeZoneXAbs + GRID_X( pixelGrid, GRID_SCALE, _posX), //_x, 
			safeZoneY + GRID_Y( pixelGrid, GRID_SCALE, _posY), //_y,  
			_dur, _fade, _delta, _layer
		] spawn BIS_fnc_dynamicText;
	};

	uiSleep 1;
};