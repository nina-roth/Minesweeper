import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

Window {
    id: settingWindow

    flags: Qt.Dialog
    modality: Qt.WindowModal
    width: 400
    height: 160
    minimumHeight: 160
    minimumWidth: 400
    title: "Custom Settings"

    onClosing: {
        //console.log("boom!");
        menu.MenusEnable();
    }

    GridLayout {
        columns: 2
        anchors.fill: parent
        anchors.margins: 10
        rowSpacing: 10
        columnSpacing: 10

        Label {
            text: "Rows"
        }
        TextField {
            id: rows
            text: logic.nRows
            //Layout.fillWidth: true
        }

        Label {
            text: "Columns"
        }
        TextField {
            id: cols
            text: logic.nCols
            //Layout.fillWidth: true
        }

        Label {
            text: "Bombs"
        }
        TextField {
            id: bombs
            text: logic.nBombs
            //Layout.fillWidth: true
        }

        Label {
            text: ""
        }
        Label {
            id: message
            text: "  "
        }

        Item {
            Layout.columnSpan: 2
            Layout.fillWidth: true
            implicitHeight: button.height

            Button {
                id: button
                anchors.centerIn: parent
                text: "Ok"
                onClicked: {
                    message.text = ""
                    if( inputValid() ){
                        console.log("Setting to: "+ rows.text + " "+ cols.text + " " + bombs.text)
                        logic.setDifficulty( rows.text, cols.text, bombs.text, "Custom" );
                        logic.startGame();
                        area.gs = false;
                        timer.reset();
                        settingWindow.close();
                     }
                }

                function inputValid(){
                    return validateDimensions(rows.text) && validateDimensions(cols.text) && validateBombs(bombs.text)
                }

                function validateDimensions(dim){
                    if(dim < 3 || dim > 40){
                        message.text = "# of rows and columns must be >=3"
                        return false
                    }
                    else{return true}
                }

                function validateBombs(value){
                    if(value <= 0 || value >= rows.text * cols.text ){
                        message.text = "# of bombs must be > 0 and < Rows*Columns"
                        return false
                    }
                    else{return true}
                }
            }
//            Button {
//                id: button2
//                anchors.centerIn: parent
//                text: "Cancel"
//                onClicked: {
//                    settingWindow.close();
//                }
//            }
        }
    }
}

//Item{
//        Window {
//            title: "Popup window"
//            width: 400
//            height: 400
//            visible: true
//            flags: Qt.Dialog
//            modality: Qt.ApplicationModal
//            Text {
//                anchors.centerIn: parent
//                text: "Close me to show main window"
//            }
//            TextEdit {

//                width: 240
//                text: "<b>Hello</b> <i>World!</i>"
//                font.family: "Helvetica"
//                font.pointSize: 20
//                color: "blue"
//                focus: true
//            }
//        }

//}






