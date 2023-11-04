import QtQuick
import Felgo
import QtQuick.Layouts

import "../dialogs"

/*!
  \qmltype DateField
  \brief A row showing a date.

  This is an utility component to be used where we need to show a date.

  The component displays a label and a text field showing the date. It opens a \
  \l DatePickerDialog when the user tries to edit the date.
*/

TextFieldRow {
    id: dateField
    /*!
      \qmlproperty date DateField::selectedDate

      The displayed date
    */
    property date selectedDate: new Date()
    /*!
      \qmlproperty bool DateField::allowEditing

      Set to true if the used can edit the date, false otherwise
    */
    property bool allowEditing: false

    /*!
      \qmlproperty DatePickerDialog DateField::pickerDialog

      The dialog that will be used to input the new date.
    */
    property DatePickerDialog pickerDialog: null

    /*!
      \qmlproperty bool DateField::isEditing

      Set to true if the pickerDialog was opened by this instance
    */
    property bool isEditing: false

    value: selectedDate.toDateString()
    enabled: dateField.allowEditing
    clickEnabled: true
    //! [picker handling]
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
    //! [picker handling]
}
