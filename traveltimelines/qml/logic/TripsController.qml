import QtQuick

Item {
    id: tripsController

    signal createTrip(var newTrip)
    signal deleteTrip(int id)
    signal editTrip(var existingTrip)


    function _createTrip(title, startDate, endDate) {
        var newTrip = {
            title: title,
            start: startDate,
            end: endDate
        }
        createTrip(newTrip)
    }
}
