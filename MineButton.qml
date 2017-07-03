import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

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

                MouseArea { id: mouseArea; anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            signal revealEmpty
                            signal revealBombs
                            signal revealFlags
                            onClicked: {
                                if (mouse.button == Qt.LeftButton){
                                    if(grid.gs == false ){
                                        grid.gs = true
                                        logic.startTimer();
                                        timer.running = true;
                                    }
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

                            onRevealFlags: {
                                    stateGroup.state = "Checkmark"
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

                function textset(nBombs){
                    text_color = color_array[nBombs];
                    if(nBombs == 0){text = "";}
                    else{text = nBombs;}
                }


                function reveal(mode){
                    if(mode === "Cell"){
                        mouseArea.revealEmpty();
                    }
                    else if (mode === "Bomb"){
                        mouseArea.revealBombs();
                    }
                    else if (mode === "Flag") {
                        mouseArea.revealFlags();
                    }
                    else { } //do nothing
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
                            font.weight: 60
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
                            text: "\u2620"
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
                            text: "\u26F3"
                            visible: true
                        }
                     },
                    State {
                       name: "Checkmark"

                       PropertyChanges {
                           target: text1
                           text: "\u2713"
                           color: "green"
                           visible: true
                       }
                    }
                ]
              }

}

