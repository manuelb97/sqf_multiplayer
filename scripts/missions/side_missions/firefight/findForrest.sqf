// [] call compileFinal preprocessFileLineNumbers "scripts\firefight\findForrest.sqf";

//Paras
params [
["_forrestCorners", 8],
["_treeRadius", 10],
["_debug", true]
];

//find forrest center
_locs = [];
_vals = [];

for "_i" from 0 to 100 do
{
	_pos = [nil, ["water"]] call BIS_fnc_randomPos;

	_bestLocs = selectBestPlaces [_pos, 200, "2*forest + trees - 2*meadow", 1, 1];
	(_bestLocs select 0) params ["_loc", "_val"];

	_locs pushBack _loc;
	_vals pushBack _val;
};

_forrestCenter = _locs select (_vals find selectMax(_vals));

//find forrest borders
_dirs = [];
_increments = 360 / _forrestCorners;

for "_i" from 0 to (_forrestCorners - 1) do
{
	_dirs pushBack (0 + _increments * _i);
};

_corners = [];

{
	_dir = _x;
	_dirBounds = [_dir - 90, _dir + 90];
	_cornerFound = false;
	_step = 1;
	_counter = 1;

	while {!_cornerFound} do 
	{
		_possCornerPos = _forrestCenter getPos [0 + _step * _counter, _dir];
		_trees = nearestTerrainObjects [_possCornerPos, ["TREE"], _treeRadius, False, true];

		if (count _trees > 0) then 
		{
			_treesAwayFromCenter = _trees select 
			{
				_tree = _x;
				_ret = false;

				_relDir = _possCornerPos getDir _tree;

				if (_relDir > (_dirBounds select 0) && _relDir < (_dirBounds select 1)) then 
				{
					_ret = true;
				};

				_ret
			};

			if (count _treesAwayFromCenter < 1) then 
			{
				_cornerFound = true;
				_corners pushBack _possCornerPos;
			};

			_counter = _counter + 1;
		} else 
		{
			_cornerFound = true;
			_corners pushBack _possCornerPos;
		};
	};
} forEach _dirs;

[_forrestCenter, _corners]

//Debug Markers + player teleport
// _marker = "Forrest" + str(random 9999);
// createMarker [_marker, _forrestCenter];
// _marker setMarkerTypeLocal "loc_ViewTower";
// _marker setMarkerColorLocal "colorOPFOR";
// _marker setMarkerSize [3, 3];

// player setPos _forrestCenter;

// {
// 	_marker = str _x;
// 	createMarker [_marker, _x];
// 	_marker setMarkerTypeLocal "loc_ViewTower";
// 	_marker setMarkerColorLocal "colorOPFOR";
// 	_marker setMarkerSize [10, 10];
// } forEach _corners;