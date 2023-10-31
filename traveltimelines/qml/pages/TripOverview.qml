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
    MouseArea {
        anchors.fill: parent
        onClicked: {
            overview.clicked()
        }
    }
    Column {
        id: details
        AppText {
            padding: 5
            text: title
            font.bold: true
        }
        DateField {
            selectedDate: start
            labelText: qsTr("Starts on: ")
        }
        DateField {
            selectedDate: end
            labelText: qsTr("Ends on: ")
        }
    }
    IconButton {
        anchors.top: details.bottom
        anchors.right: overview.right
        iconType: IconType.remove
        onClicked: {
            overview.deleteRequested()
        }
    }
}
