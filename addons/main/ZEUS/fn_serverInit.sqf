/**
* Author: Fank
* Registers Zeus for clients
*
* Arguments:
* None
*
* Return Value:
* None
*
*/
#include "macros.hpp"

if (!OPT_SECTORCONTROL_trainingon) exitWith {};

[ZEUS_SWAP_EVENT, {
    _this select 0 params["_unit", "_corpse"];

    private _curator;

    if (!isNull _corpse) then {
        {
            private _assignedUnit = getAssignedCuratorUnit _x;
            unassignCurator _x;
            if (_corpse == _assignedUnit || isNull _assignedUnit) exitWith {
                _curator = _x;
            };
        } forEach allCurators;
    };

    if (isNull _curator) then {
        private _group = createGroup sideLogic;
        _curator = _group createUnit ["ModuleCurator_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
        _curator setVariable ["addons", 3, true];
        _curator setVariable ["bis_fnc_initModules_activate", false, true];
    };
    _curator addCuratorEditableObjects [allMissionObjects "", true];
    _unit assignCurator _curator;

    "Zeusmodus verfügbar." remoteExec ["systemChat", _unit];
}] call CFUNC(addEventHandler);
