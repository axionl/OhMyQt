import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    width: 960 // 窗口宽度
    height: 720  // 窗口高度

    Rectangle {
        anchors.centerIn: parent
        implicitWidth: 360 // 宽度 128 单位（多数情况下理解为像素）
        implicitHeight: 128 // 高度 128 单位
        color: "#ef7e9ceb"

        ColumnLayout {
            anchors.fill: parent
            spacing: 16

            Text {
                id: title // 为了加以区分，我们赋予它们唯一的 id
                anchors.horizontalCenter: parent.horizontalCenter // 水平对齐小盒子
                text: "这是一个大标题"
                font.pixelSize: 48 // 标题一定要大
            }

            Text {
                id: description
                anchors.horizontalCenter: parent.horizontalCenter // 水平对齐小盒子
                text: "我吞下玻璃会伤身体"
                font.pixelSize: 24 // 精致的描述用小字
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
