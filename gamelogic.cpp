#include "gamelogic.h"
#include <stdlib.h>     /* srand, rand */
#include <time.h>
#include <assert.h>
#include <set>
#include <stdexcept>

GameLogic::GameLogic(QObject *parent) : QObject(parent){
    nRows = 9;
    nCols = 9;
    nBombs = 10;
    gameStarted = false;
    diffString = "Easy";
    startGame();
}

int GameLogic::getNRows(){
    return nRows;
}

int GameLogic::getNCols(){
    return nCols;
}

void GameLogic::setNRows(const int r){
    if(r < 3){throw std::runtime_error("# of rows must be >=3");}
    nRows = r;
    emit nRowsChanged(nRows);
}

void GameLogic::setNCols(const int c){
    if(c < 3){throw std::runtime_error("# of columns must be >=3");}
    nCols = c;
    emit nColsChanged(nCols);
}

int GameLogic::getNBombs(){
    return nBombs;
}

void GameLogic::setNBombs(const int b){
    if(b <= 0){throw std::runtime_error("# of bombs must be >0");}
    if(b >= nRows * nCols){throw std::runtime_error("# of bombs must be < total # of grid points");}
    nBombs=b;
    emit nBombsChanged(nBombs);
}

void GameLogic::startTimer(){
    m_gameTime = time(NULL);
    gameStarted = true;
}

void GameLogic::setDiff(QString s){
    diffString=s;
}

QString GameLogic::getDiff(){
    return diffString;
}

int GameLogic::getGameTime(){
    int lasted = 0;
    if(gameStarted == true) {lasted = int( time(NULL)-m_gameTime);}
    return lasted;
}

int GameLogic::bombNeighbors(const int index){

    const int y =  index / nCols;
    const int x = index - (y * nCols);

    const int min_i = std::max(x - 1, 0);
    const int max_i = std::min(x + 2, nCols);

    const int min_j = std::max(y - 1, 0);
    const int max_j = std::min(y + 2, nRows);

    int sum = 0;

    for(int i = min_i; i < max_i; i++){
        for(int j = min_j; j < max_j; j++){
            sum+= isBombArray[indexFromIJ( i, j)];
        }
    }

    return sum;

}


void GameLogic::assignBombs()
{
    srand(time(NULL));
    int in = 0, im = 0;
    isBombArray = std::vector<bool> (total_size, false);
    bombIndex.clear();

    for (in = 0; in < total_size && im < nBombs; ++in) {
        int rn = total_size - in;
        int rm = nBombs - im;
        if ( rand() % rn < rm){ bombIndex.push_back(in); im++;}
    }

    std::set<int> s( bombIndex.begin(), bombIndex.end() );
    assert( int(s.size()) == nBombs); //assert uniqueness of random values
    //std::cout << "Sanity check! "<< s.size() << " should be equal to: "<< nBombs << std::endl;
    for(const auto &i: bombIndex){
        isBombArray[i] = true;
    }
}

void GameLogic::setGameState(const bool tf){
    gameStarted = tf;
    emit gameStateChanged(gameStarted);
}


void GameLogic::victoryCheck(){
    if(nRevealed == total_size - nBombs ){
        emit won();
    }
}

void GameLogic::startGame(){
    nRevealed = 0;
    total_size = nRows * nCols;
    assignBombs();
    emit gameSetup();
}

void GameLogic::setDifficulty(const int r, const int c, const int b, QString s){
    setNRows(r); //use set so this propagates through the program!
    setNCols(c);
    setNBombs(b);
    setDiff(s);
}
