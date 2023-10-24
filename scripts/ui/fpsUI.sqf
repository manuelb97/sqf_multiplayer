//Paras
params [
"_debug"
];

while {true} do 
{
	[format["FPS: %1", round(diag_fps)], "top_left", 2, 0, 0, 87, "Green"] spawn bia_spawn_text;

	uiSleep 1;
};