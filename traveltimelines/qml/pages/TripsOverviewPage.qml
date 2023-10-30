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
                thisPage.navigationStack.popAllExceptFirstAndPush(addTripPage)
            }
        }
    }

    JsonListModel {
        id: myTrips
        source: thisPage.myTrips
        keyField: "id"
        fields: ["id", "title", "start", "end"]
    }

    AppListView {
        id: tripsView
        anchors.fill: parent
        model: myTrips
        spacing: 10
        delegate: TripOverview {
            width: parent.width
            height: childrenRect.height
        }
    }


    Component {
        id: addTripPage
        AddTripPage {
            dispatcher: thisPage.dispatcher
        }
    }
}
