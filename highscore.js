.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var maxEntries = 5;
var high = 0;
var allScores;

function db(){
    return Sql.LocalStorage.openDatabaseSync("Minesweeper", "2.0", "Minesweeper Highscores", 100);
}

function tableExists(tx){
    tx.executeSql('CREATE TABLE IF NOT EXISTS Highscores(difficulty TEXT, time INT)');
}

function getallHighscores(){
    var t1 = getHighscores('Easy');
    var t2 = getHighscores('Intermediate');
    var t3 = getHighscores('Advanced');
    var t4 = getHighscores('Custom');
    if(t1 || t2 || t3 || t4){
        //allScores = "Easy: "+ t1 + "\n" + "Intermediate: "+ t2 + "\n" + "Advanced: "+ t3 + "Custom: " + t4;
        allScores = t1 + "\n" + t2 + "\n" + t3 + "\n" + t4;
    }
    else{allScores = "No highscores yet!";}
}

function getHighscores(diff) {
    var textoutp;
    db().transaction(
                function(tx){
                    tableExists(tx);
                    var ret = tx.executeSql('SELECT difficulty,time FROM Highscores WHERE difficulty =? ORDER BY time', [diff]);
                    textoutp = ""
                    if (ret.rows.length > 0) {
                        for (var i = 0; i < ret.rows.length && i < maxEntries; i++) {
                            textoutp += ret.rows.item(i).difficulty + ": " + ret.rows.item(i).time + "\n"
                        }
                    }
                }
    )
    return textoutp;
}

function isNewHighscore(newTime, oldTime){

    if(newTime <= oldTime){
        high = newTime;
    }

    else{high = -1;}
}

function saveHighscores(diff, time) {
    db().transaction(
                function(tx){
                    tableExists(tx);
                    tx.executeSql('INSERT INTO Highscores VALUES(?, ?)', [ diff, time ]);
                    var ret = tx.executeSql('SELECT difficulty,time FROM Highscores WHERE difficulty =? ORDER BY time', [diff]);
                    isNewHighscore(time, ret.rows.item(0).time);
                    if (ret.rows.length > maxEntries){
                        tx.executeSql('DELETE FROM HighScores WHERE difficulty =? AND time > ?', [diff, ret.rows.item(maxEntries).time]);
                    }
                }
    )
}

function resetHighscores() {
    db().transaction(
                function(tx){
                    tableExists(tx);
                    tx.executeSql('DELETE FROM Highscores');
                }
    )
}
