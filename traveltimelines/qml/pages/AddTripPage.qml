import QtQuick
import QtQuick.Layouts
import Felgo

import "../logic"
import "../dialogs"

/*!
  \qmltype AddTripPage
  \brief Application page to edit trip data.

  A basic application that allows the user to edit trip data:
  \list
  \li Trip title
  \li Trip start date
  \li Trip end date
  \li Trip events
  \endlist
*/

AppPage {
    id: thisPage
    /*!
      \qmlproperty TripsController dispatcher

      The dispatcher used to send notifications regarding trips
    */
    required property TripsController dispatcher

    /*!
      \qmlproperty Component tripEventsPage

      The component that will displayed for editing trip events data
    */
    property Component tripEventsPage
    /*!
      \qmlproperty var trip

      An object containing the trip data
    */
    property var trip: null

    //! [states]
    states: [
        State {
            name: "addNew"
            PropertyChanges {
                target: saveTripBtn
                text: qsTr("Create trip")
                enabled: tripTitle.text.length
            }
            PropertyChanges {
                target: addEventsBtn
                visible: false
            }
            PropertyChanges {
                target: tripTitle
                text: ""
            }
            PropertyChanges {
                target: startDate
                selectedDate: new Date()
            }
            PropertyChanges {
                target: endDate
                selectedDate: new Date()
            }
            PropertyChanges {
                target: thisPage
                title: qsTr("Add trip")
            }
        },
        State {
            name: "editExisting"
            PropertyChanges {
                target: saveTripBtn
                text: qsTr("Save trip")
                enabled: trip && (trip.title !== tripTitle.text ||
                                  trip.start.getTime() !== startDate.selectedDate.getTime() ||
                                  trip.end.getTime() !== endDate.selectedDate.getTime())
            }
            PropertyChanges {
                target: addEventsBtn
                visible: true
            }
            PropertyChanges {
                target: tripTitle
                text: trip ? trip.title : ""
            }
            PropertyChanges {
                target: startDate
                selectedDate: trip ? trip.start : new Date()
            }
            PropertyChanges {
                target: endDate
                selectedDate: trip ? trip.end : new Date()
            }
            PropertyChanges {
                target: thisPage
                title: qsTr("Update trip")
            }
        }
    ]
    //! [states]
    state: "addNew"

    title: qsTr("Add trip")

    //! [contents]
    AppFlickable{
        anchors.fill: parent
        contentHeight: pageContent.height

        Column {
            id: pageContent
            width: thisPage.width
            spacing: dp(10)
            AppTextField {
                id: tripTitle
                width: parent.width
                padding: dp(10)
                placeholderText: qsTr("Enter your trip name")

            }
            DateField {
                id: startDate
                width: parent.width
                allowEditing: true
                label: qsTr("Start date: ")
                pickerDialog: datePicker
                state: "showDate"
            }
            DateField {
                id: endDate
                width: parent.width
                allowEditing: true
                label: qsTr("End date: ")
                pickerDialog: datePicker
                state: "showDate"
            }

            RowLayout{
                spacing: dp(10)
                width: thisPage.width

                AppButton {
                    id: addEventsBtn
                    text: qsTr("Edit events")
                    Layout.alignment: Qt.AlignCenter
                    onClicked: {
                        dispatcher.fetchTripData(thisPage.trip ? thisPage.trip.tripId : -1)
                        thisPage.navigationStack.push(tripEventsPage, {selectedTripName: thisPage.trip ? thisPage.trip.title : ""})
                    }
                }
                AppButton {
                    id: saveTripBtn
                    text: qsTr("Create trip")
                    Layout.alignment: Qt.AlignCenter
                    enabled: tripTitle.text.length
                    onClicked: {
                        if (thisPage.state === "addNew") {
                            dispatcher._createTrip(tripTitle.text, startDate.selectedDate, endDate.selectedDate)
                            thisPage.navigationStack.popAllExceptFirst()
                        } else if (thisPage.state === "editExisting") {
                            trip.title = tripTitle.text
                            trip.start = startDate.selectedDate
                            trip.end = endDate.selectedDate
                            tripChanged()
                            dispatcher.editTrip(trip)
                        }
                    }
                }
            }
        }
        //! [contents]
        DatePickerDialog {
            id: datePicker
            state: "datePicker"
        }
    }
}
