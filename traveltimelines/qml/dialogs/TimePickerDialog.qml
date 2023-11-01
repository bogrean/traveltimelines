import QtQuick
import Felgo

Dialog {
    id: picker
    property alias startDate: datePicker.startDate
    property alias endDate: datePicker.endDate
    property alias selectedDate: datePicker.selectedDate

    title: qsTr("Select Time")
    positiveActionLabel: qsTr("Done")
    negativeAction: false
    autoSize: true
    function setDate(selectedDate) {
        datePicker.setDate(selectedDate)
    }

    DatePicker {
        id: datePicker
        datePickerMode: datePicker.timeMode
    }
}
