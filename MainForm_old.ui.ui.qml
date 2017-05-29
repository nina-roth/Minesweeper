import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: item1
    width: 640
    height: 480
    property alias button: button
    property alias text2: text2
    property alias button3: button3
    property alias text1: text1

    property alias button1: button1
    property alias button2: button2

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent

        Button {
            id: button1
            text: qsTr("Press Me 1")
        }

        Button {
            id: button2
            text: qsTr("Press Me 2")
        }
    }

    Button {
        id: button
        x: 227
        y: 286
        text: qsTr("Button")

        Text {
            id: text1
            text: qsTr("Text")
            anchors.rightMargin: -2
            anchors.bottomMargin: -29
            anchors.leftMargin: 2
            anchors.topMargin: 29
            z: -1
            visible: true
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            anchors.fill: parent
            font.pixelSize: 12
        }
    }

    Button {
        id: button3
        x: 340
        y: 286
        text: qsTr("Button")

        Text {
            id: text2
            text: "Text2"
            visible: button3.pressed
            anchors.rightMargin: 0
            anchors.bottomMargin: -27
            anchors.leftMargin: 0
            anchors.topMargin: 27
            z: 1
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.Fit
            anchors.fill: parent
            font.pixelSize: 12
        }
    }

    MineButton {
        id: mineButton1
    }

    Connections {
        target: button3
        onClicked: print("clicked")
    }
}
