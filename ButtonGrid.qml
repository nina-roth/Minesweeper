import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2


Rectangle {
                //width: 400; height: 400; color: "black"
                property alias row_num: grid.rows
                property alias col_num: grid.columns
                //property alias cell_height: rep.height
                anchors.fill: parent

                property int n_rows
                property int cell_height: parent.height/n_rows

                Grid {
                    id: grid
                    rows: n_rows; columns: n_rows; spacing: 0

                    Repeater { id: rep
                               model: n_rows * n_rows
                               MineButton { id: mb
                                            height: cell_height
                                            cell_index: index
                                            //cell_i: index/grid.rows
                                            //cell_j: index - (cell_i*grid.rows)
                                            //text: cell_i + "." + cell_j
                                            isBomb: logic.isBomb(cell_index)
                                            bombNeighbors: logic.bombNeighbors(cell_index)
                                            //text: cell_index
                                            //right_neighb: -1
                                            //top_neighb: -1
                                            //bottom_neighb: -1
                               }
                    }
                }

}
