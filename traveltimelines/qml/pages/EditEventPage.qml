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
                target: eventType
                currentIndex: 0
            }
            PropertyChanges {
                target: startDate
                selectedDate: new Date()
            }
            PropertyChanges {
                target: endDate
                selectedDate: new Date()
            }
        },
        State {
            name: "editExisting"
            PropertyChanges {
                target: thisPage
                title: qsTr("Edit trip event")
            }
            PropertyChanges {
                target: eventType
                currentIndex: tripEvent ? eventType.model.indexOf(tripEvent.type) : -1
            }
            PropertyChanges {
                target: startDate
                selectedDate: tripEvent ? tripEvent.start : new Date()
            }
            PropertyChanges {
                target: endDate
                selectedDate: tripEvent ? tripEvent.end : new Date()
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
                }
            }
            DateField {
                id: startDate
                width: parent.width
                allowEditing: true
                labelText: qsTr("Start on: ")
            }
            TextFieldRow {
                id: startTime
                width: thisPage.width
                label: qsTr("Start at: ")
                placeHolder: qsTr("18:00")
                textFieldItem.inputMask: "00:00"
            }
            TextFieldRow {
                id: startLocation
                width: thisPage.width
                label: qsTr("Start in: ")
                placeHolder: qsTr("Enter event start location")
            }
            DateField {
                id: endDate
                width: parent.width
                allowEditing: true
                labelText: qsTr("End on: ")
            }
            TextFieldRow {
                id: endTime
                width: thisPage.width
                label: qsTr("End at: ")
                placeHolder: qsTr("18:00")
                textFieldItem.inputMask: "00:00"
            }
            TextFieldRow {
                id: endLocation
                width: thisPage.width
                label: qsTr("End in: ")
                placeHolder: qsTr("Enter event end location")
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
                }
            }
            TextFieldRow {
                id: cost
                width: thisPage.width
                label: qsTr("Event cost: ")
                placeHolder: qsTr("Enter event cost")
                textFieldItem.inputMask: "00000 RO\\N"
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
                }
            }
            TextFieldRow {
                id: operator
                width: thisPage.width
                label: qsTr("Event operator: ")
                placeHolder: qsTr("Enter event operator")
            }

            TextFieldRow {
                id: comments
                width: thisPage.width
                label: qsTr("Observations: ")
                placeHolder: qsTr("Add any observations for this event")
            }

            AppButton {
                id: saveEvent
                text: qsTr("Create event")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    console.log(">>>>>> Saving event")
                    console.log("   Type: ", eventType.displayText)
                    console.log("   TripId: ",tripId)
                    console.log("   Start date: ",startDate.selectedDate)
                    console.log("   End date: ", endDate.selectedDate)
                    console.log("   Start location: ", startLocation.value)
                    console.log("   End location: ", endLocation.value)
                    console.log("   Status: : ", eventStatus.displayText)
                    console.log("   Cost: : ", parseInt(cost.value))
                    console.log("   Cost status: ", costStatus.displayText)
                    console.log("   Operator: ", operator.value)
                    console.log("   Comments: ", comments.value)
                    if (thisPage.state === "addNew") {
                        dispatcher._createEvent(eventType.displayText,
                                                tripId,
                                                startDate.selectedDate,
                                                endDate.selectedDate,
                                                startLocation.value,
                                                endLocation.value,
                                                eventStatus.displayText,
                                                parseInt(cost.value),
                                                costStatus.displayText,
                                                operator.value,
                                                comments.value)
                        thisPage.navigationStack.pop()
                    } else if (thisPage.state === "editExisting"){
                    }
                }
            }
        }
    }
}
