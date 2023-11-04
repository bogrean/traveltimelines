import QtQuick
import Felgo

import "../dialogs"

/*!
  \qmltype TimeField
  \brief A row showing a time.

  This is an utility component to be used where we need to show a time.

  The component displays a label and a text field showing the time. It opens a \
  \l TimePickerDialog when the user tries to edit the date.
*/

TextFieldRow {
    id: dateField
    /*!
      \qmlproperty date TimeField::selectedDate

      The date containing the displayed time
    */
    property date selectedDate: new Date()
    /*!
      \qmlproperty bool TimeField::allowEditing

      Set to true if the used can edit the time, false otherwise
    */
    property bool allowEditing: false
    /*!
      \qmlproperty TimePickerDialog TimeField::pickerDialog

      The dialog that will be used to input the new time.
    */
    property TimePickerDialog pickerDialog: null
    /*!
      \qmlproperty bool TimeField::isEditing

      Set to true if the pickerDialog was opened by this instance
    */
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
