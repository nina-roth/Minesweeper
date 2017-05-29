import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

GridForm {

        anchors.fill: parent

        Rectangle {
                width: 400; height: 400; color: "black"
                //anchors.fill: parent
                Grid {
                    id: grid
                    x: 5; y: 5
                    rows: 5; columns: 5; spacing: 1

                    Repeater { id: rep
                               model: 25
                               MineButton { id: mb
                                            height: 20
                                            cell_index: index
                                            text: index
                                            left_neighb: -1
                                            right_neighb: -1
                                            top_neighb: -1
                                            bottom_neighb: -1
                                            //property int
                               }
                    }
                }
        }

}
