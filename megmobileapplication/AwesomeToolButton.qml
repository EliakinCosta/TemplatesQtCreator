import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1

ToolButton {
    id: control

    property alias nameIcon: contentIcon.name

    signal clickedToolButton

    contentItem: Icon {
        id: contentIcon; clickEnabled: false
        anchors.centerIn: parent; color: "white"
    }
    onClicked: control.clickedToolButton()
}
