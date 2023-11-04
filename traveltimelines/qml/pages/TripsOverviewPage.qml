import QtQuick
import Felgo

import "../logic"

/*!
  \qmltype TripsOverviewPage
  \brief Page displaying the user defined trips.

  This is an application page that displays & edits the trips.

  Trips are displayed using an \l TripOverview

  New trips can be added
*/

AppPage {
    id: thisPage

    /*!
      \qmlproperty var TripsOverviewPage::myTrips

      An array containing the trip objects
    */
    required property var myTrips
    /*!
      \qmlproperty TripsController TripsOverviewPage::dispatcher

      The \l TripsController instance that's used to send notifications about trips
    */
    required property TripsController dispatcher
    /*!
      \qmlproperty Component TripsOverviewPage::tripDetailsPage

      Component that will be used to edit the data of a trip
    */
    required property Component tripDetailsPage

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
}
