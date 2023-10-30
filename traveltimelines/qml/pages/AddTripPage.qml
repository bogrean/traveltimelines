import QtQuick
import QtQuick.Layouts
import Felgo

import "../logic"

AppPage {
    id: thisPage
    required property TripsController dispatcher
    property var trip: null

    states: [
        State {
            name: "addNew"
            PropertyChanges {
                target: saveTripBtn
                text: qsTr("Create trip")
                enabled: tripTitle.text.length
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
                enabled: trip && (trip.title !== tripTitle.text || trip.start !== startDate.selectedDate || trip.end !== endDate.selectedDate)
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
    state: "addNew"

    title: qsTr("Add trip")

    AppFlickable{
        anchors.fill: parent
        contentHeight: pageContent.height

        Column {
            id: pageContent
            width: thisPage.width
            spacing: 10
            AppTextField {
                id: tripTitle
                width: parent.width
                padding: 10
                placeholderText: qsTr("Enter your trip name")

            }
            DatePicker {
                id: startDate
                datePickerMode: startDate.dateMode
            }
            DatePicker {
                id: endDate
                datePickerMode: endDate.dateMode
            }

            RowLayout{
                spacing: 10
                width: thisPage.width

                AppButton {
                    id: addEventsBtn
                    text: qsTr("Add events")
                    Layout.alignment: Qt.AlignCenter
                    enabled: false
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
    }
}
