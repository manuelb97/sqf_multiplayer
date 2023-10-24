//Paras
params [
"_text", 
"_x", 
"_y", 
"_dur", 
"_fade", 
"_delta", 
"_layer",
"_color"
];

_debug = false;
_tag = "SpawnText";

if (_debug) then
{
	_text = format["%1\n%2\n%3\n%4\n%5\n%6\n%7", _text, _x, _y, _dur, _fade, _delta, _layer];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

if (_color == "Red") then
{
	//<t color='#ff0000' size = '.8' align='right'>%1</t>
	//_text = parseText ("<t color='#ff0000' size = '.8' align='right'>%1</t>" + _text);
	_text = parseText format ["<t color='#ff0000' size = '.8' align='right'>%1</t>", _text splitString " " joinString toString [160]];
};
if (_color == "Green") then
{
	//<t color='#00FF00' size = '.8' align='right'>%1</t>
	//_text = parseText ("<t color='#00FF00' size = '.8' align='right'>%1</t>" + _text);
	_text = parseText format ["<t color='#00FF00' size = '.8' align='right'>%1</t>", _text splitString " " joinString toString [160]];
};

[_text, _x, _y, _dur, _fade, _delta, _layer] spawn BIS_fnc_dynamicText;