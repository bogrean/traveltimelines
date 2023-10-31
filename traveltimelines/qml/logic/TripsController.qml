import QtQuick

Item {
    id: tripsController

    signal createTrip(var newTrip)
    signal deleteTrip(int tripId)
    signal editTrip(var existingTrip)
    signal fetchTripData(int tripId)


    function _createTrip(title, startDate, endDate) {
        var newTrip = {
            title: title,
            start: startDate,
            end: endDate
        }
        createTrip(newTrip)
    }
}
