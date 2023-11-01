import QtQuick
import Felgo

Rectangle {
    id: eventCard
    required property int eventId
    required property string type
    required property date startDate
    required property date endDate
    required property string startLocation
    required property string endLocation
    required property string operator
    required property int cost
    required property string costStatus
    required property string comments
    required property int index
    property string currency: "RON"

    property color backgroundColor: "light green"
    color: backgroundColor

    signal clicked()
    signal deleteRequested()

    Column {
        id: details
        width: parent.width
        AppText {
            padding: 5
            text: qsTr("%1 to %2").arg(type).arg(endLocation)
            font.bold: true
        }
        DateField {
            selectedDate: startDate
            label: qsTr("Departing on: ")
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            label: qsTr("Departing at:")
            enabled: false
            value: startDate.toTimeString()
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            label: qsTr("Departing from:")
            enabled: false
            value: startLocation
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        DateField {
            selectedDate: endDate
            label: qsTr("Ariving on: ")
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            label: qsTr("Arriving at")
            enabled: false
            value: endDate.toTimeString()
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            label: qsTr("Arriving in:")
            enabled: false
            value: endLocation
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            label: qsTr("Operator:")
            enabled: false
            value: operator
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            label: qsTr("Cost:")
            enabled: false
            value: qsTr("%1 %2 (%3)").arg(cost).arg(currency).arg(costStatus)
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            label: qsTr("Comments:")
            enabled: false
            value: comments
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
    }

    Row {
        anchors.top: details.bottom
        anchors.right: details.right
        IconButton {
            iconType: IconType.pencil
            onClicked: {
                eventCard.clicked()
            }
        }
        IconButton {
            iconType: IconType.remove
            onClicked: {
                eventCard.deleteRequested()
            }
        }
    }
}
