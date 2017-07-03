import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import my.extensions 1.0
import "highscore.js" as My_Hs

ApplicationWindow {
    id:root
    visible: true
    width: 400
    height: 400
    title: qsTr("Minesweeper")

    GameArea {
                id: area
                rows: logic.nRows
                cols: logic.nCols
             }

    statusBar: StatusBar {
                    Item {
                        Timer {
                            id: timer
                            interval: 500; running: true; repeat: true
                            onTriggered: timerText.text = "Elapsed time: " + logic.gameTime

                            function reset(){
                                running = false;
                                timerText.text = "Elapsed time: 0";
                            }

                        }
                        Text {
                            id: timerText
                            x: 5
                            text: ""
                        }
                        Text {
                            id: bombText
                            x: area.x + area.width - 80
                            text: "# of bombs: " + logic.nBombs
                        }
//                        Text {
//                            id: flagText
//                            x: 100
//                            text: "# of flags set: " + logic.getFlags
//                        }
                    }
    }

    GameLogic {
        id: logic
        onWon: {
            My_Hs.saveHighscores(logic.getDiff, logic.getTime);
            highscoretest();
            timer.running = false
            logic.setGameState(false);
            area.gridCellReveal();
            area.gridFlagReveal();
            area.enabled = false
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
            timer.running = false
            area.gridBombReveal();
            area.enabled = false
        }
        function highscoretest(){
            var maxScore = My_Hs.high;
            if(maxScore != -1){
                  messageDialog.show("New Highscore!");
            }
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
                text = "";
                open();
                title = title;
            }
        }
    }

}
