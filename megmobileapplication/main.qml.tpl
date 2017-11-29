import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

import "FontAwesome.js" as FA

ApplicationWindow {
    id: appWindow
    visible: true
    width: 360
    height: 640
    title: qsTr("%{ProjectName}")

    Material.primary: "#05070d"
    Material.foreground: "#05070d"
    Material.accent: "#41cd52"

    header: ToolBar {
        width: parent.width
        RowLayout {
            anchors.fill: parent
            AwesomeToolButton {
                nameIcon: "bars"
                onClickedToolButton: {
                    __drawer.open()
                }
            }
            Label {
                text: "%{ProjectName}"
                font.bold: true
                color: "white"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            AwesomeToolButton {
                nameIcon: "info"
                onClickedToolButton: {
                }
            }
        }
    }

    Drawer {
        id: __drawer
        width: parent.width * 0.66
        height: parent.height
        Column {
            anchors.fill: parent
            Rectangle {
                width: __drawer.width
                height: appWindow.height / 3
                color: Material.primaryColor

                Label {
                    width: __drawer.width / 3 * 2
                    height: contentHeight
                    anchors { left: parent.left; leftMargin: 13; bottom: parent.bottom; bottomMargin: 5 }
                    text: "%{ProjectName}"
                    fontSizeMode: Text.HorizontalFit
                    font.pixelSize: width
                    font.family: "Roboto"
                    color: "white"
                }
            }
            ListView {
                width: parent.width
                height: 2 * (appWindow.height / 3)
                model: contents
                clip: true
                delegate: ItemDelegate {
                    width: parent.width
                    text: modelData.menuName
                    onClicked: {
                        tabBar.currentIndex = index
                        __drawer.close()
                    }
                }
            }
        }
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Repeater {
            model: contents
            Loader {
                source: (Qt.platform.os === "android") ?
                            "assets:/plugins/" + modelData.pluginName + "/" + modelData.mainPage
                          :
                            "file://" + modelData.pluginName + "/" + modelData.mainPage
            }
        }
    }

    footer: TabBar {
        id: tabBar
        width: parent.width
        currentIndex: swipeView.currentIndex
        Repeater {
            model: contents
            TabButton { text: modelData.menuName }
        }
    }

}
