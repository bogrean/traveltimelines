import QtQuick
import Felgo
import QtQuick.Layouts
import QtQuick.Controls

import "../logic"
import "../dialogs"

AppPage {
    id: thisPage
    required property EventsController dispatcher
    property var tripEvent: null
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
            }
            TextFieldRow {
                id: startTime
                width: thisPage.width
                label: qsTr("Start at: ")
                placeHolder: qsTr("18:00")
                textFieldItem.inputMask: "00:00"
                value: tripEvent ? "%1:%2".arg(tripEvent.startDate.getHours()).arg(tripEvent.startDate.getMinutes()) : "00:00"
            }
            TextFieldRow {
                id: startLocation
                width: thisPage.width
                label: qsTr("Start in: ")
                placeHolder: qsTr("Enter event start location")
                value: tripEvent ? tripEvent.startLocation : ""
            }
            DateField {
                id: endDate
                width: parent.width
                allowEditing: true
                label: qsTr("End on: ")
                selectedDate: tripEvent ? tripEvent.endDate : new Date()
            }
            TextFieldRow {
                id: endTime
                width: thisPage.width
                label: qsTr("End at: ")
                placeHolder: qsTr("18:00")
                textFieldItem.inputMask: "00:00"
                value: tripEvent ? "%1:%2".arg(tripEvent.endDate.getHours()).arg(tripEvent.endDate.getMinutes()) : "00:00"
            }
            TextFieldRow {
                id: endLocation
                width: thisPage.width
                label: qsTr("End in: ")
                placeHolder: qsTr("Enter event end location")
                value: tripEvent ? tripEvent.endLocation : ""
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
                label: qsTr("Paiment: ")
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
                    console.log(">>>>>> Saving event")
                    console.log("   Type: ", eventType.value)
                    console.log("   TripId: ",tripId)
                    console.log("   Start date: ",startDate.selectedDate)
                    console.log("   End date: ", endDate.selectedDate)
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
                                                startDate.selectedDate,
                                                endDate.selectedDate,
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
                        tripEvent.startDate = startDate.selectedDate
                        tripEvent.endDate = endDate.selectedDate
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
}
