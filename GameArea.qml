import QtQuick 2.0
import my.extensions 1.0

Item {
    id: gameCanvas
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    anchors.fill: parent
    anchors.topMargin: 15
    anchors.bottomMargin: 20
    anchors.leftMargin: 15
    anchors.rightMargin: 20

    signal gridReset
    signal gridSetup
    signal gridBombReveal
    signal gridCellReveal
    signal gridFlagReveal
    property int rows

    ButtonGrid{
        id: mygrid
        n_rows: rows
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    onGridReset: mygrid.gridReset();
    onGridSetup: mygrid.gridSetup();
    onGridBombReveal: mygrid.revealBombs();
    onGridCellReveal: mygrid.revealCells();
    onGridFlagReveal: mygrid.revealFlags();

}
