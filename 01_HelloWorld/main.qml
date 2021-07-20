import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

import HelloWorld 1.0

Window {
    width: 640
    height: 480
    minimumWidth: 640
    minimumHeight: 480
    visible: true
    title: qsTr("Hello World")

    property string buttonColor: "#ef7e9ceb"

    Rectangle {
        id: background
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ef7e9ceb"
            }

            GradientStop {
                position: 1
                color: "#c5000000"
            }
        }

        Image {
            anchors.fill: background
            source: "qrc:/background.png"
            fillMode: Image.PreserveAspectCrop
            z:-1
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 16

            Item {
                Layout.fillHeight: true
            }

            RowLayout {
                spacing: 16

                Item {
                    Layout.fillWidth: true
                }

                Rectangle {
                    id: button

                    implicitHeight: 48
                    implicitWidth: 156
                    radius: implicitHeight / 2
                    border.color: "white"
                    color: Qt.lighter(buttonColor, 0.9)
                    opacity: 0.7

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: "初等記憶體"
                        color: "white"
                        font.pixelSize: 24
                        font.family: "Microsoft YaHei UI"
                    }

                    layer.enabled: true
                    layer.effect: DropShadow {
                        horizontalOffset: 1
                        verticalOffset: 1
                        radius: 16
                        samples: 17
                        color: "#10000000"
                    }

                    MouseArea {
                        anchors.fill: parent
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        hoverEnabled: true

                        onEntered: {
                            parent.color = Qt.lighter(buttonColor, 0.8)
                            parent.opacity = 1.0
                        }

                        onExited: {
                            parent.color =  Qt.lighter(buttonColor, 0.9)
                            parent.opacity = 0.7
                        }

                        onClicked: {
                            parent.color =  Qt.lighter(buttonColor, 1.1)
                            helpHandler.openUrl("https://axionl.me");
                        }
                    }
                }

                Rectangle {
                    height: 32
                    color: "white"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    implicitWidth: 2
                    implicitHeight: 24
                }

                Text {
                    text: "Ariel AxionL"
                    color: "white"
                    font.pixelSize: 24
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.family: "Iosevka Term Slab"
                }

                Item {
                    Layout.fillWidth: true
                }
            }

            Text {
                Layout.fillWidth: true
                text: "「一個你知道的地方，和一個沒有酒的故事 ｜ 言文」"
                color: "white"
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                font.family: "SimSun"
            }

            Item {
                Layout.fillHeight: true
            }


            Rectangle {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.rightMargin: 16
                Layout.bottomMargin: 16
                implicitHeight: 16
                implicitWidth: implicitHeight
                radius: implicitHeight / 2
                border.color: "white"
                border.width: 1
                color: "transparent"

                Text {
                    id: infoText
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    text: "i"
                    font.pixelSize: 12
                    color: "white"
                    font.family: "Iosevka Term Slab"
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        parent.border.color = "grey"
                        infoText.color = "grey"
                    }

                    onExited: {
                        parent.border.color = "white"
                        infoText.color = "white"
                    }

                    onClicked: {
                        helpHandler.openUrl("https://wallhaven.cc/w/6o59k7")
                    }
                }
            }
        }

        HelpHandler {
            id: helpHandler
        }
    }
}


