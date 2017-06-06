import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import "highscore.js" as My_Hs

MenuBar {//NB: this menu is not at the top of the WINDOW, but at the top of the SCREEN for Mac
        id: menu
        Menu { id: gameMenu
            title: qsTr("Game")
            MenuItem {
                text: qsTr("New")
                onTriggered: {
                    logic.startGame();
                    area.gs = false;
                    timer.running = true;
                }
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: {
                    Qt.quit();
                }
            }
        }
        Menu {
              title: qsTr("&Difficulty")
              id: diffmenu
              MenuItem{
                  id: easyItem
                  text: qsTr("Easy")
                  checkable: true
                  checked: true
                  onTriggered: {
                    intermItem.checked = false
                    hardItem.checked = false
                    checked = true
                    root.width = root.height
                    logic.setDiff(text);
                    logic.setDifficulty( 9, 9, 10 );
                    logic.startGame();
                    area.gs = false;
                    timer.running = true;
                  }
              }
              MenuItem{
                    id: intermItem
                    text: qsTr("Intermediate")
                    checkable: true
                    checked: false
                    onTriggered: {
                      root.width = root.height
                      easyItem.checked = false
                      hardItem.checked = false
                      checked = true
                      logic.setDiff(text);
                      logic.setDifficulty( 16, 16, 40 );
                      logic.startGame();
                      area.gs = false;
                      timer.running = true;
                    }
               }
               MenuItem{
                    id: hardItem
                    text: qsTr("Hard")
                    checkable: true
                    checked: false
                    onTriggered: {
                        easyItem.checked = false
                        intermItem.checked = false
                        checked = true
                        root.width = root.height * 1.7
                        logic.setDiff(text);
                        logic.setDifficulty( 16, 30, 99);
                        logic.startGame();
                        area.gs = false;
                        timer.running = true;
                    }
                }
            }
        Menu {
            id: highScoreMenu
                title: qsTr("&Highscores")

                MenuItem{
                    text: qsTr("Show")
                    checkable: false
                    onTriggered: {
                        displayScores();
                    }
                    function displayScores(){
                        My_Hs.getallHighscores();
                        var displayText = My_Hs.allScores;
                        messageDialog.title = "Highscores";
                        messageDialog.show(displayText);
                    }
                }
                MenuItem{
                    text: qsTr("Reset")
                    checkable: false
                    onTriggered: {
                        console.log("Reset Highscore action triggered");
                        var d1 =  confirmationDialog.createObject(root)
                        d1.text = "Reset all highscores?";
                        d1.yes.connect(function(){
                            My_Hs.resetHighscores();
                        })
                        d1.no.connect(function(){ })//do nothing
                        d1.visible = true //this actually makes the Dialog pop up!
                    }
                }
            }

}
