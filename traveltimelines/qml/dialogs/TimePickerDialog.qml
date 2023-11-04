import QtQuick
import Felgo

/*!
  \qmltype TimePickerDialog
  \brief Helper dialog for easy time picking.

  Small dialog consisting of a time picker and an accept button
*/

Dialog {
    id: picker
    /*!
      \qmlproperty date TimePickerDialog::startDate

      The earliest date that can be selected.
    */
    property alias startDate: datePicker.startDate
    /*!
      \qmlproperty date TimePickerDialog::endDate

      The latest date that can be selected.
    */
    property alias endDate: datePicker.endDate
    /*!
      \qmlproperty date TimePickerDialog::selectedDate

      The currently selected date. Only the time part of the property is relevant
    */
    property alias selectedDate: datePicker.selectedDate

    title: qsTr("Select Time")
    positiveActionLabel: qsTr("Done")
    negativeAction: false
    autoSize: true

    /*!
      \qmlmethod void TimePickerDialog::setDate(date selectedDate)

      Sets \l selectedDate to \a selectedDate
    */
    function setDate(selectedDate) {
        datePicker.setDate(selectedDate)
    }

    DatePicker {
        id: datePicker
        datePickerMode: datePicker.timeMode
    }
}
