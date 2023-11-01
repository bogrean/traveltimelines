import QtQuick
import Felgo
import QtQuick.Controls

Dialog {
    id: eventTypePicker
    readonly property var _options: [planeOption, accommodationOption, ferryOption, busOption, rentCarOption, driveOption, tourOption]
    readonly property string selectedOption: eventTypeRadioGroup.checkedButton ? eventTypeRadioGroup.checkedButton.value : ""
    title: "Choose event type"
    positiveActionLabel: "Done"
    negativeAction: false
    autoSize: true
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
            text: "Plane"
            checked: true
        }
        AppRadio {
            id: accommodationOption
            value: "accommodation"
            text: "Accommodation"
        }
        AppRadio {
            id: ferryOption
            value: "ferry"
            text: "Ferry"
        }
        AppRadio {
            id: busOption
            value: "bus"
            text: "Bus"
        }
        AppRadio {
            id: rentCarOption
            value: "rentCar"
            text: "Rent a car"
        }
        AppRadio {
            id: driveOption
            value: "drive"
            text: "Drive"
        }
        AppRadio {
            id: tourOption
            value: "tour"
            text: "Tour"
        }
    }
}
