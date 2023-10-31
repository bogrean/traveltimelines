import QtQuick
import Felgo
import QtQuick.Layouts

RowLayout {
    id: dateField
    property alias selectedDate: dateValue.selectedDate
    property alias labelText: dateLabel.text
    property bool allowEditing: false
    property bool isEditing: false
    spacing: 10
    AppText {
        padding: 10
        id: dateLabel
        text: qsTr("StartDate: ")
    }
    AppText {
        id: dateValue
        property date selectedDate: new Date()
        text: selectedDate.toDateString()
    }
    AppButton {
        id: edit
        Layout.alignment: Qt.AlignRight
        iconType: IconType.edit
        radius: 30
        visible: dateField.allowEditing
        onClicked: {
            isEditing = true
            NativeUtils.displayDatePicker(selectedDate)
        }
    }
    Connections {
        target: NativeUtils
        onDatePickerFinished:(accepted, date) => {
            if (isEditing && accepted) {
                isEditing = false
                dateField.selectedDate = date
            }
        }
    }
}
