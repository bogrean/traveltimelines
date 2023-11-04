import QtQuick
import Felgo

import "../logic"

/*!
  \qmltype EventsOverviewPage
  \brief Page displaying the events of a selected trip.

  This is an application page that displays & edits the events of a trip.

  Events are displayed using an \l EventOverview

  New events can be added
*/

AppPage {
    id: thisPage
    /*!
      \qmlproperty var EventsOverviewPage::tripEvents

      An array containing the events objects associated with the selected trip
    */
    property var tripEvents: []

    /*!
      \qmlproperty int EventsOverviewPage::selectedTripId

      The id of the trip for which we are displaying the events
    */
    property int selectedTripId: -1

    /*!
      \qmlproperty string EventsOverviewPage::selectedTripName

      The name of the trip for which we are displaying the events
    */
    property string selectedTripName

    /*!
      \qmlproperty EventsController EventsOverviewPage::dispatcher

      The \l EventsController instance that's used to send notifications about events
    */
    required property EventsController dispatcher

    /*!
      \qmlproperty Component EventsController::editEventPage

      Component that will be used to edit the data of an event
    */
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
            onDeleteRequested: {
                dispatcher.deleteEvent(eventId)
            }
        }
    }
}
