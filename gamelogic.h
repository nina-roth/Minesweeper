#ifndef GAMELOGIC_H
#define GAMELOGIC_H

#include <iostream>

#include <QObject>
#include <QMetaType>
#include <QtQml>

class GameLogic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(unsigned nRows READ getNRows WRITE setNRows NOTIFY nRowsChanged)
    Q_PROPERTY(unsigned nCols READ getNCols WRITE setNCols NOTIFY nColsChanged)
    //Q_PROPERTY(unsigned nRows MEMBER m_nRows NOTIFY nRowsChanged)
    Q_PROPERTY(unsigned nBombs READ getNBombs WRITE setNBombs NOTIFY nBombsChanged)
    Q_PROPERTY(int gameTime READ getGameTime MEMBER m_gameTime NOTIFY gameTimeChanged)

    Q_PROPERTY(bool gameStarted READ gameState WRITE setGameState NOTIFY gameStateChanged)
    Q_PROPERTY(QString getDiff READ getDiff WRITE setDiff NOTIFY diffStateChanged)

public:
    GameLogic(QObject *parent = 0);

    Q_INVOKABLE void startTimer();
    Q_INVOKABLE int getGameTime();

    Q_INVOKABLE unsigned getNBombs();
    Q_INVOKABLE void setNBombs(const unsigned b);
    Q_INVOKABLE bool isBomb(const int index){ return isBombArray[index]; }
    Q_INVOKABLE unsigned bombNeighbors(unsigned index);

    Q_INVOKABLE unsigned getNRows();
    Q_INVOKABLE void setNRows(const unsigned r);

    Q_INVOKABLE unsigned getNCols();
    Q_INVOKABLE void setNCols(const unsigned c);

    Q_INVOKABLE void setDiff(QString s);
    Q_INVOKABLE QString getDiff();

    Q_INVOKABLE void setGameState(bool tf);
    Q_INVOKABLE void gameOver(){emit lost();}

    Q_INVOKABLE void startGame();
    Q_INVOKABLE void incReveal(){ nRevealed+=1; victoryCheck(); }
    Q_INVOKABLE void setDifficulty(unsigned r, unsigned c, unsigned b, QString s = "Custom");


signals:
    void nRowsChanged(unsigned);
    void nColsChanged(unsigned);
    void nBombsChanged(unsigned);
    void gameStateChanged(bool);
    void gameTimeChanged(bool);
    void diffStateChanged(bool);
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

    unsigned nBombs;
    unsigned nRows;
    unsigned nCols;

    int m_gameTime;
    unsigned nRevealed;

    QString diffString = "Custom";

    void assignBombs();
    unsigned indexFromIJ(const unsigned i, const unsigned j){ return i * nCols + j; }

    bool gameState(){return gameStarted;}
    void reset(){ nRevealed = 0; emit gameReset();}
    void victoryCheck();
};

#endif // GAMELOGIC_H
