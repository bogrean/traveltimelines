import QtQuick
import Felgo
import QtQuick.Layouts

TextFieldRow {
    id: dateField
    property date selectedDate: new Date()
    property bool allowEditing: false
    property bool isEditing: false

    value: selectedDate.toDateString()
    enabled: dateField.allowEditing
    clickEnabled: true

    onClicked: {
        isEditing = true
        NativeUtils.displayDatePicker(selectedDate)
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
