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
                property int cell_i
                property int cell_j
                property int left_neighb: -1
                property int right_neighb: -1
                property int top_neighb: -1
                property int bottom_neighb: -1
                property alias text: text1.text
                property bool isBomb: false
                property int bombNeighbors
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

                }

                Text {
                    id: text1
                    visible: true
                    anchors.fill: parent
                    color: "black"
                    //text: "?"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

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
                            //color: "green"
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

