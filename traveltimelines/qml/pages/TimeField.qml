import QtQuick
import Felgo

import "../dialogs"

TextFieldRow {
    id: dateField
    property date selectedDate: new Date()
    property bool allowEditing: false
    property TimePickerDialog pickerDialog: null
    property bool isEditing: false

    value: selectedDate.toTimeString()
    enabled: dateField.allowEditing
    clickEnabled: true

    onClicked: {
        isEditing = true
        pickerDialog.setDate(dateField.selectedDate)
        pickerDialog.open()
    }

    Connections {
        target: pickerDialog
        onAccepted: {
            if (dateField.isEditing) {
                dateField.isEditing = false
                dateField.selectedDate = pickerDialog.selectedDate
                pickerDialog.close()
            }
        }
    }
}
