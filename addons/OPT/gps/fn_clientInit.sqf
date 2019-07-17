/**
* Spielerdarstellung auf der Karte 
* 
* Autor: [GNC]Lord-MDB
*
* Argumente:
* kein
*
* Rückgabewert:
* kein
*
* Server Only:
* Nein
* 
* Lokal:
* Ja
* 
* Global:
* Nein
*
* API:
* Nein
* 
* Beispiel Externer Aufruf:
* [] call EFUNC(gps,clientInit);
* Beispiel interner Aufruf:
* [] call FUNC(clientInit);
*
*/

#include "macros.hpp"

DUMP("Successfully loaded the OPT/GPS module on the client");

// Event Liste
#include "\opt\opt\addons\opt\tracker\Events.hpp"

// Textur Liste
#include "\opt\opt\addons\opt\tracker\Texturen.hpp"

// Offizier Classname
GVAR(officer) = 
[
    "OPT_NATO_Offizier_T",
    "OPT_CSAT_Offizier_T",
	"OPT_NATO_Offizier",
	"OPT_CSAT_Offizier"
];

// Kontrolle ob Map oder Dialog geöffnet wird
DFUNC(dialogCheck) = 
{
	private _verarbeitungEin = false;

	//OPT Karten-Dialog
	if (!(isNull ((findDisplay 444001) displayCtrl 10007))) then
		{
			_verarbeitungEin = true;
		};

	//BIS Artillery Dialog
	if (!(isNull ((findDisplay -1) displayCtrl 500))) then
		{
			_verarbeitungEin = true;
		};

	//BIS  UAV Dialog	
	if (!(isNull ((findDisplay 160) displayCtrl 51))) then
		{
			_verarbeitungEin = true;
		};

	//BIS  Karte und Minimap
	if (visibleMap or visibleGPS) then
		{
			_verarbeitungEin = true;
		};

	_verarbeitungEin	
};

//Ermitteln Spieler der Seite
DFUNC(spielerPoolLeben) = 
{

	params 
	[
		["_units",[]]
	];

	private _spielerPoolLeben = [];

	//Spieler für Soldatengruppe 
	private _groupUnits = units group player;
	private _leaderUnits = [];
	private _unitsToMark = [];  

	private _leaderUnits = (allGroups select {(side (leader _x)) isEqualTo playerSide and ((leader _x) in _units)}) apply {leader _x};

	_unitsToMark append _leaderUnits;
    _unitsToMark append (_groupUnits - [leader player]);
	
	//Spielerfeststellung die zur Seite gehören und keine Revive Status haben 
	
	_unitsToMark apply 
	{ 
		if ((side _x isEqualTo playerSide) and !((_x getVariable ["FAR_isUnconscious", 0]) == 1) and (alive _x)) then
		{
			_spielerPoolLeben pushBack _x;
		};
	};

	//Ofiiziermodus alle Spieler

	if (typeOf player in GVAR(officer)) then
	{	
		_spielerPoolLeben = [];

		_units apply 
		{ 
			if ((side _x isEqualTo playerSide) and !((_x getVariable ["FAR_isUnconscious", 0]) == 1) and (alive _x)) then
			{
				_spielerPoolLeben pushBack _x;
			};
		};	
	};
		
	_spielerPoolLeben

};

//Ermitteln Spieler die Revive Status haben
DFUNC(spielerPoolRevive) = 
{

	params 
	[
		["_units",[]]
	];

	private _spielerPoolRevive = [];

	//Spielerfeststellung die zur Seite gehören und Revive Status haben 
	_units apply 
	{ 
		if ((side _x isEqualTo playerSide) and ((_x getVariable ["FAR_isUnconscious", 0]) == 1) and (alive _x)) then
		{
			_spielerPoolRevive pushBack _x;
		};
	};	

	_spielerPoolRevive
};

//UAV Drohnen
DFUNC(uav) = 
{
	
	params 
	[
		["_unit",nil],
		["_weapon",nil]
	];

	private _uavDrohne = [];
	private _uavMarker = [];

	if (_weapon in allUnitsUAV) then
	{
		if ((side _weapon isEqualTo playerSide) and (alive _weapon)) then
		{
			_uavDrohne pushBack _weapon;
		};
	
		_uavDrohne apply 
		{ 
			if ((GVAR(markerPool) find _x) isEqualTo -1) then
			{
				_uavMarker pushBack _x;
			};
		};

		GVAR(markerPool) append _uavMarker;

		_id = [_uavMarker,1] call FUNC(addMarker);
		
		systemChat format ["U:%1 W:%2 B:%3",_unit,_weapon,(_weapon in allUnitsUAV)];

		//_uavMarker addEventHandler ["Killed", {_this call FUNC(unitkilled);}];

		GVAR(markerIDPool) append _id;
		GVAR(markerPool) append _uavMarker;

		systemChat format ["ID:%1 MP:%2 MIP:%3 U:%4",_id,GVAR(markerIDPool),GVAR(markerPool),_uavMarker];

	};	
};	

