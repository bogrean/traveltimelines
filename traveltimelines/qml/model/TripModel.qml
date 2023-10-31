import QtQuick
import Felgo

Item {
    id: tripModel

    property alias dispatcher: tripsControllerConnections.target
    readonly property alias trips: _data.trips

    property alias eventsDispatcher: eventsControllerConnections.target
    property var tripEvents: []
    property int selectedTripId: -1

    function updateSelectedTripEvents(tripId) {
        selectedTripId = tripId
        const filterPredicate = (event) => {
                      return event && event.tripId === selectedTripId}
        tripEvents = _data.events.filter(filterPredicate)

        const comparator = (a, b) => {
            if (a.startDate < b.startDate) {
                return -1
            }
            if (a.startDate > b.startDate) {
                return 1
            }
            if (a.endDate < b.endDate) {
                return -1
            }
            if (a.endDate > b.endDate) {
                return 1
            }
            return 0
        }
        tripEvents.sort(comparator)

        tripEventsChanged()
    }
    function sortTrips() {
        const comparator = (a, b) => {
            if (a.start < b.start) {
                return -1
            }
            if (a.start > b.start) {
                return 1
            }
            if (a.end < b.end) {
                return -1
            }
            if (a.end > b.end) {
                return 1
            }
            return 0
        }
        trips.sort(comparator)
    }

    Connections {
        id: tripsControllerConnections



        onCreateTrip: newTrip => {
            newTrip.tripId = _data.nextId
            _data.nextId++
            _data.trips.push(newTrip)
            sortTrips()
            tripsChanged()
        }
        onDeleteTrip: tripId => {
                _data.removeTrip(tripId)
                _data.removeTripEvents(tripId)
                updateSelectedTripEvents(selectedTripId)
                tripsChanged()
        }
        onEditTrip: existingTrip => {
            var existingIndex = _data.getIndex(existingTrip.tripId, _data.trips)
            if (existingIndex >= 0) {
                _data.trips[existingIndex].title = existingTrip.title
                _data.trips[existingIndex].start = existingTrip.start
                _data.trips[existingIndex].end = existingTrip.end
                sortTrips()
                tripsChanged()
                updateSelectedTripEvents(existingTrip.tripId)
            }
        }
        onFetchTripData: tripId => {
            updateSelectedTripEvents(tripId)
        }
    }

    Connections {
        id: eventsControllerConnections

        onCreateEvent: newEvent => {
            newEvent.eventId = _data.nextEventId
            _data.nextEventId++
            _data.events.push(newEvent)
            if (newEvent.tripId === selectedTripId) {
                updateSelectedTripEvents(selectedTripId)
            }
            // update trip start and end date
            var tripIndex = _data.getIndex(newEvent.tripId, _data.trips)
            if (tripIndex >= 0) {
                if (newEvent.startDate < trips[tripIndex].start) {
                    trips[tripIndex].start.setFullYear(newEvent.startDate.getFullYear())
                    trips[tripIndex].start.setMonth(newEvent.startDate.getMonth())
                    trips[tripIndex].start.setDate(newEvent.startDate.getDate())
                }
                if (newEvent.endDate > trips[tripIndex].end) {
                    trips[tripIndex].end.setFullYear(newEvent.endDate.getFullYear())
                    trips[tripIndex].end.setMonth(newEvent.endDate.getMonth())
                    trips[tripIndex].end.setDate(newEvent.endDate.getDate())
                }
                sortTrips()
                tripsChanged()
            }
        }

        onDeleteEvent: eventId => {
            _data.removeEvent(eventId)
            updateSelectedTripEvents(selectedTripId)
        }
        onEditEvent: existingEvent => {
            var existingIndex = _data.getIndex(existingEvent.eventId, _data.events)
            if (existingIndex >= 0) {
                _data.events[existingIndex].type = existingEvent.type
                _data.events[existingIndex].startDate = existingEvent.startDate
                _data.events[existingIndex].endDate = existingEvent.endDate
                _data.events[existingIndex].startLocation = existingEvent.startLocation
                _data.events[existingIndex].endLocation = existingEvent.endLocation
                _data.events[existingIndex].status = existingEvent.status
                _data.events[existingIndex].cost = existingEvent.cost
                _data.events[existingIndex].costStatus = existingEvent.costStatus
                _data.events[existingIndex].operator = existingEvent.operator
                _data.events[existingIndex].comments = existingEvent.comments
                updateSelectedTripEvents(selectedTripId)
            }
        }
    }


    Item {
        id: _data
        property int nextId: 1
        property var trips: []
        property var events: []
        property int nextEventId: 1

        function getIndex(tripId, arr) {
            var existingIndex = -1
            const findIndex = (trip, index) => {
                            if (trip && trip.tripId === tripId) {
                                existingIndex = index
                                return true
                            }
                            return false
                        }
            arr.some(findIndex)
            return existingIndex
        }

        function removeTrip(tripId) {
            const filterPredicate = (trip) => {
                          return !trip || trip.tripId !== tripId}
            _data.trips = _data.trips.filter(filterPredicate)
        }

        function removeEvent(eventId) {
            const filterPredicate = (event) => {
                          return !event || event.eventId !== eventId}
            _data.events = _data.events.filter(filterPredicate)
        }

        function removeTripEvents(tripId) {
            const filterPredicate = (event) => {
                          return !event || event.tripId !== tripId}
            _data.events = _data.events.filter(filterPredicate)
        }
    }
}
