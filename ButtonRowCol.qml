import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Item {
    //property var rectVals
    //property alias startX: rectCol.x
    //property alias startY: rectCol.y
    //property string rectBorderColor: '#ffffff'
    property int rows: 5
    property int cols: 5

    Column {
        id: rectCol
        Repeater {
            id: repeater
            model: cols
            Item {
               width: rectRow.width
               height: 50
               property alias outerIndex: repeater.index
               Row {
                   id: rectRow
                   Repeater {
                       id: repeater2
                       model:  rows
                            MineButton { id: mb
                                            height: 20
                                            cell_index: index
                                            text: index * rows //+ repeater.index
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
    }
}
