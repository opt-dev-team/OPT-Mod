/**
* Description:
* Init Tracker
*
* Author:
* form
*
* Arguments:
*
* Return Value:
*
* Server Only:
* No
*
* Global:
* No
*
* API:
* No
*
* Example:
* call FUNC(clientinit);
*/
#include "macros.hpp"
#define TRACKER_REFRESH 10

["missionStarted",
{
    // Tracker nach dem (re)joinen invalidieren
    GVAR(LAST_POSITION) = nil;

    // Tracker für Reisedistanz alle 'TRACKER_REFRESH' Sekunden ausführen
    [{
        call FUNC(tracker);
    }, TRACKER_REFRESH, _this] call CFUNC(addPerFrameHandler);

}] call CFUNC(addEventhandler);

["Respawn",
{
    // Tracker nach Respawn invalidieren
    GVAR(LAST_POSITION) = nil;
}] call CFUNC(addEventhandler);
