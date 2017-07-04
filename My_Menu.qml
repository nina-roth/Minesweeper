import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import "highscore.js" as My_Hs

MenuBar {//NB: this menu is not at the top of the WINDOW, but at the top of the SCREEN for Mac
        id: menu

        signal menusEnable
        signal menusDisable

        onMenusEnable: {
            enableMenus()
        }

        onMenusDisable: {
            disableMenus()
        }

        function disableMenus(){
            for(var i = 0; i < menu.menus.length; ++i){
                menu.menus[i].enabled = false;
            }
        }
        function enableMenus(){
            for(var i = 0; i < menu.menus.length; ++i){
                menu.menus[i].enabled = true;
            }
        }

        Menu { id: gameMenu
            title: qsTr("Game")
            MenuItem {
                text: qsTr("New")
                shortcut: "Ctrl+N"
                onTriggered: {
                    logic.startGame();
                    area.gs = false;
                    timer.reset();
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
                  shortcut: "Ctrl+E"
                  checkable: true
                  checked: true
                  onTriggered: {
                    intermItem.checked = false
                    hardItem.checked = false
                    custItem.checked = false
                    checked = true
                    root.width = root.height
                    logic.setDifficulty( 9, 9, 10, text);
                    logic.startGame();
                    area.gs = false;
                    timer.reset();
                  }
              }
              MenuItem{
                    id: intermItem
                    text: qsTr("Intermediate")
                    shortcut: "Ctrl+I"
                    checkable: true
                    checked: false
                    onTriggered: {
                      root.width = root.height
                      easyItem.checked = false
                      hardItem.checked = false
                      custItem.checked = false
                      checked = true
                      logic.setDifficulty( 16, 16, 40, text);
                      logic.startGame();
                      area.gs = false;
                      timer.reset();
                    }
               }
               MenuItem{
                    id: hardItem
                    text: qsTr("Advanced")
                    shortcut: "Ctrl+A"
                    checkable: true
                    checked: false
                    onTriggered: {
                        easyItem.checked = false
                        intermItem.checked = false
                        custItem.checked = false
                        checked = true
                        root.width = root.height * 1.7
                        logic.setDifficulty( 16, 30, 99, text);
                        logic.startGame();
                        area.gs = false;
                        timer.reset();
                    }
                }
                MenuItem{
                    id: custItem
                    text: qsTr("Custom")
                    shortcut: "Ctrl+C"
                    checkable: true
                    checked: false
                    onTriggered: {
                        easyItem.checked = false
                        intermItem.checked = false
                        hardItem.checked = false
                        checked = true
                        root.width = root.height * 1.7
                        disableMenus();
                        var component = Qt.createComponent("CustomGameSettings.qml");
                        var window = component.createObject(root);
                        window.visible = true;
                    }

                }
            }
        Menu {
            id: highScoreMenu
                title: qsTr("&Highscores")

                MenuItem{
                    text: qsTr("Show")
                    shortcut: "Ctrl+S"
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
                    shortcut: "Ctrl+R"
                    checkable: false
                    onTriggered: {
                        disableMenus();
                        var d1 = confirmationDialog.createObject(root)
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
