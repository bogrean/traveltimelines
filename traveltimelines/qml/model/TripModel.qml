import QtQuick
import Felgo

Item {
    id: tripModel

    property alias dispatcher: tripsControllerConnections.target
    readonly property alias trips: _data.trips

    Connections {
        id: tripsControllerConnections

        onCreateTrip: newTrip => {
            newTrip.id = _data.trips.length + 1
            _data.trips.push(newTrip)
            console.log("Trip created: " + newTrip)
            tripsChanged()
        }
        onDeleteTrip: id => {
            console.log("DeletingTrip: " + id)
        }
    }


    Item {
        id: _data
        property var trips: []
    }
}
