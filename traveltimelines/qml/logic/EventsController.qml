import QtQuick

Item {
    id: eventsController

    signal createEvent(var newEvent)
    signal deleteEvent(int eventId)
    signal editEvent(var existingEvent)


    function _createEvent(type, tripId, startDate, endDate, startLocation, endLocation, status, cost, costStatus, operator, comments) {
        var newEvent = {
            type: type,
            tripId: tripId,
            status: status,
            startDate: startDate,
            startLocation: startLocation,
            cost: cost,
            costStatus: costStatus,
            operator: operator,
            comments: comments
        }
        if (endDate) {
            newEvent.endDate = endDate
        }
        if (endLocation) {
            newEvent.endLocation = endLocation
        }
        createEvent(newEvent)
    }
}
