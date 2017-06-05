import QtQuick 2.0
import my.extensions 1.0

Item {
    id: gameCanvas
    //anchors.horizontalCenter: parent.horizontalCenter
    //anchors.verticalCenter: parent.verticalCenter
    anchors.fill: parent
    anchors.topMargin: 10
    anchors.bottomMargin: 10
    anchors.leftMargin: 10
    anchors.rightMargin: 10

    property alias gs: mygrid.gs

    signal gridReset
    signal gridSetup
    signal gridBombReveal
    signal gridCellReveal
    signal gridFlagReveal
    signal newHighscore
    property int rows
    property int cols

    ButtonGrid{
        id: mygrid
        n_rows: rows
        n_cols: cols
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    onGridReset: mygrid.gridReset();
    onGridSetup: mygrid.gridSetup();
    onGridBombReveal: mygrid.revealBombs();
    onGridCellReveal: mygrid.revealCells();
    onGridFlagReveal: mygrid.revealFlags();


}
