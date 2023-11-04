import QtQuick
import Felgo
import QtQuick.Layouts
import QtQuick.Controls

import "../logic"
import "../dialogs"

/*!
  \qmltype EditEventPage
  \brief Application page to edit trip event data.

  A basic application page that allows the user to edit event data:
  \list
  \li Event type
  \li Event start date & time
  \li Event start location
  \li Event end date & time
  \li Event end location
  \li Event status
  \li Event cost
  \li Whether the event was paid or not
  \li operator of the event
  \li User comments
  \endlist
*/

AppPage {
    id: thisPage
    /*!
      \qmlproperty EventsController EditEventPage::dispatcher

      The dispatcher used to send notifications regarding events
    */
    required property EventsController dispatcher
    /*!
      \qmlproperty var EditEventPage::tripEvent

      An object containing the event data
    */
    property var tripEvent: null
    /*!
      \qmlproperty int EditEventPage::tripId

      The id of the trip the tripEvent belongs to
    */
    property int tripId: -1

    states: [
        State {
            name: "addNew"
            PropertyChanges {
                target: thisPage
                title: qsTr("Add trip event")
            }
            PropertyChanges {
                target: saveBtn
                text: qsTr("Create")

            }
        },
        State {
            name: "editExisting"
            PropertyChanges {
                target: thisPage
                title: qsTr("Edit trip event")
            }
            PropertyChanges {
                target: saveBtn
                text: qsTr("Save")

            }
        }
    ]

    state: "addNew"

    AppFlickable {
        anchors.fill: parent
        contentHeight: pageContent.height

        Column {
            id: pageContent
            width: thisPage.width
            spacing: dp(10)

            TextFieldRow {
                id: eventType
                label: qsTr("Event type: ")
                clickEnabled: true
                value: tripEvent ? tripEvent.type : "plane"
                onClicked: {
                    selectEventType.setSelection(value)
                    selectEventType.open()
                }
            }

            DateField {
                id: startDate
                width: parent.width
                allowEditing: true
                label: qsTr("Start on: ")
                selectedDate: tripEvent ? tripEvent.startDate : new Date()
                pickerDialog: datePickerDialog
            }
            TimeField {
                id: startTime
                width: thisPage.width
                allowEditing: true
                label: qsTr("Start at: ")
                selectedDate: tripEvent ? tripEvent.startDate : new Date()
                pickerDialog: timePickerDialog
            }
            TextFieldRow {
                id: startLocation
                width: thisPage.width
                label: qsTr("Start in: ")
                placeHolder: qsTr("Enter event start location")
                value: tripEvent && tripEvent.startLocation ? tripEvent.startLocation : ""
            }
            DateField {
                id: endDate
                width: parent.width
                allowEditing: true
                label: qsTr("End on: ")
                selectedDate: tripEvent ? tripEvent.endDate : new Date()
                pickerDialog: datePickerDialog
            }

            TimeField {
                id: endTime
                width: thisPage.width
                allowEditing: true
                label: qsTr("End at: ")
                selectedDate: tripEvent ? tripEvent.endDate : new Date()
                pickerDialog: timePickerDialog
            }
            TextFieldRow {
                id: endLocation
                width: thisPage.width
                label: qsTr("End in: ")
                placeHolder: qsTr("Enter event end location")
                value: tripEvent && tripEvent.endLocation ? tripEvent.endLocation  : ""
            }

            TextFieldRow {
                id: eventStatus
                label: qsTr("Event status: ")
                clickEnabled: true
                value: tripEvent ? tripEvent.status : "todo"
                onClicked: {
                    selectEventStatus.setSelection(value)
                    selectEventStatus.open()
                }
            }
            TextFieldRow {
                id: cost
                width: thisPage.width
                label: qsTr("Event cost: ")
                placeHolder: qsTr("Enter event cost")
                textFieldItem.inputMask: "00000 RO\\N"
                value: tripEvent ? tripEvent.cost + " RON" : "0 RON"
            }
            TextFieldRow {
                id: costStatus
                label: qsTr("Payment: ")
                clickEnabled: true
                value: tripEvent ? tripEvent.costStatus : "todo"
                onClicked: {
                    selectPaidStatus.setSelection(value)
                    selectPaidStatus.open()
                }
            }
            TextFieldRow {
                id: operator
                width: thisPage.width
                label: qsTr("Event operator: ")
                placeHolder: qsTr("Enter event operator")
                value: tripEvent ? tripEvent.operator : ""
            }

            TextFieldRow {
                id: comments
                width: thisPage.width
                label: qsTr("Observations: ")
                placeHolder: qsTr("Add any observations for this event")
                value: tripEvent ? tripEvent.comments : ""
            }

            AppButton {
                id: saveBtn
                text: qsTr("Create event")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    var eventStartDate = new Date(startDate.selectedDate.getFullYear(),
                                                  startDate.selectedDate.getMonth(),
                                                  startDate.selectedDate.getDate(),
                                                  startTime.selectedDate.getHours(),
                                                  startTime.selectedDate.getMinutes(),
                                                  startTime.selectedDate.getSeconds())
                    var eventEndDate = new Date(endDate.selectedDate.getFullYear(),
                                                  endDate.selectedDate.getMonth(),
                                                  endDate.selectedDate.getDate(),
                                                  endTime.selectedDate.getHours(),
                                                  endTime.selectedDate.getMinutes(),
                                                  endTime.selectedDate.getSeconds())
                    console.log(">>>>>> Saving event")
                    console.log("   Type: ", eventType.value)
                    console.log("   TripId: ",tripId)
                    console.log("   Start date: ", eventStartDate)
                    console.log("   End date: ", eventEndDate)
                    console.log("   Start location: ", startLocation.value)
                    console.log("   End location: ", endLocation.value)
                    console.log("   Status: : ", eventStatus.value)
                    console.log("   Cost: : ", parseInt(cost.value))
                    console.log("   Cost status: ", costStatus.value)
                    console.log("   Operator: ", operator.value)
                    console.log("   Comments: ", comments.value)
                    if (thisPage.state === "addNew") {
                        dispatcher._createEvent(eventType.value,
                                                tripId,
                                                eventStartDate,
                                                eventEndDate,
                                                startLocation.value,
                                                endLocation.value,
                                                eventStatus.value,
                                                parseInt(cost.value),
                                                costStatus.value,
                                                operator.value,
                                                comments.value)
                        thisPage.navigationStack.pop()
                    } else if (thisPage.state === "editExisting"){
                        tripEvent.type = eventType.value
                        tripEvent.startDate = eventStartDate
                        tripEvent.endDate = eventEndDate
                        tripEvent.startLocation = startLocation.value
                        tripEvent.endLocation = endLocation.value
                        tripEvent.status = eventStatus.value
                        tripEvent.cost = parseInt(cost.value)
                        tripEvent.costStatus = costStatus.value
                        tripEvent.operator = operator.value
                        tripEvent.comments = comments.value
                        tripEventChanged()
                        dispatcher.editEvent(tripEvent)
                    }
                }
            }
        }
    }
    EventTypePicker {
        id: selectEventType
        onAccepted: {
            eventType.value = selectEventType.selectedOption
            close()
        }
    }
    EventStatusPicker {
        id: selectEventStatus
        onAccepted: {
            eventStatus.value = selectEventStatus.selectedOption
            close()
        }
    }
    PaidStatusPIcker {
        id: selectPaidStatus
        onAccepted: {
            costStatus.value = selectPaidStatus.selectedOption
            close()
        }
    }
    DatePickerDialog {
        id: datePickerDialog
    }
    TimePickerDialog {
        id: timePickerDialog
    }
}
