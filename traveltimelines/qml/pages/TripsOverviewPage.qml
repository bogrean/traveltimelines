import QtQuick
import Felgo

import "../logic"

AppPage {
    id: thisPage

    required property var myTrips
    required property TripsController dispatcher

    title: qsTr("My Trips")

    rightBarItem: NavigationBarRow {
        IconButtonBarItem {
            iconType: IconType.plus
            showItem: showItemAlways
            color: "white"
            onClicked: {
                thisPage.navigationStack.popAllExceptFirstAndPush(tripDetailsPage, {state: "addNew", trip: null})
            }
        }
    }

    JsonListModel {
        id: myTrips
        source: thisPage.myTrips
        keyField: "tripId"
        fields: ["tripId", "title", "start", "end"]
    }

    AppListView {
        id: tripsView
        anchors.fill: parent
        model: myTrips
        spacing: 10
        delegate: TripOverview {
            id: tripDelegate
            width: tripsView.width
            height: childrenRect.height
            onClicked: {
                var trip = {
                    tripId: tripDelegate.tripId,
                    title: tripDelegate.title,
                    start: tripDelegate.start,
                    end: tripDelegate.end
                }
                thisPage.navigationStack.popAllExceptFirstAndPush(tripDetailsPage, {state: "editExisting", trip: trip})
            }
            onDeleteRequested: {
                dispatcher.deleteTrip(tripId)
            }
        }
    }


    Component {
        id: tripDetailsPage
        AddTripPage {
            dispatcher: thisPage.dispatcher
        }
    }
}
