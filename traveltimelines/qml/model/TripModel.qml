import QtQuick
import Felgo

Item {
    id: tripModel

    property alias dispatcher: tripsControllerConnections.target
    readonly property alias trips: _data.trips

    Connections {
        id: tripsControllerConnections

        onCreateTrip: newTrip => {
            newTrip.tripId = _data.trips.length + 1
            _data.trips.push(newTrip)
            tripsChanged()
        }
        onDeleteTrip: id => {
            console.log("DeletingTrip: " + id)
        }
        onEditTrip: existingTrip => {
            var existingIndex = -1
            const getIndex = (trip, index) => {
                            if (trip.tripId === existingTrip.tripId) {
                                existingIndex = index
                                return true
                            }
                            return false
                        }
            _data.trips.some(getIndex)
            if (existingIndex >= 0) {
                _data.trips[existingIndex].title = existingTrip.title
                _data.trips[existingIndex].start = existingTrip.start
                _data.trips[existingIndex].end = existingTrip.end
                tripsChanged()
            }
        }
    }


    Item {
        id: _data
        property var trips: []
    }
}
