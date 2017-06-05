#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <iostream>
#include <stdlib.h>     /* srand, rand */
#include <time.h>
#include <assert.h>
#include <set>

#include <QObject>
#include <QMetaType>
#include <QtQml>

class GameLogic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(unsigned getNRows READ getNRows WRITE setRows NOTIFY nRowsChanged)
    Q_PROPERTY(unsigned getNCols READ getNCols WRITE setCols NOTIFY nColsChanged)
    Q_PROPERTY(int getTime READ getTime WRITE setTime NOTIFY gameTimeChanged)
    Q_PROPERTY(bool gameStarted READ gameState WRITE setgameState NOTIFY gameStateChanged)

public:
    GameLogic(QObject *parent = 0);
    virtual ~GameLogic();

    Q_INVOKABLE void reset();
    Q_INVOKABLE void setup();
    Q_INVOKABLE bool gameOver();

    Q_INVOKABLE void startTimer();
    Q_INVOKABLE int getTime();
    Q_INVOKABLE void setTime(int i);

    Q_INVOKABLE unsigned getNRows();
    Q_INVOKABLE unsigned getNCols();
    Q_INVOKABLE void setRows(unsigned i);
    Q_INVOKABLE void setCols(unsigned i);
    Q_INVOKABLE void setBombs(unsigned i);


    //bool gameState();
    Q_INVOKABLE bool gameState();
    Q_INVOKABLE void setgameState(bool i);

    Q_INVOKABLE void assignBombs();
    Q_INVOKABLE bool isBomb(int index);
    Q_INVOKABLE unsigned indexFromIJ(unsigned i, unsigned j);
    Q_INVOKABLE unsigned bombNeighbors(unsigned index);

    void cleanUp();
    Q_INVOKABLE void startGame();

    unsigned nRows;
    unsigned nCols;
    unsigned nBombs;
    unsigned nRevealed;
    int gameTime;

    void victoryCheck();
    Q_INVOKABLE void incReveal();
    void getHighscores();
    Q_INVOKABLE void setDifficulty(unsigned n, unsigned m, unsigned b);

signals:
    void nRowsChanged(unsigned);
    void nColsChanged(unsigned);
    void nBombsChanged(unsigned);
    void gameStateChanged(bool);
    void gameTimeChanged(bool);
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
