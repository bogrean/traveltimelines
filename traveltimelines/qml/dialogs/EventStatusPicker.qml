import QtQuick
import Felgo
import QtQuick.Controls

/*!
  \qmltype EventStatusPicker
  \brief Helper dialog for easy trip event status selection.

  Small dialog consisting of a series of exclusive radio buttons and a an accept button.
*/

Dialog {
    id: picker
    readonly property var _options: [todoOption, reservedOption, onTheSpotOption]

    /*!
      \qmlproperty string EventStatusPicker::selectedOption

      The event status selected. It can be any one of "todo", "reserved" and "onTheSpot"
    */
    readonly property string selectedOption: optionsRadioGroup.checkedButton ? optionsRadioGroup.checkedButton.value : ""
    title: qsTr("Choose event status")
    positiveActionLabel: qsTr("Done")
    negativeAction: false
    autoSize: true
    /*!
      \qmlmethod void EventStatusPicker::setSelection(string option)

      Selects the coresponding radio to \a option. \a option can be any one of "todo", "reserved" and "onTheSpot"
    */
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
            text: qsTr("To do")
            checked: true
        }
        AppRadio {
            id: reservedOption
            value: "reserved"
            text: qsTr("Reservation made")
        }
        AppRadio {
            id: onTheSpotOption
            value: "onTheSpot"
            text: qsTr("On the spot")
        }
    }
}
