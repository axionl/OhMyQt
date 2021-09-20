import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("CURL Downloader")

    property string backgroundColor: "#3e3e3e"
    property string deepColor: "#373737"
    property string highlightColor: "#66cccc"
    property string textColor: "#e3e3e3"

    color: backgroundColor

    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.fillHeight: true
        }

        Label {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            text: "Curl Downloader"
            color: textColor
            font.weight: Font.Thin
            font.pointSize: 24
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.margins: 32
            spacing: 16

            TextField {
                Layout.fillWidth: true

                id: urlTextField

                placeholderText: "Enter URL to download"
                placeholderTextColor: textColor
                color: textColor
                font.weight: Font.Light
                font.pointSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                background: Rectangle {
                    radius: height / 2
                    color: deepColor
                    border.color: highlightColor
                }
            }

            Button {
                id: buttonControl
                text: "Start"

                contentItem: Text {
                    id: buttonControlText
                    text: buttonControl.text
                    font.pointSize: 12
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    id: buttonBackground
                    implicitWidth: 100
                    implicitHeight: 40
                    radius: height / 2
                    border.color: highlightColor
                    color: Qt.lighter(backgroundColor, 1.1)
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        buttonBackground.color = highlightColor
                    }

                    onExited: {
                        buttonBackground.color = Qt.lighter(backgroundColor,
                                                            1.1)
                    }

                    onClicked: {
                        CURLHelper.download(urlTextField.text)
                    }
                }
            }
        }

        ProgressBar {
            id: progressBar
            Layout.margins: 36
            Layout.fillWidth: true

            value: CURLHelper.progress
            padding: 2

            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 18
                color: deepColor
                radius: height / 2
            }

            contentItem: Item {
                implicitWidth: 200
                implicitHeight: 18

                Rectangle {
                    width: progressBar.visualPosition * parent.width
                    height: parent.height
                    radius: height / 2
                    color: highlightColor
                }
            }
        }

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true

            TextField {
                anchors.fill: parent

                text: CURLHelper.result
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: textColor
                background: Rectangle {
                    color: deepColor
                }

                onTextChanged: {
                    if (text) {
                        Qt.openUrlExternally(text)
                    }
                }
            }
        }
    }
}
