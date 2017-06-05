.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var maxEntries = 5;
var minTime = 0;
var difficulty;

function db(){
    return Sql.LocalStorage.openDatabaseSync("MS", "2.0", "Minesweeper Highscores", 100);
}

function tableExists(tx){
    tx.executeSql('CREATE TABLE IF NOT EXISTS Highscores(name TEXT, score INT)');
}

function getHighscores() {
    //var maxScore = 0;
    db().transaction(
                function(tx){
                    tableExists(tx);
                    var ret = tx.executeSql('SELECT * FROM Highscores ORDER BY time');
                    var outp = ""
                    if (ret.rows.length > 0) {
                        minTime = ret.rows.item(0).time;
                        console.log("min: ", minTime);
                        //for (var i = 0; i < ret.rows.length; i++) {
                        for (var i = 0; i < ret.rows.length && i < maxEntries; i++) {
                            outp += ret.rows.item(i).name + ", " + ret.rows.item(i).time + "\n"
                        }
                    }
                    console.log("Highscore data:");
                    console.log(outp);
                }
    )
    //return maxScore;
}

function newMinTime(time){
    if(time < minTime){
        console.log("New high score!")
        //messageDialog.show("New high score!"); //doesn't work
    }
    saveHighscores("bla", time);
}

function saveHighscores(name, time) {
    db().transaction(
                function(tx){
                    tableExists(tx);
                    tx.executeSql('INSERT INTO Highscores VALUES(?, ?)', [ name, time ]);
                    var ret = tx.executeSql('SELECT * FROM Highscores ORDER BY score DESC');
                    if (ret.rows.length > maxEntries){
                        tx.executeSql("DELETE FROM HighScores WHERE time <= ?", [ret.rows.item(maxEntries).time]);
                    }
                }
    )
}

function resetHighscores() {
    //confirmationDialog.show();
    db().transaction(
                function(tx){
                    tableExists(tx);
                    tx.executeSql('DELETE FROM Highscores');
                }
    )
}
