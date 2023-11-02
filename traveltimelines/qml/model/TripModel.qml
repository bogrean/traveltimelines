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
    function saveTrips() {
        storage.setValue("trips", _data.trips)
        storage.setValue("nextTripIndex", _data.nextId)
    }
    function saveEvents() {
        storage.setValue("events", _data.events)
        storage.setValue("nextEventIndex", _data.nextEventId)
    }
    function updateTripAfterEventChange(event) {
        var tripIndex = _data.getTripIndex(event.tripId)
        if (tripIndex >= 0) {
            if (event.startDate < trips[tripIndex].start) {
                trips[tripIndex].start.setFullYear(event.startDate.getFullYear())
                trips[tripIndex].start.setMonth(event.startDate.getMonth())
                trips[tripIndex].start.setDate(event.startDate.getDate())
            }
            if (event.endDate > trips[tripIndex].end) {
                trips[tripIndex].end.setFullYear(event.endDate.getFullYear())
                trips[tripIndex].end.setMonth(event.endDate.getMonth())
                trips[tripIndex].end.setDate(event.endDate.getDate())
            }
        }
    }

    Connections {
        id: tripsControllerConnections
        target: dispatcher

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
                saveTrips()
                saveEvents()
                tripsChanged()
        }
        onEditTrip: existingTrip => {
            var existingIndex = _data.getTripIndex(existingTrip.tripId)
            if (existingIndex >= 0) {
                _data.trips[existingIndex].title = existingTrip.title
                _data.trips[existingIndex].start = existingTrip.start
                _data.trips[existingIndex].end = existingTrip.end
                sortTrips()
                saveEvents()
                tripsChanged()
                updateSelectedTripEvents(existingTrip.tripId)
            }
        }
        onFetchTripData: tripId => {
            updateSelectedTripEvents(tripId)
        }
        onReloadTrips: {
            var storedTrips = storage.getValue("trips")
            var nextTripIndex = storage.getValue("nextTripIndex")
            if (storedTrips) {
                _data.trips = storedTrips
            }
            _data.nextId = nextTripIndex ? nextTripIndex : _data.trips.length
            sortTrips()
            tripsChanged()
        }
    }

    Connections {
        id: eventsControllerConnections
        target: eventsDispatcher

        onCreateEvent: newEvent => {
            newEvent.eventId = _data.nextEventId
            _data.nextEventId++
            _data.events.push(newEvent)
            if (newEvent.tripId === selectedTripId) {
                updateSelectedTripEvents(selectedTripId)
            }
            updateTripAfterEventChange(newEvent)
            saveTrips()
            saveEvents()
            tripsChanged()
        }

        onDeleteEvent: eventId => {
            _data.removeEvent(eventId)
            updateSelectedTripEvents(selectedTripId)
            saveEvents()
        }
        onEditEvent: existingEvent => {
            var existingIndex = _data.getEventIndex(existingEvent.eventId)
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
                updateTripAfterEventChange(existingEvent)
                saveEvents()
                saveTrips()
                tripsChanged()
            }
        }
        onReloadEvents: {
            var storedEvents = storage.getValue("events")
            var nextEventIndex = storage.getValue("nextEventIndex")
            if (storedEvents) {
                _data.events = storedEvents
            }
            _data.nextEventId = nextEventIndex ? nextEventIndex : _data.events.length
            updateSelectedTripEvents(selectedTripId)
        }
    }

    Storage {
        id: storage
        databaseName: "traveltimelines"
    }


    Item {
        id: _data
        property int nextId: 1
        property var trips: []
        property var events: []
        property int nextEventId: 1

        function getTripIndex(tripId) {
            var existingIndex = -1
            const findIndex = (trip, index) => {
                            if (trip && trip.tripId === tripId) {
                                existingIndex = index
                                return true
                            }
                            return false
                        }
            trips.some(findIndex)
            return existingIndex
        }
        function getEventIndex(eventId) {
            var existingIndex = -1
            const findIndex = (event, index) => {
                            if (event && event.eventId === eventId) {
                                existingIndex = index
                                return true
                            }
                            return false
                        }
            events.some(findIndex)
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
