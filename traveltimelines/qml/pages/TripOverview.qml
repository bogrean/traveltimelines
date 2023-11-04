import QtQuick
import Felgo

/*!
  \qmltype TripOverview
  \brief QML component dispalying trip information.

  Component displaying the trip event data in a non editable way. Added buttons allow \
  the user to open a new page to edit the data or delete the trip.

  Is intended to be used as a delegate.
*/

Rectangle {
    id: overview
    /*!
      \qmlproperty int TripOverview::eventId

      The id of the trip being displayed.
    */
    required property int tripId
    /*!
      \qmlproperty string TripOverview::title

      The title of the trip being displayed.
    */
    required property var title
    /*!
      \qmlproperty date TripOverview::start

      The date when trip starts. Only the date data is relevant.
    */
    required property date start
    /*!
      \qmlproperty date TripOverview::end

      The date when trip ends. Only the date data is relevant.
    */
    required property date end

    property color backgroundColor: "light blue"

    signal clicked()
    signal deleteRequested()

    color: backgroundColor

    Column {
        id: details
        width: parent.width
        AppText {
            padding: dp(5)
            text: title
            font.bold: true
        }
        DateField {
            selectedDate: start
            label: qsTr("Starts on: ")
            color: overview.backgroundColor
            textFieldItem.backgroundColor: overview.backgroundColor
            state: "showDate"
        }
        DateField {
            selectedDate: end
            label: qsTr("Ends on: ")
            color: overview.backgroundColor
            textFieldItem.backgroundColor: overview.backgroundColor
            state: "showDate"
        }
    }
    Row {
        anchors.top: details.bottom
        anchors.right: details.right
        IconButton {
            iconType: IconType.pencil
            onClicked: {
                overview.clicked()
            }
        }
        IconButton {
            iconType: IconType.remove
            onClicked: {
                overview.deleteRequested()
            }
        }
    }
}
