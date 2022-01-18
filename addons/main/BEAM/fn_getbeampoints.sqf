/**
* Description:
* provides a list of all valid beampoints for a playerside
*
* Author:
* form
*
*
* Arguments:
* 0: <playerSide> Can be west or east
* 1: <bool> If true and player near beampoint, return list without that position
*
* Return Value:
* Array of valid beampoints
* Format: [[position, description, markertext, level], ... ]
*
* Level 0: Heimat- und Außenbasis
* Level 1: Fahnenpunkte
* Level 2: Beampunkte
*
* Server only:
* no
*
* Public:
* yes
*
* Global:
* no
*
* Example:
* [playerSide, false] call FUNC(getbeampoints);
*/

#include "macros.hpp"

params [["_side", civilian], ["_withoutPlayer", false]];

private _Homebase = nil;
private _Outpost = nil;
private _OwnSectorsAll = [];
private _OwnSectorsSelected = [];
private _OwnFlagsSelected = [];
private _EnemySectorsAll = [];
private _EnemySectorsSelected = [];
private _EnemyFlagsSelected = [];

switch playerSide do
{
    case west:
    {
        _Homebase = west_Basis_Teleport1;
        _Outpost = west_Basis_Teleport2;
        _OwnSectorsAll = EGVAR(SECTORCONTROL,nato_allsectors);
        _OwnSectorsSelected = EGVAR(SECTORCONTROL,nato_sectors);
        _OwnFlagsSelected = EGVAR(SECTORCONTROL,nato_flags);
        _EnemySectorsAll = EGVAR(SECTORCONTROL,csat_allsectors);
        _EnemySectorsSelected = EGVAR(SECTORCONTROL,csat_sectors);
        _EnemyFlagsSelected = EGVAR(SECTORCONTROL,csat_flags);
    };

    case east:
    {
        _Homebase = east_Basis_Teleport1;
        _Outpost = east_Basis_Teleport2;
        _OwnSectorsAll = EGVAR(SECTORCONTROL,csat_allsectors);
        _OwnSectorsSelected = EGVAR(SECTORCONTROL,csat_sectors);
        _OwnFlagsSelected = EGVAR(SECTORCONTROL,csat_flags);
        _EnemySectorsAll = EGVAR(SECTORCONTROL,nato_allsectors);
        _EnemySectorsSelected = EGVAR(SECTORCONTROL,nato_sectors);
        _EnemyFlagsSelected = EGVAR(SECTORCONTROL,nato_flags);
    };
};

// Beam-Pads in Basis und Außenposten zur Liste der Beampunkte hinzufügen
private _points = [];
_points pushBack [position _Homebase, "Heimatbasis", "", 0];
_points pushBack [position _Outpost, "Außenposten", "", 0];

// V-Fahnen Positionen des gewählten Sektors zur Liste der Beampunkte hinzufügen
if (!EGVAR(SECTORCONTROL,flagStartNeutral)) then
{
    {
        private _sector = _x;
        {
            _points pushBack [_x, format ["Sektor %1 / Fahne %2", _sector, _forEachIndex + 1], format ["F%1.%2", _sector, _forEachIndex + 1], 1];
        } forEach ((EGVAR(SECTORCONTROL,AllSectors) select _x) select 1);  // Flaggen Positionen
    } forEach _OwnSectorsSelected;
};

// Beampositionen der eigenen Sektoren zur Liste der Beampunkte hinzufügen
{
    private _sector = _x;
    {
        _points pushBack [_x, format ["Sektor %1 / Beampunkt %2", _sector, _forEachIndex + 1], format ["BP%1.%2", _sector, _forEachIndex + 1], 2];
    } forEach ((EGVAR(SECTORCONTROL,AllSectors) select _x) select 2);  // Beam-Positionen
} forEach _OwnSectorsAll;

// Erlaubte Positionen filtern
private _beampoints = [];
{
    private _pos = _x select 0;
    private _level = _x select 3;
    private _denied = false;

    // Spieler schon vor Ort?
    if (_withoutPlayer && _pos distance2D vehicle player < GVAR(SearchRadiusBeam)) then {_denied = true};

    // Beampunkt zu nah an allen möglichen A-Fahnen? (Nur während der Waffenruhe)
    if (!_denied && EGVAR(GELDZEIT,GAMESTAGE) != GAMESTAGE_WAR && _level == 2) then
    {
        {
            {
                if (_pos distance2D _x < (GVAR(MinDistance) * 1000)) then {_denied = true};
            } forEach ((EGVAR(SECTORCONTROL,AllSectors) select _x) select 1);
        } forEach _EnemySectorsSelected;
    };

    // Punkt zu nah an aktiven Fahnen? (In der Schlacht)
    if (!_denied && EGVAR(GELDZEIT,GAMESTAGE) == GAMESTAGE_WAR && _level > 0) then
    {
        {
            if (_pos distance2D _x < (GVAR(MinDistance) * 1000)) then {_denied = true};
        } forEach (_OwnFlagsSelected + _EnemyFlagsSelected);
    };

    // Wenn OK dann übernehmen
    if (!_denied) then {_beampoints pushBack _x};
} forEach _points;

// Punkte zurückgeben
_beampoints;
