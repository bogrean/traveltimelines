import QtQuick
import Felgo

Rectangle {
    id: eventCard
    required property string type
    required property date startDate
    required property date endDate
    required property string startLocation
    required property string endLocation
    required property string operator
    required property int cost
    required property string costStatus
    required property string comments
    property string currency: "RON"
    color: "light green"

    signal clicked()
    signal deleteRequested()

    MouseArea {
        anchors.fill: parent
        onClicked: {
            eventCard.clicked()
        }
    }

    Column {
        id: details
        AppText {
            padding: 5
            text: qsTr("%1 to %2").arg(type).arg(endLocation)
            font.bold: true
        }
        DateField {
            selectedDate: startDate
            labelText: qsTr("Departing on: ")
        }
        AppText {
            padding: 10
            text: qsTr("Departing at: %1").arg(startDate.toTimeString())
        }
        AppText {
            padding: 10
            text: qsTr("Departing from: %1").arg(startLocation)
        }
        DateField {
            selectedDate: endDate
            labelText: qsTr("Ariving on: ")
        }
        AppText {
            padding: 10
            text: qsTr("Arriving at: %1").arg(endDate.toTimeString())
        }
        AppText {
            padding: 10
            text: qsTr("Arriving to: %1").arg(endLocation)
        }
        AppText {
            padding: 10
            text: qsTr("Operator: %1").arg(operator)
        }
        AppText {
            padding: 10
            text: qsTr("Cost: %1 %3 (%2)").arg(cost).arg(costStatus).arg(currency)
        }
        AppText {
            padding: 10
            text: qsTr("Comments: %1").arg(comments)
        }
    }
}
