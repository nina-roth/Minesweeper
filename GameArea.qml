import QtQuick 2.0
import my.extensions 1.0

Item {
    id: gameCanvas
    anchors.fill: parent
    anchors.topMargin: 13
    anchors.bottomMargin: 15
    anchors.leftMargin: 25
    anchors.rightMargin: 25

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
