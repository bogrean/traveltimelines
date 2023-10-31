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
        padding: 5
        AppText {
            text: title
            font.bold: true
        }
        AppText {
            text: qsTr("Starts on: %1").arg(start)
        }
        AppText {
            text: qsTr("Ends on: %1").arg(end)
        }
    }
    AppButton {
        anchors.top: details.bottom
        anchors.right: overview.right
        radius: 30
        iconType: IconType.remove
        onClicked: {
            overview.deleteRequested()
        }
    }
}
