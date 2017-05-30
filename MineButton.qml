import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

//MineButtonForm {

Rectangle {
                id: rect
                height: 50
                width: height
                border.color: "black"
                border.width: 2
                color: "grey"
                property int cell_index
                property int cell_x
                property int cell_y
                property alias text: text1.text
                property bool isBomb: false
                property int bombNeighbors: 0
                signal lclicked //needed?
                signal rclicked //needed?
                signal gameOver
                //signal gameWon

                onGameOver: { console.log("Game Over!")
                              messageDialog.show("Game Over!")
                }

//                onGameWon: { console.log("You've won!")
//                              messageDialog.show("You've won!")
//                }

                MouseArea { id: mouseArea; anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            signal revealEmpty//( string ME )
                            onClicked: {
                                if (mouse.button == Qt.LeftButton){
                                    if (stateGroup.state == ""){
                                        if(isBomb){
                                            stateGroup.state = "LeftClickBomb"
                                            rect.gameOver()
                                        }
                                        else{
                                            stateGroup.state = "LeftClickReveal"
                                            logic.incReveal();
                                            if(bombNeighbors == 0){
                                                neighborReveal(cell_x, cell_y);
                                             }
                                        }
                                    }
                                    else {//do nothing
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
                                    logic.incReveal();
                                    if(bombNeighbors == 0){
                                        neighborReveal(cell_x, cell_y);
                                    }
                                }
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

                function reveal(){
                    mouseArea.revealEmpty();
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
                    },
                    State {
                        name: "LeftClickBomb"

                        PropertyChanges {
                            target: text1
                            visible: true
                            text: "B"
                            color: "red"
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

