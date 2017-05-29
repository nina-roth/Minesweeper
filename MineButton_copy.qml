import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

//MineButtonForm {

        Rectangle {
                id: rect
                height: 200
                width: height
                border.color: "black"
                border.width: 2
                color: "grey"
                //[default]
                property int cell_index
                property int cell_i
                property int cell_j
                property int left_neighb: -1
                property int right_neighb: -1
                property int top_neighb: -1
                property int bottom_neighb: -1
                property alias text: text1.text
                signal lclicked //needed?
                signal rclicked //needed?

                MouseArea { id: mouseArea; anchors.fill: parent
                            //on
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                if (mouse.button == Qt.LeftButton){
                                    if (stateGroup.state == ""){
                                        stateGroup.state = "LeftClick"
                                    }
                                    else {//do nothing
                                    }
                                    rect.lclicked() //needed?
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
                                    rect.rclicked() //needed?
                                }

                            }

                }

                Text {
                    id: text1
                    visible: true
                    anchors.fill: parent
                    color: "black"
                    text: "?"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                }


    StateGroup {
                id: stateGroup
                states: [
                    State {
                        name: "LeftClick"

                        PropertyChanges {
                            target: text1
                            visible: true
                            text: "L"
                            color: "red"
                        }
                    },
                    State {
                        name: "RightClick"

                        PropertyChanges {
                            target: text1
                            text: "R"
                            color: "blue"
                            visible: true
                        }
                    }
                ]
              }

    }
//}
