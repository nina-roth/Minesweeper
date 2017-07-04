#ifndef GAMELOGIC_H
#define GAMELOGIC_H

//#include <iostream>

#include <QObject>
#include <QMetaType>
#include <QtQml>

class GameLogic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int nRows READ getNRows WRITE setNRows NOTIFY nRowsChanged)
    Q_PROPERTY(int nCols READ getNCols WRITE setNCols NOTIFY nColsChanged)
    //Q_PROPERTY(int nRows MEMBER m_nRows NOTIFY nRowsChanged)
    Q_PROPERTY(int nBombs READ getNBombs WRITE setNBombs NOTIFY nBombsChanged)
    Q_PROPERTY(int gameTime READ getGameTime MEMBER m_gameTime NOTIFY gameTimeChanged)

    Q_PROPERTY(bool gameStarted READ gameState WRITE setGameState NOTIFY gameStateChanged)
    Q_PROPERTY(QString getDiff READ getDiff WRITE setDiff NOTIFY diffStateChanged)

public:
    GameLogic(QObject *parent = 0);

    Q_INVOKABLE void startTimer();
    Q_INVOKABLE int getGameTime();

    Q_INVOKABLE int getNBombs();
    Q_INVOKABLE void setNBombs(const int b);
    Q_INVOKABLE bool isBomb(const int index){ return isBombArray[index]; }
    Q_INVOKABLE int bombNeighbors(const int index);

    Q_INVOKABLE int getNRows();
    Q_INVOKABLE void setNRows(const int r);

    Q_INVOKABLE int getNCols();
    Q_INVOKABLE void setNCols(const int c);

    Q_INVOKABLE void setDiff(QString s);
    Q_INVOKABLE QString getDiff();

    Q_INVOKABLE void setGameState(const bool tf);
    Q_INVOKABLE void gameOver(){emit lost();}

    Q_INVOKABLE void startGame();
    Q_INVOKABLE void incReveal(){ nRevealed+=1; victoryCheck(); }
    Q_INVOKABLE void setDifficulty(const int r, const int c, const int b, QString s = "Custom");


signals:
    void nRowsChanged(int);
    void nColsChanged(int);
    void nBombsChanged(int);
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
    std::vector<int> bombIndex;
    int total_size;

    bool gameStarted;

    int nBombs;
    int nRows;
    int nCols;

    int m_gameTime;
    int nRevealed;

    QString diffString = "Custom";

    void assignBombs();
    int indexFromIJ(const int i, const int j){ return i + j*nCols; }

    bool gameState(){return gameStarted;}
    void reset(){ nRevealed = 0; emit gameReset();}
    void victoryCheck();
};

#endif // GAMELOGIC_H
