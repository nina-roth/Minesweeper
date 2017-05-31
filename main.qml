import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
//import Qt.labs.platform 1.0 //for menus
import my.extensions 1.0

ApplicationWindow {
    id:root
    visible: true
    width: 400
    height: width
    title: qsTr("Minesweeper")

    GameArea {
        id: area
        rows: logic.getNRows
        cols: logic.getNCols
    }

    GameLogic {
        id: logic
        onWon: {
            messageDialog.show("You've won!")
            area.gridCellReveal();
            area.gridFlagReveal();
            area.enabled = false
        }
        onGameReset: {
            //console.log("Reset action triggered");
            area.gridReset();
            area.enabled = true
        }
        onGameSetup: {
            //console.log("Setup action triggered");
            area.gridSetup();
            area.enabled = true
        }
        onLost: {
            messageDialog.show("You've lost!")
            area.gridBombReveal();
            area.enabled = false
        }
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
