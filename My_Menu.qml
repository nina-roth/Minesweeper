import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

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
                    logic.setDifficulty( 9, 10 );
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
                      logic.setDifficulty( 16, 40 );
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
                        //console.log("Difficulty action triggered");
                        logic.setDifficulty( 16, 99 );
                        logic.startGame();
                    }
                }
            }
        Menu {
            id: highScoreMenu
                title: qsTr("&Highscores")
                MenuItem{
                    text: qsTr("Show")
                    onTriggered: {
                    console.log("Show Highscore action triggered");
                    messageDialog.show("Not yet implemented :)")
                    //logc.showHighscores();
                    }
                }
                MenuItem{
                    text: qsTr("Reset")
                    onTriggered: {
                    console.log("Reset Highscore action triggered");
                    //logic.testloop();
                    messageDialog.show("Not yet implemented :)")
                    //logc.resetHighscores();
                    }
                }
            }

}
