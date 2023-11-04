import QtQuick
import Felgo

/*!
  \qmltype DatePickerDialog
  \brief Helper dialog for easy date picking.

  Small dialog consisting of a date picker and an accept button
*/

Dialog {
    id: picker
    /*!
      \qmlproperty date DatePickerDialog::startDate

      The earliest date that can be selected.
    */
    property alias startDate: datePicker.startDate
    /*!
      \qmlproperty date DatePickerDialog::endDate

      The latest date that can be selected
    */
    property alias endDate: datePicker.endDate
    /*!
      \qmlproperty date DatePickerDialog::selectedDate

      The currently selected date
    */
    property alias selectedDate: datePicker.selectedDate

    title: qsTr("Select Date")
    positiveActionLabel: qsTr("Done")
    negativeAction: false
    autoSize: true

    /*!
      \qmlmethod void DatePickerDialog::setDate(date selectedDate)

      Sets \l selectedDate to \a selectedDate
    */
    function setDate(selectedDate) {
        datePicker.setDate(selectedDate)
    }

    DatePicker {
        id: datePicker
        datePickerMode: datePicker.dateMode
    }
}
