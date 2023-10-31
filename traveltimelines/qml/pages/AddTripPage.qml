import QtQuick
import QtQuick.Layouts
import Felgo

import "../logic"

AppPage {
    id: thisPage
    required property TripsController dispatcher
    property Component tripEventsPage
    property var trip: null

    signal showEventsRequested()

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
                enabled: trip && (trip.title !== tripTitle.text || trip.start !== startDate.selectedDate || trip.end !== endDate.selectedDate)
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
            DateField {
                id: startDate
                width: parent.width
                allowEditing: true
                labelText: qsTr("Start date: ")
            }
            DateField {
                id: endDate
                width: parent.width
                allowEditing: true
                labelText: qsTr("End date: ")
            }

            RowLayout{
                spacing: 10
                width: thisPage.width

                AppButton {
                    id: addEventsBtn
                    text: qsTr("Add events")
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
    }
}
