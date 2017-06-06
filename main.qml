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
                rows: logic.getNRows
                cols: logic.getNCols
            }



    statusBar: StatusBar {
        //RowLayout {
          //          id: layout
            //        anchors.fill: parent

                    Item {
                        Timer {
                            id: timer
                            interval: 500; running: true; repeat: true
                            onTriggered: timerText.text = "Elapsed time: " + logic.getTime//Date().toString()

                            function reset(){
                                running = false;
                                timerText.text = "Elapsed time: 0";
                            }

                        }
                        Text {
                            id: timerText
                            //text: "Hello"
                        }

                    }
                    //Item{
                      //  id: labelitem
                        //anchors.left: layout.right
                        //anchors { left: timeritem.right; verticalCenter: parent.verticalCenter; leftMargin: 0 }
                        //Label { text: "Difficulty: " + logic.getDiff }
                    //}
                    //Label { text: "Difficulty: " + logic.getDiff }
                    //Text { text: "Hello"}
                    //Text { text: "World"}
               // }

    }

    GameLogic {
        id: logic
        onWon: {
            My_Hs.saveHighscores(logic.getDiff, logic.getTime);
            highscoretest();
            timer.running = false
            logic.setgameState(false);
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
            var tt = My_Hs.high;
            if(tt != -1){
                  messageDialog.show("New Highscore!");
//                var d1 =  confirmationDialog.createObject(root)
//                d1.title = qsTr("New Highscore!");
//                d1.text = "New Highscore! \n" + "Share to Twitter?";
//                d1.yes.connect(function(){
//                    //My_Hs.share();
//                    console.info("accepted: " + logic.getTime)
//                })
//                d1.no.connect(function(){
//                    console.info("rejected: " + d1.text)
//                })
//                d1.visible = true
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
                text = "Some text";
                open();
                title = title;
            }
        }
    }
}
