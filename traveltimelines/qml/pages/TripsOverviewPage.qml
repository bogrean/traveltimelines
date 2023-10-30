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
        delegate: SimpleRow {
            text: model.title + " Start: " + model.start
        }
    }
}
