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
                }
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: {
                    //console.log("Exit action triggered");
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
                    //console.log("Difficulty action triggered");
                    intermItem.checked = false
                    hardItem.checked = false
                    checked = true
                    logic.setDifficulty( 9, 9, 10 );
                    logic.startGame();
                  }
              }
              MenuItem{
                    id: intermItem
                    text: qsTr("Intermediate")
                    checkable: true
                    checked: false
                    onTriggered: {
                      easyItem.checked = false
                      hardItem.checked = false
                      checked = true
                      //console.log("Difficulty action triggered");
                      logic.setDifficulty( 16, 16, 40 );
                      logic.startGame();
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
                        root.width = 800 //hard-coded...
                        root.height = 460 //hard-coded...
                        //console.log("Difficulty action triggered");
                        logic.setDifficulty( 16, 30, 99);
                        logic.startGame();
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
                    console.log("Show Highscore action triggered");
                    //messageDialog.show("Not yet implemented :)")
                    My_Hs.getHighscores();
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
                            //console.info("accepted: " + text)
                        })
                        d1.no.connect(function(){
                            //console.info("rejected: " + text)
                        })
                        d1.visible = true //this actually makes the Dialog pop up!
                    }
                }
                MenuItem{
                    text: qsTr("Add values")
                    checkable: false
                    onTriggered: {
                    console.log("Save Highscore action triggered");
                    //messageDialog.show("Not yet implemented :)")
                    My_Hs.newMaxScore(1);
                    My_Hs.saveHighscores("Nina", 10);
                    My_Hs.saveHighscores("Nina2", 12);
                    My_Hs.saveHighscores("Nina3", 3);
                    My_Hs.newMaxScore(2);
                    My_Hs.newMaxScore(15);
                    }
                }
            }

}
