import QtQuick
import Felgo

AppPage {
    id: thisPage

    required property var myTrips

    title: qsTr("My Trips")

    JsonListModel {
        id: myTrips
        source: thisPage.myTrips
        keyField: "id"
        fields: ["id", "title", "start", "end"]
    }

    AppListView {
        id: tripsView
        anchors.fill: parent
        model: myTrips
        spacing: 10
        delegate: TripOverview {
            width: parent.width
            height: childrenRect.height
        }
    }
}
