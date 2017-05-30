import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

//MineButtonForm {

Rectangle {
                id: rect
                height: 50
                width: height
                border.color: "darkgrey"
                border.width: 1
                color: "lightgrey"
                property int cell_index
                property int cell_x
                property int cell_y
                property alias text: text1.text
                property alias text_color: text1.color
                property bool isBomb: false
                property int bombNeighbors: 0
                property variant color_array: ["black", "blue", "green", "red", "darkblue", "darkred", "cyan", "black", "grey"]
                signal lclicked //needed?
                signal rclicked //needed?
                signal gameOver
                //signal gameWon

//                onGameOver: { console.log("Game Over!")
//                              messageDialog.show("Game Over!")
//                }

//                onGameWon: { console.log("You've won!")
//                              messageDialog.show("You've won!")
//                }

                MouseArea { id: mouseArea; anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            signal revealEmpty
                            signal revealBombs
                            signal revealFlags
                            onClicked: {
                                if (mouse.button == Qt.LeftButton){
                                    if (stateGroup.state == ""){
                                        if(isBomb){
                                            stateGroup.state = "LeftClickBomb"
                                            logic.gameOver();
                                        }
                                        else{
                                            stateGroup.state = "LeftClickReveal"
                                            textset(bombNeighbors);
                                            logic.incReveal();
                                            if(bombNeighbors == 0){
                                                neighborReveal(cell_x, cell_y);
                                            }
                                        }
                                    }
                                    else {
                                        //do nothing
                                    }
                                }
                                if (mouse.button == Qt.RightButton){
                                    if (stateGroup.state == ""){
                                        stateGroup.state = "RightClick"
                                    }
                                    else if(stateGroup.state == "RightClick"){
                                        stateGroup.state = ""
                                    }
                                    else {
                                        //do nothing
                                    }
                                }

                            }

                            onRevealEmpty: { //how can we just call a "MouseArea Leftclick" here?
                                if (stateGroup.state == ""){
                                    stateGroup.state = "LeftClickReveal"
                                    textset(bombNeighbors);
                                    logic.incReveal("Cell");
                                    if(bombNeighbors == 0){
                                        neighborReveal(cell_x, cell_y);
                                    }
                                }
                            }

                            onRevealBombs: { //how can we just call a "MouseArea LeftBombclick" here?
                                stateGroup.state = "LeftClickBomb"
                            }

                            onRevealFlags: { //how can we just call a "MouseArea RightClick" here?
                                if(stateGroup.state == ""){
                                    stateGroup.state = "RightClick"
                                }
                                else {} //do nothing
                            }

                }

                Text {
                    id: text1
                    visible: true
                    anchors.fill: parent
                    color: "black"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                }



                function textset(bombs){
                    text_color = color_array[bombs];
                    if(bombs == 0){text = "";}
                    else{text = bombs;}

                }


                function reveal(mode){
                    if(mode == "Cell"){
                        mouseArea.revealEmpty();
                    }
                    else if (mode == "Bomb"){
                        mouseArea.revealBombs();
                    }
                    else if (mode == "Flag") {
                        mouseArea.revealFlags();
                    }
                    else {} //do nothing
                }

                function cellReset(){
                    text = ""
                    stateGroup.state = ""
                    isBomb = false
                    bombNeighbors = 0
                }

                function cellSetup(index){
                    text = ""
                    stateGroup.state = ""
                    isBomb = logic.isBomb(index);
                    bombNeighbors = logic.bombNeighbors(index);
                }

    StateGroup {
                id: stateGroup
                states: [
                    State {
                        name: "LeftClickReveal"

                        PropertyChanges {
                            target: text1
                            visible: true
                            text: bombNeighbors
                        }
                        PropertyChanges{
                            target: rect
                            color: "white"
                        }
                    },
                    State {
                        name: "LeftClickBomb"

                        PropertyChanges {
                            target: text1
                            visible: true
                            text: "B"
                            color: "red"
                        }
                        PropertyChanges{
                            target: rect
                            color: "white"
                        }
                     },
                     State {
                        name: "RightClick"

                        PropertyChanges {
                            target: text1
                            text: "F"
                            color: "blue"
                            visible: true
                        }
                     }
                ]
              }

}

