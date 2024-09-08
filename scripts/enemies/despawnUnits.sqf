//Paras
params [
"_unitArray"
];

{
	deleteVehicle _x;

	if (count (units group _x) < 1) then 
	{
		deleteGroup group _x;
	};
} forEach _unitArray;