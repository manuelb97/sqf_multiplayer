//Paras
params [
"_input", 
["_location", "center_top"],
["_dur", 5], 
["_fade", 0], 
["_delta", 0], 
["_layer", 86], 
["_color", "Green"]
];

_debug = false;
_tag = "SpawnText";

if (_debug) then
{
	_debugText = format["%1\n%2\n%3\n%4\n%5\n%6\n%7", _input, _x, _y, _dur, _fade, _delta, _layer];
	[_tag, _debugText] remoteExec ["bia_to_log", 2, false]; 
};

//define screen land marks which differ from setup to setup 
#define SCALEFACTOR getNumber( configFile >> "uiScaleFactor" ) 
#define GRID_X( gridType, gridScale, num ) ( pixelW * gridType * ((( num ) * ( gridScale )) / SCALEFACTOR )) 
#define GRID_Y( gridType, gridScale, num ) ( pixelH * gridType * ((( num ) * ( gridScale )) / SCALEFACTOR )) 
#define GRID_SCALE 8 //Size of a grid cell 

//define screen location 
_x = 57;
_y = 10;

switch (_location) do
{
	case "center": { _x = 35; _y = 32; };
	case "center_top": { _x = 35; _y = 5; };
	case "top_left": { _x = 1; _y = 1; };
	case "left_1": { _x = 1; _y = 13; };
	case "left_2": { _x = 1; _y = 16; };
	case "left_3": { _x = 1; _y = 19; };
	case "left_4": { _x = 1; _y = 22; };
	case "left_5": { _x = 1; _y = 25; };
	case "left_6": { _x = 1; _y = 28; };
	case "left_7": { _x = 1; _y = 31; };
};

//define color 
_text = _input;

if (_color != "Complete") then 
{
	_colorTxt = "<t color='#ff0000'"; // red

	if (_color == "Green") then
	{
		_colorTxt = "<t color='#00FF00'"; // Green
	};

	_alignment = "left";
	if ("center" in _location) then 
	{
		_alignment = "center";
	};

	_textStr = format ["%1 size = '.8' align='%2'>%3</t>", _colorTxt, _alignment, _input splitString " " joinString toString [160]];
	_text = parseText _textStr; 
};

//show text
[
	_text, 
	safeZoneXAbs + GRID_X( pixelGrid, GRID_SCALE, _x), //_x, 
	safeZoneY + GRID_Y( pixelGrid, GRID_SCALE, _y), //_y, 
	_dur, _fade, _delta, _layer
] spawn BIS_fnc_dynamicText;