import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2


Rectangle {
                //width: 400; height: 400; color: "black"
                //property alias row_num: grid.rows
                //property alias col_num: grid.columns
                //property alias cell_height: rep.height
                anchors.fill: parent

                property int n_rows
                property int n_cols
                property int cell_height: parent.height/n_rows

                Grid {
                    id: grid
                    rows: n_rows; columns: n_cols; spacing: 0

                    Repeater { id: rep
                               model: n_rows * n_cols
                               MineButton { id: mb
                                            height: cell_height
                                            cell_index: index
                                            isBomb: logic.isBomb(cell_index)
                                            bombNeighbors: logic.bombNeighbors(cell_index)
                                            cell_y: index/n_cols
                                            cell_x: index - (cell_y * n_cols)
                               }
                    }
                }

                function neighborReveal(m, n){
                    for(var x = m - 1; x< m + 2; x++){
                        for(var y = n - 1; y< n + 2; y++){
                            if(x>=0 && x< n_cols && y>=0 && y< n_rows){
                                rep.itemAt(y*n_cols+x).reveal("Cell");
                            }
                        }
                    }
                }

                function revealBombs(){
                    for (var m = 0; m < n_cols; m++) {
                        for (var n = 0; n < n_rows; n++) {
                            if(logic.isBomb(n*n_cols+m) == true){
                                rep.itemAt(n*n_cols+m).reveal("Bomb");
                            }
                        }
                     }
                }

                function revealCells(){
                    for (var m = 0; m < n_cols; m++) {
                        for (var n = 0; n < n_rows; n++) {
                            if(logic.isBomb(n*n_cols+m) == false){
                                rep.itemAt(n*n_cols+m).reveal("Cells");
                            }
                        }
                     }
                }

                function revealFlags(){
                    for (var m = 0; m < n_cols; m++) {
                        for (var n = 0; n < n_rows; n++) {
                            if(logic.isBomb(n*n_cols+m) == true){
                                rep.itemAt(n*n_cols+m).reveal("Flag");
                            }
                        }
                     }
                }

                function gridReset(){
                    for (var m = 0; m < n_cols; m++) {
                        for (var n = 0; n < n_rows; n++) {
                           rep.itemAt(n*n_cols+m).cellReset();
                        }
                    }
                }

                function gridSetup(){
                    for (var m = 0; m < n_cols; m++) {
                        for (var n = 0; n < n_rows; n++) {
                           rep.itemAt(n*n_cols+m).cellSetup(n*n_cols+m);
                        }
                    }
                }
}
