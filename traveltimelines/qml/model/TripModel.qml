import QtQuick
import Felgo

Item {
    id: tripModel

    property alias dispatcher: tripsControllerConnections.target
    readonly property alias trips: _data.trips

    property alias eventsDispatcher: eventsControllerConnections.target
    readonly property var tripEvents: []
    property int selectedTripId: -1

    Connections {
        id: tripsControllerConnections

        onCreateTrip: newTrip => {
            newTrip.tripId = _data.nextId
            _data.nextId++
            _data.trips.push(newTrip)
            tripsChanged()
        }
        onDeleteTrip: tripId => {
                _data.removeTrip(tripId)
                tripsChanged()
        }
        onEditTrip: existingTrip => {
            var existingIndex = _data.getIndex(existingTrip.tripId)
            if (existingIndex >= 0) {
                _data.trips[existingIndex].title = existingTrip.title
                _data.trips[existingIndex].start = existingTrip.start
                _data.trips[existingIndex].end = existingTrip.end
                tripsChanged()
            }
        }
    }

    Connections {
        id: eventsControllerConnections

        onCreateEvent: newEvent => {
            console.log("New event: ", newEvent.type, " from ", newEvent.startLocation, " to ", newEvent.endLocation, " on ", newEvent.startDate)
            newEvent.eventId = _data.nextEventId
            _data.nextEventId++
            _data.events.push(newEvent)
            if (newEvent.tripId === selectedTripId) {
               const filterPredicate = (event) => {
                             return event && event.tripId === selectedTripId}
               tripEvents = _data.events.filter(filterPredicate)
            }
        }

        onDeleteEvent: eventId => {}
        onEditEvent: existingEvent => {}
    }


    Item {
        id: _data
        property int nextId: 1
        property var trips: []
        property var events: []
        property int nextEventId: 1

        function getIndex(tripId) {
            var existingIndex = -1
            const findIndex = (trip, index) => {
                            if (trip && trip.tripId === tripId) {
                                existingIndex = index
                                return true
                            }
                            return false
                        }
            _data.trips.some(findIndex)
            return existingIndex
        }

        function removeTrip(tripId) {
            const filterPredicate = (trip) => {
                          return !trip || trip.tripId !== tripId}
            _data.trips = _data.trips.filter(filterPredicate)
        }
    }
}
