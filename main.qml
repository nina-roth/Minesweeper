import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import my.extensions 1.0
import "highscore.js" as My_Hs


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
            //messageDialog.show("You've won!")
            area.gridCellReveal();
            area.gridFlagReveal();
            area.enabled = false
            console.log(logic.getTime);
            My_Hs.saveHighscores('dummy', logic.getTime);
        }
        onGameReset: {
            area.gridReset();
            area.enabled = true
        }
        onGameSetup: {
            area.gridSetup();
            area.enabled = true
        }
        onLost: {
            area.gridBombReveal();
            area.enabled = false
        }
    }

    menuBar: My_Menu {}

    MessageDialog {
        id: messageDialog
        title: qsTr("Minesweeper!")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
            messageDialog.title = title;
        }
    }

    Component{
        id: confirmationDialog

        MessageDialog {
            title: qsTr("Minesweeper")
            standardButtons: StandardButton.Yes | StandardButton.No

            function show() {
                text = "Some text";
                open();
                title = title;
            }
        }
    }
}
