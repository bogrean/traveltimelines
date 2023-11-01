import QtQuick
import Felgo
import QtQuick.Controls

Dialog {
    id: picker
    readonly property var _options: [todoOption, reservedOption, onTheSpotOption]
    readonly property string selectedOption: optionsRadioGroup.checkedButton ? optionsRadioGroup.checkedButton.value : ""
    title: "Choose event status"
    positiveActionLabel: "Done"
    negativeAction: false
    autoSize: true
    function setSelection(option) {
        var selection = _options.find((btn) => btn.value === option)
        optionsRadioGroup.checkedButton = selection ? selection : toDoOption
    }

    Column {
        ButtonGroup {
            id: optionsRadioGroup
            buttons: picker._options
        }
        AppRadio {
            id: todoOption
            value: "todo"
            text: "To do"
            checked: true
        }
        AppRadio {
            id: reservedOption
            value: "reserved"
            text: "Reservation made"
        }
        AppRadio {
            id: onTheSpotOption
            value: "onTheSpot"
            text: "On the spot"
        }
    }
}
