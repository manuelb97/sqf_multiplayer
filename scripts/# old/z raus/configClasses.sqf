 _getClasses = { 
 
  params ["_faction", "_array"]; 
  _array = []; 
   
  { 
   if ((configName _x) isKindoF "CAManBase") then { 
    _array pushback (configName _x); 
   }; 
  } forEach ("getText (_x >> 'faction') == _faction" configClasses (configfile >> "CfgVehicles")); 
   
  _array 
 };

["blu_F"] call _getClasses;
Change "blu_F" to any faction you want,

 

or for many factions of defined side:

	_getsideFactions = {
	
		params ["_side", "_array"];
		
		_array = [];
		{
			_array pushback	(configName _x);
		} forEach ("getNumber (_x >> 'side') isEqualTo _side" configClasses (configfile >> "CfgFactionClasses"));
		
		_array
	}; 

	_getClasses = {

		params ["_faction", "_array"];
		_array = [];
		
		{
			if ((configName _x) isKindoF "CAManBase") then {
				_array pushback	(configName _x);
			};
		} forEach ("getText (_x >> 'faction') == _faction" configClasses (configfile >> "CfgVehicles"));
		
		_array
	};

	_factions = [1] call _getsideFactions; //0 = east, 1 = west, 2= IND, 3 = civ
	_allunitsofside = [];
	{
				
		_factionunits = [_x] call _getClasses;
		_allunitsofside = _allunitsofside + _factionunits;
	} forEach _factions;	