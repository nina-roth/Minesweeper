import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
//import Qt.labs.platform 1.0 //for MenuItemGroup

MenuBar {//NB: this menu is not at the top of the WINDOW, but at the top of the SCREEN for Mac
        id: menu
        Menu { id: gameMenu
            title: qsTr("Game")
            MenuItem {
                text: qsTr("New")
                onTriggered: {
                    //console.log("New Game action triggered");
                    //console.log(logic.gameState);
                    //console.log(logic.value);
                    //logic.setRows(9);
                    //logic.setBombs(10);
                    //console.log(logic.value);

                    logic.startGame();
                    //console.log(logic.gameState);
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
              //MenuItemGroup{
              //   id: diffGroup
              //   items: diffmenu.items
              //}
              MenuItem{
                  text: qsTr("Easy")
                  //checkable: true
                  //checked: true
                  onTriggered: {
                    //console.log("Difficulty action triggered");
                    logic.setDifficulty( 9, 10 );
                    logic.startGame();
                  }
              }
              MenuItem{
                    text: qsTr("Intermediate")
                    //checkable: true
                    onTriggered: {
                      //console.log("Difficulty action triggered");
                      logic.setDifficulty( 16, 40 );
                      logic.startGame();
                    }
               }
               MenuItem{
                    text: qsTr("Hard")
                    //checkable: true
                    onTriggered: {
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
