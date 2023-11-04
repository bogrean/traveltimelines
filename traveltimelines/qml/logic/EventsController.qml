import QtQuick

/*!
  \qmltype EventsController
  \brief Defines the actions that can be performed on trip events.

  Defines all actions that can be perfomed on trip events. Anyone wishing to implement those actions \
  must implement the specific handlers.
*/

Item {
    id: eventsController

    /*!
      \qmlsignal EventsController::createEvent(var newEvent)
      Use this signal for notifications about new trip events being created.

      \a newEvent contains the details of the new trip event
    */
    signal createEvent(var newEvent)
    /*!
      \qmlsignal EventsController::deleteEvent(int eventId)
      Use this signal for notifications about removal of an existing event.

      \a eventId specifies the vent to be deleted.
    */
    signal deleteEvent(int eventId)
    /*!
      \qmlsignal EventsController::editEvent(var existingEvent)
      Use this signal for notifications about changing the contents of a trip event

      \a existingEvent contains the complete trip event data, updated
    */
    signal editEvent(var existingEvent)

    /*!
      \qmlsignal EventsController::reloadEvents()
      Use this signal to request a fresh reload of the event data.
    */
    signal reloadEvents()


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
