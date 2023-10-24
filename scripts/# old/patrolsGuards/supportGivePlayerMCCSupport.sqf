//Paras
params [
"_numForNewSupp",
"_debug"
];

_tag = "SupportLoop";

if (_debug) then 
{
	_text = format["Loop started"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

if (_debug) then 
{
	_text = format["Adding new Support every %1 cleared Buildings",_numForNewSupp];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

/*
//Reset support arrays at start
if (_debug) then 
{
	[format["Clear MCC Support Arrays at Start"]] remoteExec ["hint", 0, true]; 
	uiSleep 5;
};

HW_arti_types = [];
MCC_server setVariable ["Arti_WEST_shellsleft",0,true];
(missionNamespace getVariable ["MCC_server",objNull]) setVariable ["Arti_WEST_shellsleft",0,true];

MCC_CASConsoleArrayWEST = [];
publicVariable "MCC_CASConsoleArrayWEST";

if (_debug) then 
{
	[format[	"Arty Types: %1\nNew Shells: %2\nCAS: %3", 
					HW_arti_types, MCC_server getVariable ["Arti_WEST_shellsleft",0], MCC_CASConsoleArrayWEST
				]
	] remoteExec ["hint", 0, true]; 
	uiSleep 10;
};
*/

//Start support monitoring
_numClearedBuilds = count(allMapMarkers select {markerColor _x == "ColorGreen" && (getMarkerPos _x) inArea Flare_Trigger});

if (_debug) then 
{
	_text = format["Num cleared Buildings at Start: %1", _numClearedBuilds];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

while {true} do 
{
	//check if more buildings have been cleared
	_numClearedBuildsNew = count(allMapMarkers select {markerColor _x == "ColorGreen" && (getMarkerPos _x) inArea Flare_Trigger});
	
	if (_debug) then 
	{
		_text = format["Additional Buildings Cleared: %1", _numClearedBuildsNew - _numClearedBuilds];
		[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
	};
	
	if ((_numClearedBuildsNew - _numForNewSupp) >= _numClearedBuilds) then
	{
		//Prep Saving
		_currentSupps = ["Supports",[[], 0, []]] call bia_load_from_profile;//compile preprocessFileLineNumbers "scripts\patrolsGuards\NewSaving\loadFromProfile.sqf";
		
		//Reset Clearing Count
		_numClearedBuilds = _numClearedBuildsNew;
	
		//Start building final hint
		_hintStr = format["Available Supports:\n"];

		//Possible supps
		_possArty = ["HE 155mm","HE 155mm"];
		_possCAS = ["Gun-Run","Rocket-Run","JDAM","LGB","UAV","AC-130"];

		//Lengthen arty array to make cas and arty equally probable
		if (count _possCAS > count _possArty) then
		{
			_diff = (count _possCAS) - (count _possArty);
			
			for "_i" from 1 to _diff do 
			{
				_possArty append _possArty;
			};
		};

		//Determine number of supports
		_suppNum = selectRandom[1]; //,2,3

		//Select supports
		_possSupps = _possArty + _possCAS;
		_availSupps = [];

		for '_i' from 1 to _suppNum do 
		{
			_addSupp = selectRandom _possSupps;
			
			if (_addSupp != "HE 155mm" && _addSupp != "HE Laser") then {
				_possSupps deleteAt (_possSupps find _addSupp);
			};
			_availSupps pushBack _addSupp;
		};

		//AC-130 so op, we gotta cut the rest if selected
		if ("AC-130" in _availSupps) then {
			_availSupps = ["AC-130"];
		};
		
		[format["New Supps: %1",_availSupps]] remoteExec ["hint", 0, true]; 

		//Debug before supps added to global arrays
		if (_debug) then 
		{
			_text = format[	"Supps before new Supp\nArty Types: %1\nNew Shells: %2\nCAS: %3", 
									HW_arti_types, MCC_server getVariable ["Arti_WEST_shellsleft",0], MCC_CASConsoleArrayWEST
									];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
		
		//Add selected supports to commander
		_numShells = MCC_server getVariable ["Arti_WEST_shellsleft",0];

		if ("HE 155mm" in _availSupps) then {
			HW_arti_types pushBackUnique ["HE 155mm","Sh_155mm_AMOS"];
			_numShells = _numShells + ({_x == "HE 155mm"} count _availSupps);
			
			(_currentSupps select 0) pushBackUnique ["HE 155mm","Sh_155mm_AMOS"];
			_currentSupps set [1, (_currentSupps select 1) + ({_x == "HE 155mm"} count _availSupps)];
		};
		if ("HE Laser" in _availSupps) then {
			HW_arti_types pushBackUnique ["HE Laser-guided","Bo_GBU12_LGB"];
			_numShells = _numShells + ({_x == "HE Laser"} count _availSupps);
			
			(_currentSupps select 0) pushBackUnique ["HE Laser-guided","Bo_GBU12_LGB"];
			_currentSupps set [1, (_currentSupps select 1) + ({_x == "HE Laser"} count _availSupps)];
		};

		//Special hint adjustment for arty
		if ("HE 155mm" in _availSupps && "HE Laser" in _availSupps) then { 
			_hintStr = _hintStr + format["%1 guided & unguided Artillery Shells\n",_numShells];
		} else {
			if ("HE 155mm" in _availSupps) then { 
				_hintStr = _hintStr + format["%1 unguided Artillery Shells\n",_numShells];
			};
			if ("HE Laser" in _availSupps) then { 
				_hintStr = _hintStr + format["%1 guidedArtillery Shells\n",_numShells];
			};
		};

		//CAS
		if ("Gun-Run" in _availSupps) then {
			MCC_CASConsoleArrayWEST pushBack [["Gun-run (Direct)"],["B_Plane_CAS_01_dynamicLoadout_F"]];
			_hintStr = _hintStr + format["CAS Gun-Run\n"];
			
			(_currentSupps select 2) pushBack [["Gun-run (Direct)"],["B_Plane_CAS_01_dynamicLoadout_F"]];
		};
		if ("Rocket-Run" in _availSupps) then {
			MCC_CASConsoleArrayWEST pushBack [["Rockets-run (Direct)"],["B_Plane_CAS_01_dynamicLoadout_F"]];
			_hintStr = _hintStr + format["CAS Rocket-Run\n"];
			
			(_currentSupps select 2) pushBack [["Rockets-run (Direct)"],["B_Plane_CAS_01_dynamicLoadout_F"]];
		};
		if ("JDAM" in _availSupps) then {
			MCC_CASConsoleArrayWEST pushBack [["JDAM"],["B_Plane_CAS_01_dynamicLoadout_F"]];
			_hintStr = _hintStr + format["JDAM Strike\n"];
			
			(_currentSupps select 2) pushBack [["JDAM"],["B_Plane_CAS_01_dynamicLoadout_F"]];
		};
		if ("LGB" in _availSupps) then {
			MCC_CASConsoleArrayWEST pushBack [["LGB"],["B_Plane_CAS_01_dynamicLoadout_F"]];
			_hintStr = _hintStr + format["Guided Bomb\n"];
			
			(_currentSupps select 2) pushBack [["LGB"],["B_Plane_CAS_01_dynamicLoadout_F"]];
		};
		if ("UAV" in _availSupps) then {
			MCC_CASConsoleArrayWEST pushBack [["UAV"],["B_UAV_02_dynamicLoadout_F"]];
			_hintStr = _hintStr + format["UAV Overwatch\n"];
			
			(_currentSupps select 2) pushBack [["UAV"],["B_UAV_02_dynamicLoadout_F"]];
		};
		if ("AC-130" in _availSupps) then {
			MCC_CASConsoleArrayWEST pushBack [["UAV"],["B_T_VTOL_01_armed_F"]];
			_hintStr = _hintStr + format["AC-130 Overwatch\n"];
			
			(_currentSupps select 2) pushBack [["UAV"],["B_T_VTOL_01_armed_F"]];
		};

		//Extra code to add supps
		publicVariable "HW_arti_types";
		MCC_server setVariable ["Arti_WEST_shellsleft",_numShells,true];
		(missionNamespace getVariable ["MCC_server",objNull]) setVariable ["Arti_WEST_shellsleft",_numShells,true];

		//HW_arti_number_shells_per_hour = HW_arti_number_shells_per_hour + _numShells; 
		//publicVariable "HW_arti_number_shells_per_hour";
		//_sideVar = format ["Arti_%1_shellsleft",west];

		publicVariable "MCC_CASConsoleArrayWEST";
		
		if (_debug) then 
		{
			_text = format[	"Supps after new Supp\nArty Types: %1\nNew Shells: %2\nCAS: %3", 
									HW_arti_types, MCC_server getVariable ["Arti_WEST_shellsleft",0], MCC_CASConsoleArrayWEST
									];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};

		//Add remote control action to commander if supps need it
		if (!isNil "manu" && [["UAV"],["B_UAV_02_dynamicLoadout_F"]] in MCC_CASConsoleArrayWEST) then {
			manu addAction ["Remote Control Support (UAV)","scripts\missions\support\remoteControl.sqf", ["B_UAV_02_dynamicLoadout_F"], 1.5,true,false,"","true",5,false,"",""];
		};
		if (!isNil "manu" && [["UAV"],["B_T_VTOL_01_armed_F"]] in MCC_CASConsoleArrayWEST) then {
			manu addAction ["Remote Control Support (AC-130)","scripts\missions\support\remoteControl.sqf", ["B_T_VTOL_01_armed_F"], 1.5,true,false,"","true",5,false,"",""];
		};

		//Give info about what supps are available
		if (_hintStr != "Available Supports:\n") then {
			[_hintStr] remoteExec ["hint", 0, true];
		} else {
			["No Supports available"] remoteExec ["hint", 0, true];
		};	
		
		//Save to ProfileNameSpace
		["Supports", _currentSupps] execVM "scripts\patrolsGuards\NewSaving\saveToProfile.sqf";
	} else
	{
		if (_debug) then 
		{
			_text = format["Waiting for buildings to be cleared"];
			[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
		};
	};
	
	uiSleep 10;
};

if (_debug) then 
{
	_text = format["Loop terminated"];
	[_tag, _text] remoteExec ["bia_to_log", 2, false]; 
};

_host = selectRandom allPlayers;
[_numForNewSupp, _debug] remoteExec ["bia_support",_host, false];

/*
_clearedPosArr = ["ClearedPosArr",[]] call bia_load_from_profile; //compile preprocessFileLineNumbers "scripts\patrolsGuards\NewSaving\loadFromProfile.sqf";
_clearedPosArr pushBack (getMarkerPos _nearestMarker);
["ClearedPosArr",_clearedPosArr] execVM "scripts\patrolsGuards\NewSaving\saveToProfile.sqf";
*/