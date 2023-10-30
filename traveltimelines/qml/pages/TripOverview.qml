import QtQuick
import Felgo

Rectangle {
    required property var title
    required property date start
    required property date end
    color: "light blue"
    Column {
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
}