//Zusätzliche Marker erstellen
DFUNC(addMarker) = 
{

	params 
	[
		["_units",[]],
		["_modus",0]
	];

	private _farbe = [1,1,1,1];	
	private _idArray = [];
	private _id = 0;
	private _text = "";

	switch (playerSide) do 
	{
    	case west: 
		{
			//blau
			_farbe = [0,0,1,1];	
    	};
    	case east: 
		{
			//rot
        	_farbe = [1,0,0,1];	
   		};
	};

	_units apply 
	{ 
		private _vehName = getText (configFile >> "cfgVehicles" >> typeOf (vehicle _x) >> "displayName");

		switch (_modus) do 
		{
    		case 0: 
			{
				//Spieler
				_text = format["%1", name _x]	
    		};
    		case 1: 
			{
				//UAV
        		_text = format["%1 (---)", _vehName]
   			};
		};

    	private _markerDatenblock = 
		[
		[0,0,0],
		"normal",
		_x,
		_text,
		"mil_triangle", // PLAYER_ICON
		getDir _x,
		_farbe		
		];

		_id = _markerDatenblock call OFUNC(addMarker);

		_idArray pushBack _id;
	};

	_idArray
};

//Update Spielerpool
DFUNC(updateMarkerPool) = 
{
	
	private _units = playableUnits;
	private _spielerPoolAdd = [];
	private _spielerAddEH = [];
	private _id = 0;

	private _spielerPoolAdd = [_units] call FUNC(spielerPoolLeben);

	_spielerPoolAdd apply 
	{ 
		if ((GVAR(markerPool) find _x) isEqualTo -1) then
		{
			_spielerAddEH pushBack _x;
		};
	};

	[_spielerAddEH] call FUNC(addEH);

	_id = [_spielerAddEH,0] call FUNC(addMarker);

	GVAR(markerPool) pushBack _spielerAddEH;
	GVAR(markerIDPool) append _id;

};

//EH hinzufügen
DFUNC(addEH) = 
{
	
	params 
	[
		["_units",[]]
	];

	_units apply 
	{ 
		_x addEventHandler ["GetInMan", {_this call FUNC(spielerMarkerText);}];
		_x addEventHandler ["GetOutMan", {_this call FUNC(spielerMarkerText);}];
		_x addEventHandler ["WeaponAssembled", {_this call FUNC(uav);}];
		_x addEventHandler ["Dammaged", {_this call FUNC(markerTextRevive);}];
	};

};	

//Spieler Marker Text ändern
DFUNC(spielerMarkerText) = 
{
	
	params 
	[
		["_unit",nil],  
		["_role",""], 
		["_vehicle",nil],
		["_turret",[]]
	];

	//Marker Text ändern

	private _vehName = getText (configFile >> "cfgVehicles" >> typeOf (vehicle _unit) >> "displayName");
	private _text = "";

	if (vehicle _unit != _unit) then 
	{
		_text = format["%1 (%2)", _vehName, name _unit];
	}
	else
	{
		_text = format["%1",name _unit];
	};	
		
	private _index = GVAR(markerPool) find _unit;

	[OPT_SET_MARKER_TEXT, [(GVAR(markerIDPool) select _index),_text]] call CFUNC(localEvent);		

};

//UAV Marker Text
DFUNC(uavMarkerText) = 
{
	
	params 
	[
		["_newuav",nil], 
		["_olduav",nil]
	];

	_uav = objNull;

	if (!isNull _newuav) then 
	{
		_uav = _newuav;
	}
	else
	{
		_uav = _olduav;
	};

	// Spezialfall Drohne
    private _operator = (UAVControl vehicle _uav) select 0;

	private _vehName = getText (configFile >> "cfgVehicles" >> typeOf (vehicle _uav) >> "displayName");
	
	private _text = "";

	private _index = 0;

    // UAV Operator ja/nein
    if (!isNull _operator) then 
	{
        _text = format["%1 (%2)", _vehName, name _operator];
    } 
	else 
	{
		_text = format["%1 (---)", _vehName];
    };
						
	_index = GVAR(markerPool) find _uav;

	[OPT_SET_MARKER_TEXT, [(GVAR(markerIDPool) select _index),_text]] call CFUNC(localEvent);

	systemChat format ["I:%1 MP:%2 M:%3 MIP:%4 U:%5 T:%6",_index,GVAR(markerPool),(GVAR(markerIDPool) select _index),GVAR(markerIDPool),_uav,typeName _uav];
			
};

