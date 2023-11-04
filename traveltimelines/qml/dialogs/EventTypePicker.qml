import QtQuick
import Felgo
import QtQuick.Controls

/*!
  \qmltype EventTypePicker
  \brief Helper dialog for easy trip event type selection.

  Small dialog consisting of a series of exclusive radio buttons and an accept button.
*/

Dialog {
    id: eventTypePicker
    readonly property var _options: [planeOption, accommodationOption, ferryOption, busOption, rentCarOption, driveOption, tourOption]

    /*!
      \qmlproperty string EventTypePicker::selectedOption

      The event status selected. It can be any one of "plane", "accommodation", "ferry", "bus", "rentCar", "drive" and "tour"
    */
    readonly property string selectedOption: eventTypeRadioGroup.checkedButton ? eventTypeRadioGroup.checkedButton.value : ""
    title: qsTr("Choose event type")
    positiveActionLabel: qsTr("Done")
    negativeAction: false
    autoSize: true
    /*!
      \qmlmethod void EventTypePicker::setSelection(string option)

      Selects the coresponding radio to \a option. \a option can be any one of "plane", "accommodation", "ferry", "bus", "rentCar", "drive" and "tour"
    */
    function setSelection(option) {
        var selection = _options.find((btn) => btn.value === option)
        eventTypeRadioGroup.checkedButton = selection ? selection : planeOption
    }

    Column {
        ButtonGroup {
            id: eventTypeRadioGroup
            buttons: selectEventType._options
        }
        AppRadio {
            id: planeOption
            value: "plane"
            text: qsTr("Plane")
            checked: true
        }
        AppRadio {
            id: accommodationOption
            value: "accommodation"
            text: qsTr("Accommodation")
        }
        AppRadio {
            id: ferryOption
            value: "ferry"
            text: qsTr("Ferry")
        }
        AppRadio {
            id: busOption
            value: "bus"
            text: qsTr("Bus")
        }
        AppRadio {
            id: rentCarOption
            value: "rentCar"
            text: qsTr("Rent a car")
        }
        AppRadio {
            id: driveOption
            value: "drive"
            text: qsTr("Drive")
        }
        AppRadio {
            id: tourOption
            value: "tour"
            text: qsTr("Tour")
        }
    }
}
