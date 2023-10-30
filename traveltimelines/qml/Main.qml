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
    }

    TripsController {
        id: controller
    }
    TripModel {
        id: dataModel
        dispatcher: controller
    }

    NavigationStack {

        TripsOverviewPage {
            myTrips: dataModel.trips
            dispatcher: controller
        }

    }
}
