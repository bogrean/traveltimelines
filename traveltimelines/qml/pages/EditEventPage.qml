import QtQuick
import Felgo
import QtQuick.Layouts
import QtQuick.Controls

import "../logic"

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

            RowLayout {
                spacing: dp(10)
                width: thisPage.width
                AppText {
                    Layout.leftMargin: dp(10)
                    text: qsTr("Event type: ")
                }
                ComboBox {
                    id: eventType
                    Layout.rightMargin: dp(10)
                    Layout.alignment: Qt.AlignRight
                    model: ["plane", "accommodation", "ferry", "bus", "rentCar", "drive", "tour"]
                    currentIndex: tripEvent ? model.indexOf(tripEvent.type) : 0
                }
            }
            DateField {
                id: startDate
                width: parent.width
                allowEditing: true
                labelText: qsTr("Start on: ")
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
                labelText: qsTr("End on: ")
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
            RowLayout {
                spacing: dp(10)
                width: thisPage.width
                AppText {
                    Layout.leftMargin: dp(10)
                    text: qsTr("Event status: ")
                }
                ComboBox {
                    id: eventStatus
                    Layout.rightMargin: dp(10)
                    Layout.alignment: Qt.AlignRight
                    model: ["todo", "reserved", "onTheSpot"]
                    currentIndex: tripEvent ? model.indexOf(tripEvent.status) : 0
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
            RowLayout {
                spacing: dp(10)
                width: thisPage.width
                AppText {
                    Layout.leftMargin: dp(10)
                    text: qsTr("Paid: ")
                }
                ComboBox {
                    id: costStatus
                    Layout.rightMargin: dp(10)
                    Layout.alignment: Qt.AlignRight
                    model: ["paid", "estimated"]
                    currentIndex: tripEvent ? model.indexOf(tripEvent.costStatus) : 0
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
                    console.log("   Type: ", eventType.currentValue)
                    console.log("   TripId: ",tripId)
                    console.log("   Start date: ",startDate.selectedDate)
                    console.log("   End date: ", endDate.selectedDate)
                    console.log("   Start location: ", startLocation.value)
                    console.log("   End location: ", endLocation.value)
                    console.log("   Status: : ", eventStatus.currentValue)
                    console.log("   Cost: : ", parseInt(cost.value))
                    console.log("   Cost status: ", costStatus.currentValue)
                    console.log("   Operator: ", operator.value)
                    console.log("   Comments: ", comments.value)
                    if (thisPage.state === "addNew") {
                        dispatcher._createEvent(eventType.currentValue,
                                                tripId,
                                                startDate.selectedDate,
                                                endDate.selectedDate,
                                                startLocation.value,
                                                endLocation.value,
                                                eventStatus.currentValue,
                                                parseInt(cost.value),
                                                costStatus.currentValue,
                                                operator.value,
                                                comments.value)
                        thisPage.navigationStack.pop()
                    } else if (thisPage.state === "editExisting"){
                        tripEvent.type = eventType.currentValue
                        tripEvent.startDate = startDate.selectedDate
                        tripEvent.endDate = endDate.selectedDate
                        tripEvent.startLocation = startLocation.value
                        tripEvent.endLocation = endLocation.value
                        tripEvent.status = eventStatus.currentValue
                        tripEvent.cost = parseInt(cost.value)
                        tripEvent.costStatus = costStatus.currentValue
                        tripEvent.operator = operator.value
                        tripEvent.comments = comments.value
                        tripEventChanged()
                        dispatcher.editEvent(tripEvent)
                    }
                }
            }
        }
    }
}
