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
                                            isBomb: logic.isBomb(cell_index)
                                            bombNeighbors: logic.bombNeighbors(cell_index)
                                            cell_x: index/n_rows
                                            cell_y: index - (cell_x * n_rows)
                               }
                    }
                }

                function neighborReveal(m, n){
                    for(var x = m - 1; x< m + 2; x++){
                        for(var y = n - 1; y< n + 2; y++){
                            if(x>=0 && x< n_rows && y>=0 && y< n_rows){
                                    rep.itemAt(x*n_rows+y).reveal("Cell");
                            }
                        }
                    }
                }

                function revealBombs(){
                    for (var m = 0; m < n_rows; m++) {
                        for (var n = 0; n < n_rows; n++) {
                            if(logic.isBomb(m*n_rows+n) == true){
                                rep.itemAt(m*n_rows+n).reveal("Bomb");
                            }
                        }
                     }
                }

                function revealCells(){
                    for (var m = 0; m < n_rows; m++) {
                        for (var n = 0; n < n_rows; n++) {
                            if(logic.isBomb(m*n_rows+n) == false){
                                rep.itemAt(m*n_rows+n).reveal("Cell");
                            }
                        }
                     }
                }

                function gridReset(){
                    for (var m = 0; m < n_rows; m++) {
                        for (var n = 0; n < n_rows; n++) {
                           rep.itemAt(m*n_rows+n).cellReset();
                        }
                    }
                }

                function gridSetup(){
                    for (var m = 0; m < n_rows; m++) {
                        for (var n = 0; n < n_rows; n++) {
                           rep.itemAt(m*n_rows+n).cellSetup(m*n_rows+n);
                        }
                    }
                }
}
