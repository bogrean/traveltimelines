import QtQuick
import Felgo

Rectangle {
    id: overview
    required property int tripId
    required property var title
    required property date start
    required property date end

    signal clicked()
    signal deleteRequested()

    color: "light blue"

    Column {
        id: details
        width: parent.width
        AppText {
            padding: 5
            text: title
            font.bold: true
        }
        DateField {
            selectedDate: start
            label: qsTr("Starts on: ")
            color: "light blue"
        }
        DateField {
            selectedDate: end
            label: qsTr("Ends on: ")
            color: "light blue"
        }
    }
    Row {
        anchors.top: details.bottom
        anchors.right: details.right
        IconButton {
            iconType: IconType.pencil
            onClicked: {
                overview.clicked()
            }
        }
        IconButton {
            iconType: IconType.remove
            onClicked: {
                overview.deleteRequested()
            }
        }
    }
}
