import QtQuick
import Felgo
import QtQuick.Controls

Dialog {
    id: picker
    readonly property var _options: [paidOption, estimatedOption]
    readonly property string selectedOption: optionsRadioGroup.checkedButton ? optionsRadioGroup.checkedButton.value : ""
    title: "Choose paid status"
    positiveActionLabel: "Done"
    negativeAction: false
    autoSize: true
    function setSelection(option) {
        var selection = _options.find((btn) => btn.value === option)
        optionsRadioGroup.checkedButton = selection ? selection : paidOption
    }

    Column {
        ButtonGroup {
            id: optionsRadioGroup
            buttons: picker._options
        }
        AppRadio {
            id: paidOption
            value: "paid"
            text: "Paid"
            checked: true
        }
        AppRadio {
            id: estimatedOption
            value: "estimated"
            text: "Estimated"
        }
    }
}
