//Create 4 sectors split at map middle
_mapSize = worldName call BIS_fnc_mapSize;
_leftSectorXPos = _mapSize / 4;
_rightSectorXPos = _leftSectorXPos * 3;

_sector1Pos = [_leftSectorXPos,_leftSectorXPos];
_sector2Pos = [_leftSectorXPos,_rightSectorXPos];
_sector3Pos = [_rightSectorXPos,_leftSectorXPos];
_sector4Pos = [_rightSectorXPos,_rightSectorXPos];

_sectors = [_sector1Pos,_sector2Pos,_sector3Pos,_sector4Pos];

private ["_sector1","_sector2","_sector3","_sector4"];
for "_i" from 1 to count(_sectors) do {
	_sectorMarker = str random [11111, 55555, 99999];
	createMarker [_sectorMarker, _sectors select (_i - 1)];
	_sectorMarker setMarkerType "Empty";
	_sectorMarker setMarkerShape "RECTANGLE";
	_sectorMarker setMarkerBrush "Solid";
	_sectorMarker setMarkerAlpha 0.4;
	_sectorMarker setMarkerSize [_leftSectorXPos - 50, _leftSectorXPos - 50];
	
	switch (_i) do {
		case 1: 	{ 
			_sectorMarker setMarkerColor "colorOPFOR";
			_sector1 = _sectorMarker;
		};
		case 2:	{ 
			_sectorMarker setMarkerColor "colorCivilian"; 
			_sector4 = _sectorMarker;
		};
		case 3: 	{ 
			_sectorMarker setMarkerColor "colorIndependent"; 
			_sector3 = _sectorMarker;
		};
		case 4: 	{ 
			_sectorMarker setMarkerColor "colorBLUFOR"; 
			_sector2 = _sectorMarker;
		};
	};
};

sectors = [_sector4,_sector3,_sector2,_sector1];
publicVariable "sectors";