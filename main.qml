import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import my.extensions 1.0

ApplicationWindow {
    id:root
    visible: true
    width: 400
    height: width
    title: qsTr("Minesweeper")

    GameLogic {
        id: logic
        onWon: messageDialog.show("You've won!")
    }

    GameArea {
        id: area
        rows: logic.getNRows
    }

    My_Menu {}

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
