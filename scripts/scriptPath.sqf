//Params
params [
"_script_dir",
"_filename"
];

compileFinal preprocessFileLineNumbers (_script_dir + _filename + ".sqf")