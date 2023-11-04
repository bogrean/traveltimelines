import QtQuick
import Felgo
import QtQuick.Controls

/*!
  \qmltype PaidStatusPicker
  \brief Helper dialog for easy trip event paiment status selection.

  Small dialog consisting of a series of exclusive radio buttons and an accept button.
*/

Dialog {
    id: picker
    readonly property var _options: [paidOption, estimatedOption]

    /*!
      \qmlproperty string PaidStatusPicker::selectedOption

      The event status selected. It can be either "paid" or "estimated"
    */
    readonly property string selectedOption: optionsRadioGroup.checkedButton ? optionsRadioGroup.checkedButton.value : ""
    title: qsTr("Choose paid status")
    positiveActionLabel: qsTr("Done")
    negativeAction: false
    autoSize: true

    /*!
      \qmlmethod void PaidStatusPicker::setSelection(string option)

      Selects the coresponding radio to \a option. \a option can be either "paid" or "estimated"
    */
    //! [setting the option]
    function setSelection(option) {
        var selection = _options.find((btn) => btn.value === option)
        optionsRadioGroup.checkedButton = selection ? selection : paidOption
    }
    //! [setting the option]

    Column {
        ButtonGroup {
            id: optionsRadioGroup
            buttons: picker._options
        }
        AppRadio {
            id: paidOption
            value: "paid"
            text: qsTr("Paid")
            checked: true
        }
        AppRadio {
            id: estimatedOption
            value: "estimated"
            text: qsTr("Estimated")
        }
    }
}
