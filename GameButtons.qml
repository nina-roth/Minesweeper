import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Rectangle {
    property alias checkBoxEasy: checkBoxEasy
    property alias checkBoxInterm: checkBoxInterm
    property alias checkBoxHard: checkBoxHard
    property alias buttonNew: buttonNew
    property alias buttonQuit: buttonQuit
    width: 400
    height: 25
    transformOrigin: Item.Center
    CheckBox {
        id: checkBoxEasy
        x: 109
        y: 3
        text: qsTr("Easy")
        checked: true
        onClicked: {
            checkBoxEasy.checked = true
            checkBoxInterm.checked = false
            checkBoxHard.checked = false
            logic.setDifficulty( 9, 9, 10 );
            logic.startGame();
        }
    }

    CheckBox {
        id: checkBoxInterm
        x: 171
        y: 3
        text: qsTr("Intermediate")
        checked: false
        onClicked: {
            checkBoxEasy.checked = false
            checkBoxInterm.checked = true
            checkBoxHard.checked = false
            logic.setDifficulty( 16, 16, 40 );
            logic.startGame();
        }
    }

    CheckBox {
        id: checkBoxHard
        x: 279
        y: 3
        text: qsTr("Hard")
        checked: false
        onClicked: {
            checkBoxEasy.checked = false
            checkBoxInterm.checked = false
            checkBoxHard.checked = true
            root.width = 800 //hard-coded...
            root.height = 460 //hard-coded...
            logic.setDifficulty( 16, 30, 99 );
            logic.startGame();
        }
    }

    Button {
        id: buttonNew
        x: 0
        y: 0
        text: qsTr("New Game")
        onClicked: {
            logic.startGame();
        }
    }

    Button {
        id: buttonQuit
        x: 339
        y: 0
        text: qsTr("Quit")
        onClicked: {
            Qt.quit();
        }
    }

}
