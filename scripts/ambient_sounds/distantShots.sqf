[] spawn
{
	_dir = random 360;

	for "_i" from 0 to 15 do
	{
		playSound3D 
		[
			"\jsrs_soundmod_complete\JSRS_Soundmod_Soundfiles\weapons\Shot\MG42\Medium_Distance.ogg", 
			player, false, player getPos [100,_dir], 1, 1, 0, 0, false
		];
		sleep 0.1;
	};
};