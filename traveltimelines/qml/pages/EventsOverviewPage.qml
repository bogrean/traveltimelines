import QtQuick
import Felgo

import "../logic"

AppPage {
    id: thisPage
    property var tripEvents: []
    property int selectedTripId: -1
    property string selectedTripName
    required property EventsController dispatcher
    required property Component editEventPage

    title: qsTr("Trip events: %1").arg(selectedTripName)

    rightBarItem: NavigationBarRow {
        IconButtonBarItem {
            iconType: IconType.plus
            showItem: showItemAlways
            color: "white"
            onClicked: {
                thisPage.navigationStack.push(editEventPage, {state: "addNew", tripEvent: null})
            }
        }
    }

    JsonListModel {
        id: events
        source: thisPage.tripEvents
        keyField: "eventId"
        fields: ["eventId", "type", "tripId", "status", "startDate", "endDate", "startLocation", "endLocation", "cost", "costStatus", "operator", "comments"]
    }

    AppListView {
        id: eventsView
        anchors.fill: parent
        model: events
        spacing: 10
        delegate: EventOverview {
            id: eventDelegate
            width: eventsView.width
            height: childrenRect.height
            onClicked: {
                var existingEvent = thisPage.tripEvents[index]
                thisPage.navigationStack.push(editEventPage, {state: "editExisting", tripEvent: existingEvent})
            }
        }
    }
}
