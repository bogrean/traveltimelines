import Felgo
import QtQuick

import "logic"
import "model"
import "pages"

App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    Component.onCompleted: {
        controller.reloadTrips()
        eventsController.reloadEvents()
    }

    TripsController {
        id: controller
    }
    EventsController {
        id: eventsController
    }
    TripModel {
        id: dataModel
        dispatcher: controller
        eventsDispatcher: eventsController
    }
    Component {
        id: eventDetailsPage
        EditEventPage {
            dispatcher: eventsController
            tripId: dataModel.selectedTripId

        }
    }
    Component {
        id: eventsOverviewPage
        EventsOverviewPage {
            id: eventsOverviewPageContents
            tripEvents: dataModel.tripEvents
            selectedTripId: dataModel.selectedTripId
            dispatcher: eventsController
            editEventPage: eventDetailsPage
        }
    }
    Component {
        id: tripDetailsPage
        AddTripPage {
            dispatcher: controller
            tripEventsPage: eventsOverviewPage
        }
    }
    NavigationStack {

        TripsOverviewPage {
            myTrips: dataModel.trips
            dispatcher: controller
            tripDetailsPage: tripDetailsPage
        }
    }
}
