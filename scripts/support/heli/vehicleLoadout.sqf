//Params
params [
"_target", 
"_caller", 
"_arguments"
];

_arguments params ["_loadoutType"];
_veh = missionNamespace getVariable ["BiA_Heli", objNull];

if (!isNull _veh) then 
{
	if (_caller distance2D hq_pos < 100) then 
	{
		if (vehicle _caller == _caller) then 
		{
			[_veh, true] call ace_pylons_fnc_showDialog; //true should enable all edits, otherwise ressources checked
		} else 
		{
			"Need to exit vehicle" remoteExec ["hint", _caller];
		};
	} else 
	{
		"Too far from HQ" remoteExec ["hint", _caller];
	};
} else 
{
	"Vehicle not found" remoteExec ["hint", _caller];
};

/*
_mags = [];
_magTypes = [];

//does this clean all prior weapons
{
	_veh setPylonLoadout [_x, ""];
} forEach _pylonIdxs;

if (!isNull _veh) then 
{
	_pylonInfo = getAllPylonsInfo _veh;
	_pylonIdxs = _pylonInfo apply {_x select 0};
	_compMagsPerPylon = (_pylonIdxs apply {_veh getCompatiblePylonMagazines _x;}) select 0;

	_lighties = ["I_Heli_light_03_dynamicLoadout_F", "O_Heli_Light_02_dynamicLoadout_F", "B_Heli_Light_01_dynamicLoadout_F"];
	_heavies = ["O_T_VTOL_02_infantry_dynamicLoadout_F", "O_Heli_Attack_02_dynamicLoadout_F"];
	// PylonRack_19Rnd_Rocket_Skyfire

	switch (_loadoutType) do
	{
		case "Anti Infantry":
		{
			if (typeOf _veh in _heavies) then 
			{
				_magTypes = ["PylonRack_20Rnd_Rocket_03_HE_F"];
			} else 
			{
				_magTypes = ["PylonWeapon_300Rnd_20mm_shells"];
			};
		};
		case "Anti Vehicle":
		{
			if (typeOf _veh in _heavies) then 
			{
				_magTypes = ["PylonRack_20Rnd_Rocket_03_AP_F"];
			} else 
			{
				_magTypes = ["PylonRack_7Rnd_Rocket_04_AP_F"];
			};
		};
		case "Universal":
		{
			if (typeOf _veh in _heavies) then 
			{
				_magTypes = ["PylonRack_19Rnd_Rocket_Skyfire", "PylonRack_19Rnd_Rocket_Skyfire"];
			} else 
			{
				_magTypes = ["PylonRack_12Rnd_missiles", "PylonRack_12Rnd_missiles"];
			};
		};
	};

	while {count _mags < count _pylonIdxs} do 
	{
		_mags append _magTypes;
	};

	_success = false;
	{
		_pylon = _x;
		_mag = _mags select _forEachIndex;
		_compMags = _compMagsPerPylon select _forEachIndex;

		if (_mag in _compMags) then 
		{
			_veh setPylonLoadout [_pylon, _mag];
			_success = true;
		} else 
		{
			_nxtMag = selectRandom (_mags - _mag);

			if (_nxtMag in _compMags) then 
			{
				_veh setPylonLoadout [_pylon, _nxtMag];
				_success = true;
			} else 
			{
				format["No comp Mag for Pylon %1", _pylon] remoteExec ["hint", _caller];
			};
		};
	} forEach _pylonIdxs;
	_veh setVehicleAmmo 1;

	if (_success) then 
	{
		format["%1 Loadout applied", _loadoutType] remoteExec ["hint", _caller];
	};
} else 
{
	"Vehicle not found" remoteExec ["hint", _caller];
};
*/