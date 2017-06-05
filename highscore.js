.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var maxEntries = 5;
//var minTimeEasy = 9999999;

function db(){
    return Sql.LocalStorage.openDatabaseSync("MS", "2.0", "Minesweeper Highscores", 100);
}

function tableExists(tx){
    tx.executeSql('CREATE TABLE IF NOT EXISTS Highscores(difficulty TEXT, time INT)');
}

function getHighscores(diff) {
    db().transaction(
                function(tx){
                    tableExists(tx);
                    var ret = tx.executeSql('SELECT difficulty,time FROM Highscores WHERE difficulty =? ORDER BY time', [diff]);
                    var outp = ""
                    if (ret.rows.length > 0) {
                        //for (var i = 0; i < ret.rows.length; i++) {
                        for (var i = 0; i < ret.rows.length && i < maxEntries; i++) {
                            outp += ret.rows.item(i).difficulty + ", " + ret.rows.item(i).time + "\n"
                        }
                    }
                    //console.log("Highscore data:");
                    console.log(outp);
                }
    )
}

function isNewHighscore(newTime, oldTime){

    if(newTime <= oldTime){
        console.log("New highscore!");
    }

}

function saveHighscores(diff, time) {
    db().transaction(
                function(tx){
                    tableExists(tx);
                    //console.log(diff);
                    //console.log(time);
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
