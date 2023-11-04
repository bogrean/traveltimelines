import QtQuick

/*!
  \qmltype TrisController
  \brief Defines the actions that can be performed on trips.

  Defines all actions that can be perfomed on trips. Anyone wishing to implement those actions \
  must implement the specific handlers.
*/

Item {
    id: tripsController
    /*!
      \qmlsignal TripsController::createTrip(var newTrip)
      Use this signal for notifications about new trips being created.

      \a newTrip contains the details of the new trip
    */
    signal createTrip(var newTrip)
    /*!
      \qmlsignal TripsController::deleteTrip(int tripId)
      Use this signal for notifications about removal of an existing trip.

      \a tripId specifies the trip to be deleted.
    */
    signal deleteTrip(int tripId)
    /*!
      \qmlsignal TripsController::editTrip(var existingTrip)
      Use this signal for notifications about changing the contents of a trip

      \a existingTrip contains the complete trip data, updated
    */
    signal editTrip(var existingTrip)
    /*!
      \qmlsignal TripsController::fetchTripData(int tripId)
      Use this signal to request a fresh reload of the events for the trip identified by \a tripId
    */
    signal fetchTripData(int tripId)
    /*!
      \qmlsignal TripsController::reloadTrips()
      Use this signal to request a fresh reload of the trip data.
    */
    signal reloadTrips()


    function _createTrip(title, startDate, endDate) {
        var newTrip = {
            title: title,
            start: startDate,
            end: endDate
        }
        createTrip(newTrip)
    }
}
