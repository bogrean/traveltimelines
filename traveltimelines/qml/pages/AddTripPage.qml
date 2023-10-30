import QtQuick
import QtQuick.Layouts
import Felgo

import "../logic"

AppPage {
    id: thisPage
    required property TripsController dispatcher

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
                    id: addEvents
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
                        dispatcher._createTrip(tripTitle.text, startDate.selectedDate, endDate.selectedDate)
                    }
                }
            }

        }
    }
}
