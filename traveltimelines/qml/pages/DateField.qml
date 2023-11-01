import QtQuick
import Felgo
import QtQuick.Layouts

import "../dialogs"

TextFieldRow {
    id: dateField
    property date selectedDate: new Date()
    property bool allowEditing: false
    property DatePickerDialog pickerDialog: null
    property bool isEditing: false

    value: selectedDate.toDateString()
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