//Marker Text Revive
DFUNC(markerTextRevive) = 
{
	params 
	[
		["_unit",nil]
	];

	//Spieler mit Revive Status
	private _spielerPoolRevive = [];
	private _spielerRevive = [];

	private _spielerPoolRevive = [[_unit]] call FUNC(spielerPoolRevive);

	_spielerPoolRevive apply 
	{ 
		if ((GVAR(markerPool) find _x) > -1) then
		{
			_spielerRevive pushBack _x;
		};
	};

	//Spieler mit Revive Status Marker Text und Symbol ändern
	_spielerRevive apply 
	{ 
		_text = format["%1 wurde getötet", name _x];		
				
		private _index = GVAR(markerPool) find _x;

		[OPT_SET_MARKER_TEXT, [(GVAR(markerIDPool) select _index),_text]] call CFUNC(localEvent);

		[OPT_SET_MARKER_ICON, [(GVAR(markerIDPool) select _index),"loc_Hospital"]] call CFUNC(localEvent);			

	};

};	

//Marker Text zurücksetzen 
DFUNC(removeMarkerTextRevive) = 
{
	params 
	[
		["_unit",nil]
	];

	private _spielerLeben = [];

	//Spieler mit Revive Status
	private _spielerPoolAdd = [[_unit]] call FUNC(spielerPoolLeben);

	_spielerPoolAdd apply 
	{ 
		if ((GVAR(markerPool) find _x) > -1) then
		{
			_spielerLeben pushBack _x;
		};
	};

	//Spieler Marker Text und Symbol auf Standart ändern
	_spielerLeben apply 
	{ 
		_text = format["%1", name _x];		
				
		private _index = GVAR(markerPool) find _x;

		[OPT_SET_MARKER_TEXT, [(GVAR(markerIDPool) select _index),_text]] call CFUNC(localEvent);

		[OPT_SET_MARKER_ICON, [(GVAR(markerIDPool) select _index),"mil_triangle"]] call CFUNC(localEvent);			

	};
		
};	

//Drohne Marker ausblenden bei zerstörung
DFUNC(unitkilled) = 
{
	
	params 
	[
		["_unit",nil],
		["_killer",nil], 
		["_instigator",nil],
		["_useEffects",false]
	];

	private _index = GVAR(markerPool) find _unit;

	[OPT_REMOVE_MARKER, [(GVAR(markerIDPool) select _index)]] call CFUNC(localEvent);

	systemChat format ["Kill I:%1 MP:%2 M:%3 MIP:%4 U:%5 T:%6",_index,GVAR(markerPool),(GVAR(markerIDPool) select _index),GVAR(markerIDPool),_unit,typeName _unit];

	GVAR(markerIDPool) deleteAt _index;

	GVAR(markerPool) deleteAt _index;
};	

//Init GPS System
["missionStarted", 
{
	//Speicher Marker und Einheiten
	GVAR(markerPool) = [];
	GVAR(markerIDPool) = [];

	private _units = playableUnits;

	GVAR(markerPool) = [_units] call FUNC(spielerPoolLeben);

	_id = [GVAR(markerPool),0] call FUNC(addMarker);

	GVAR(markerIDPool) append _id;

	[GVAR(markerPool)] call FUNC(addEH);

	onPlayerConnected "[] call FUNC(updateMarkerPool);";

}, []] call CFUNC(addEventHandler); 

//Event Marker Revive Text zurücksetzen 
[
	OPT_REMOVE_MARKER_TEXT_REVIVE, 
	{
		_this params ["_eventArgs"];

		[_eventArgs] call FUNC(removeMarkerTextRevive);

	},
	[]

] call CFUNC(addEventHandler);

//EH Drohnen Verbinden
["getConnectedUAVChanged",
{
	_this params ["_eventArgs"];

	[OPT_DROHNEN_MARKER_TEXT,_eventArgs] call CFUNC(globalEvent);

},[]] call CFUNC(addEventHandler);

// Event Marker Text bei Drohnen Verbindung/Trennung setzen
[
	OPT_DROHNEN_MARKER_TEXT, 
	{
		_this params ["_eventArgs"];

		_eventArgs call FUNC(UAVMarkerText);
	},
	[]

] call CFUNC(addEventHandler);

// Event Marker für Drohne erstellen im GPS System [Für Shopsystem]
[
	OPT_ADD_MARKER_DROHNE_GPS, 
	{
		_this params ["_eventArgs"];

		private _id = 0;

		_id = [_eventArgs,1] call FUNC(addMarker);

		GVAR(markerPool) pushBack _eventArgs;
		GVAR(markerIDPool) append _id;

		systemChat format ["DM I:%1 EV:%2",_id,_eventArgs];
	},
	[]
	
] call CFUNC(addEventHandler);