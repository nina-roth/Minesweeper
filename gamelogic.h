#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <iostream>
#include <stdlib.h>     /* srand, rand */
#include <time.h>
#include <assert.h>
#include <set>


//#include <QtCore/qobject.h>
#include <QObject>
#include <QMetaType>

class GameLogic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(unsigned getNRows READ getNRows WRITE setRows NOTIFY nRowsChanged) //all "value" things are examples only
    Q_PROPERTY(bool gameState READ gameState WRITE setgameState NOTIFY gameStateChanged)

public:
    GameLogic(QObject *parent = 0);
    virtual ~GameLogic();

    Q_INVOKABLE void reset();
    Q_INVOKABLE void setup();
    Q_INVOKABLE bool gameOver();

    Q_INVOKABLE unsigned getNRows();
    Q_INVOKABLE void setRows(unsigned i);
    Q_INVOKABLE void setBombs(unsigned i);

    bool gameState();
    Q_INVOKABLE void setgameState(bool i);

    Q_INVOKABLE void assignBombs();
    Q_INVOKABLE bool isBomb(int index);
    Q_INVOKABLE unsigned indexFromIJ(unsigned i, unsigned j);
    Q_INVOKABLE unsigned bombNeighbors(unsigned index);

    void cleanUp();
    Q_INVOKABLE void startGame();

    unsigned nRows;
    unsigned nBombs;
    unsigned nRevealed;

    std::vector<std::string> color_array = std::vector<std::string> (9, "red");
    Q_INVOKABLE std::string getColor(unsigned i);

    void victoryCheck();
    Q_INVOKABLE void incReveal();
    void createBlock();
    void getHighscores();
    Q_INVOKABLE void setDifficulty(unsigned n, unsigned b);

signals:
    void nRowsChanged(unsigned);
    void nBombsChanged(unsigned);
    void gameStateChanged(bool);
    void won();
    void lost();
    void gameReset();
    void gameSetup();
    void revealBombs();
    void revealCells();

private:
    std::vector<bool> isBombArray;
    std::vector<unsigned> bombIndex;
    unsigned total_size;
    bool gameStarted;
};

#endif // GAMELOGIC_H
