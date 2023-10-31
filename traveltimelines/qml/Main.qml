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
        controller._createTrip("In search of the midnight sun", new Date(2015, 5, 27), new Date(2015, 6, 3))
        controller._createTrip("Roaming of the southern seas", new Date(2016, 8, 2), new Date(2016, 10, 30))
        controller._createTrip("Conquering the asian steppes", new Date(2018, 7, 6), new Date(2018, 8, 3))
        // add some default events
        eventsController._createEvent("bus",
                                      1,
                                      new Date(2015, 5, 27, 10, 30),
                                      new Date(2015, 5, 27, 13, 00),
                                      "Cluj-Napoca",
                                      "Tg-Mures",
                                      "onTheSpot",
                                      15,
                                      "estimated",
                                      "ROCADA",
                                      "")
        eventsController._createEvent("bus",
                                      1,
                                      new Date(2015, 5, 27, 17, 30),
                                      new Date(2015, 5, 28, 1, 00),
                                      "Tg-Mures",
                                      "OTP",
                                      "reserved",
                                      50,
                                      "payed",
                                      "FANY",
                                      "")
        eventsController._createEvent("plane",
                                      1,
                                      new Date(2015, 5, 28, 4, 30),
                                      new Date(2015, 5, 28, 6, 30),
                                      "OTP",
                                      "RIG",
                                      "reserved",
                                      500,
                                      "payed",
                                      "AirBaltic",
                                      "")
        eventsController._createEvent("bus",
                                      1,
                                      new Date(2015, 5, 28, 10, 30),
                                      new Date(2015, 5, 28, 16, 30),
                                      "Riga",
                                      "Talinn",
                                      "reserved",
                                      150,
                                      "payed",
                                      "BusLine",
                                      "")
        eventsController._createEvent("accommodation",
                                      1,
                                      new Date(2015, 5, 28),
                                      new Date(2015, 5, 29),
                                      "Talinn",
                                      null,
                                      "todo",
                                      150,
                                      "estimated",
                                      "booking.com",
                                      "")
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
        id: eventsOverviewPage
        EventsOverviewPage {
            id: eventsOverviewPageContents
            tripEvents: dataModel.tripEvents
            selectedTripId: dataModel.selectedTripId
            dispatcher: eventsController
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
