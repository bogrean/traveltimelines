import QtQuick
import Felgo

/*!
  \qmltype EventOverview
  \brief QML component dispalying event information.

  Component displaying the trip event data in a non editable way. Added buttons allow \
  the user to open a new page to edit the data or delete the event.

  Is intended to be used as a delegate.
*/

Rectangle {
    id: eventCard
    /*!
      \qmlproperty int EventOverview::eventId

      The id of the event being displayed.
    */
    required property int eventId
    /*!
      \qmlproperty string EventOverview::type

      The type of the event being displayed. The appearance of EventOverview is changed \
      according to this value
    */
    required property string type
    /*!
      \qmlproperty date EventOverview::startDate

      The start date of the event. Both date and time data are used
    */
    required property date startDate
    /*!
      \qmlproperty date EventOverview::endDate

      The end date of the event. Both date and time data are used
    */
    required property date endDate
    /*!
      \qmlproperty string EventOverview::startLocation

      The location where the event starts
    */
    required property string startLocation
    /*!
      \qmlproperty string EventOverview::endLocation

      The location where the event ends
    */
    required property string endLocation
    /*!
      \qmlproperty string EventOverview::operator

      The operator of the event
    */
    required property string operator
    /*!
      \qmlproperty int  EventOverview::cost

      The cost of the event, in \l currency
    */
    required property int cost
    /*!
      \qmlproperty string EventOverview::costStatus

      Indicates whether this event has been paid or not
    */
    required property string costStatus
    /*!
      \qmlproperty string EventOverview::comments

      User added comments for this event
    */
    required property string comments
    required property int index

    /*!
      \qmlproperty string EventOverview::status

      The status of this event. This controls the background color of this component
    */
    required property string status

    /*!
      \qmlproperty string EventOverview::currency

      The currency in which the cost is set
    */
    property string currency: "RON"

    property color backgroundColor: (status === "todo") ? "pink"
                                                        : ((status === "onTheSpot") ? "light blue" : "light green")

    color: backgroundColor

    signal clicked()
    signal deleteRequested()

    states: [
        //! [state definition]
        State {
            name: "plane"
            PropertyChanges {
                target: header
                text: qsTr("Fly to %1").arg(endLocation)
            }
            PropertyChanges {
                target: departingOn
                label: qsTr("Take off on:")
            }
            PropertyChanges {
                target: departingAt
                label: qsTr("Take off at:")
            }
            PropertyChanges {
                target: departingFrom
                label: qsTr("Departure airport:")
            }
            PropertyChanges {
                target: arrivingOn
                label: qsTr("Landing on:")
            }
            PropertyChanges {
                target: arrivingAt
                label: qsTr("Landing at:")
            }
            PropertyChanges {
                target: arrivingIn
                label: qsTr("Arrival ariport:")
            }
        },
        //! [state definition]
        State {
            name: "rentCar"
            PropertyChanges {
                target: header
                text: qsTr("Rent a car in %1").arg(startLocation)
            }
            PropertyChanges {
                target: departingOn
                label: qsTr("Pick-up date:")
            }
            PropertyChanges {
                target: departingAt
                label: qsTr("Pick-up time:")
            }
            PropertyChanges {
                target: departingFrom
                label: qsTr("Pick-up location:")
            }
            PropertyChanges {
                target: arrivingOn
                label: qsTr("Drop-off date:")
            }
            PropertyChanges {
                target: arrivingAt
                label: qsTr("Drop-off time:")
            }
            PropertyChanges {
                target: arrivingIn
                label: qsTr("Drop-off location::")
            }
        },
        State {
            name: "accommodation"
            PropertyChanges {
                target: header
                text: qsTr("Accommodation in %1").arg(startLocation)
            }
            PropertyChanges {
                target: departingOn
                label: qsTr("Check-in date:")
            }
            PropertyChanges {
                target: departingAt
                label: qsTr("Check-in time:")
            }
            PropertyChanges {
                target: departingFrom
                label: qsTr("Check-in address:")
            }
            PropertyChanges {
                target: arrivingOn
                label: qsTr("Check-out date:")
            }
            PropertyChanges {
                target: arrivingAt
                label: qsTr("Check-out time:")
            }
            PropertyChanges {
                target: arrivingIn
                visible: false
            }
        },
        State {
            name: "ferry"
            PropertyChanges {
                target: header
                text: qsTr("Boat to %1").arg(endLocation)
            }
            PropertyChanges {
                target: departingOn
                label: qsTr("Boarding date:")
            }
            PropertyChanges {
                target: departingAt
                label: qsTr("Boarding time:")
            }
            PropertyChanges {
                target: departingFrom
                label: qsTr("Boarding port:")
            }
            PropertyChanges {
                target: arrivingOn
                label: qsTr("Disembarking date:")
            }
            PropertyChanges {
                target: arrivingAt
                label: qsTr("Disembarking time:")
            }
            PropertyChanges {
                target: arrivingIn
                label: qsTr("Disembarking port:")
            }
        },
        State {
            name: "bus"
            PropertyChanges {
                target: header
                text: qsTr("Bus to %1").arg(endLocation)
            }
            PropertyChanges {
                target: departingOn
                label: qsTr("Boarding date:")
            }
            PropertyChanges {
                target: departingAt
                label: qsTr("Boarding time:")
            }
            PropertyChanges {
                target: departingFrom
                label: qsTr("Boarding station:")
            }
            PropertyChanges {
                target: arrivingOn
                label: qsTr("Disembarking date:")
            }
            PropertyChanges {
                target: arrivingAt
                label: qsTr("Disembarking time:")
            }
            PropertyChanges {
                target: arrivingIn
                label: qsTr("Disembarking station:")
            }
        },
        State {
            name: "drive"
            PropertyChanges {
                target: header
                text: qsTr("Drive to %1").arg(endLocation)
            }
            PropertyChanges {
                target: departingOn
                label: qsTr("Start date:")
            }
            PropertyChanges {
                target: departingAt
                label: qsTr("Start time:")
            }
            PropertyChanges {
                target: departingFrom
                label: qsTr("Start location:")
            }
            PropertyChanges {
                target: arrivingOn
                label: qsTr("Arrival date:")
            }
            PropertyChanges {
                target: arrivingAt
                label: qsTr("Arrival time:")
            }
            PropertyChanges {
                target: arrivingIn
                label: qsTr("Destination:")
            }
            PropertyChanges {
                target: eventOperator
                visible: false
            }
            PropertyChanges {
                target: eventCost
                visible: false
            }
        },
        State {
            name: "tour"
            PropertyChanges {
                target: header
                text: qsTr("Tour in %1").arg(startLocation)
            }
            PropertyChanges {
                target: departingOn
                label: qsTr("Meeting date:")
            }
            PropertyChanges {
                target: departingAt
                label: qsTr("Meeting time:")
            }
            PropertyChanges {
                target: departingFrom
                label: qsTr("Meeting location:")
            }
            PropertyChanges {
                target: arrivingOn
                label: qsTr("Drop-off date:")
            }
            PropertyChanges {
                target: arrivingAt
                label: qsTr("Drop-off time:")
            }
            PropertyChanges {
                target: arrivingIn
                label: qsTr("Drop-off location:")
            }
        }
    ]

    state: eventCard.type

    //! [contents]
    Column {
        id: details
        width: parent.width
        AppText {
            id: header
            padding: dp(5)
            text: qsTr("%1 to %2").arg(type).arg(endLocation)
            font.bold: true
        }
        DateField {
            id: departingOn
            selectedDate: startDate
            label: qsTr("Departing on: ")
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            id: departingAt
            label: qsTr("Departing at:")
            enabled: false
            value: startDate.toTimeString()
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            id: departingFrom
            label: qsTr("Departing from:")
            enabled: false
            value: startLocation
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        DateField {
            id: arrivingOn
            selectedDate: endDate
            label: qsTr("Ariving on: ")
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            id: arrivingAt
            label: qsTr("Arriving at")
            enabled: false
            value: endDate.toTimeString()
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            id: arrivingIn
            label: qsTr("Arriving in:")
            enabled: false
            value: endLocation
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            id: eventOperator
            label: qsTr("Operator:")
            enabled: false
            value: operator
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            id: eventCost
            label: qsTr("Cost:")
            enabled: false
            value: qsTr("%1 %2 (%3)").arg(cost).arg(currency).arg(costStatus)
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
        TextFieldRow {
            label: qsTr("Comments:")
            enabled: false
            value: comments
            color: eventCard.backgroundColor
            textFieldItem.backgroundColor: eventCard.backgroundColor
        }
    }
        //! [contents]

    //! [icon buttons]
    Row {
        anchors.top: details.bottom
        anchors.right: details.right
        IconButton {
            iconType: IconType.pencil
            onClicked: {
                eventCard.clicked()
            }
        }
        IconButton {
            iconType: IconType.remove
            onClicked: {
                eventCard.deleteRequested()
            }
        }
    }
    //! [icon buttons]
}
