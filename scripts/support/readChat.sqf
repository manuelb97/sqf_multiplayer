//Params
// params [
// "_cmdArr",
// "_signal"
// ];

addMissionEventHandler ["HandleChatMessage", {
	params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType"];
	
	// ["read_chat", format["event_arr: %1", [_channel, _owner, _from, _text, _person, _name, _strID, _forcedDisplay, _isPlayerMessage, _sentenceType, _chatMessageType]]] spawn bia_to_log;
	
	_cmdArr = [
		"AT", "HE", "Smoke", "Flare", 
		"GunRun", "RocketRun", "AC130", 
		"QRF", "Sniper", 
		"Marker", "Supply", "Kit"
	];
	_signal = "#";

	_tag = "ReadChat";
	// [_tag, format["Chat Msg: %1", _text]] spawn bia_to_log;

	if (_signal in _text) then 
	{
		if (")" in _text) then 
		{
			_text = (_text splitString ")") select 1;
		};

		_chatArr = _text splitString "#";
		_chatArr = (_chatArr select 0) splitString " ";

		if (count _chatArr > 0) then 
		{
			_chatFunc = _chatArr select 0;
			_chatArr = [_person] + _chatArr;

			// ["read_chat", format["chat_arr: %1", _chatArr]] spawn bia_to_log;
			
			if (_chatFunc in _cmdArr) then
			{ 
				[_tag, format["Executing Chat Support: %1", _chatFunc]] spawn bia_to_log;

				[_chatArr] spawn bia_chat_execute;
				_lastFunc = _chatArr;
			}; 
		};
	};
}];

/*
old code to achieve the same but not for remote controlled ai

_cmdArr = ["AT", "HE", "Smoke", "Flare", "GunRun", "RocketRun", "AC130", "Sniper", "Marker", "Supply"];
_signal = "#";
_debug = true;
_lastFunc = [];

while {true} do 
{ 
	_chat = ctrlText (finddisplay 24 displayctrl 101);

	if (_signal in _chat) then 
	{
		_chatArr = _chat splitString "#";
		_chatArr = (_chatArr select 0) splitString " ";

		if (count _chatArr > 0) then 
		{
			_chatFunc = _chatArr select 0;
			
			if (_chatFunc in _cmdArr && !(_chatArr isEqualTo _lastFunc)) then  
			{ 
				[_chatArr] spawn bia_chat_execute;
				_lastFunc = _chatArr;
			}; 
		};
	};

	uiSleep 1;
};
*/