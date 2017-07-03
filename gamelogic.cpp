#include "gamelogic.h"
#include <stdlib.h>     /* srand, rand */
#include <time.h>
#include <assert.h>
#include <set>

GameLogic::GameLogic(QObject *parent) : QObject(parent){
    nRows = 9;
    nCols = 9;
    nBombs = 10;
    gameStarted = false;
    diffString = "Easy";
    startGame();
}

unsigned GameLogic::getNRows(){
    return nRows;
}

unsigned GameLogic::getNCols(){
    return nCols;
}

void GameLogic::setNRows(const unsigned i){
    nRows = i;
    emit nRowsChanged(nRows);
}

void GameLogic::setNCols(const unsigned i){
    nCols = i;
    emit nColsChanged(nCols);
}

unsigned GameLogic::getNBombs(){
    return nBombs;
}

void GameLogic::setNBombs(const unsigned b){
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

unsigned GameLogic::bombNeighbors(unsigned index){ //could be simplified (by using ints)
    unsigned i =  index / nCols;
    unsigned j = index - (i * nCols);

    unsigned sum = 0;
    if (i == 0){ //left border

        if(j == 0){//top

            sum = ( isBombArray[indexFromIJ( i,  j + 1)] + isBombArray[indexFromIJ( i + 1,  j)]
                    + isBombArray[indexFromIJ( i + 1,  j + 1)] );

        }
        else if (j == nRows - 1){//bottom

            sum = ( isBombArray[indexFromIJ( i,  j - 1)] + isBombArray[indexFromIJ( i + 1,  j - 1)]
                    + isBombArray[indexFromIJ( i + 1,  j)] );

        }
        else{//central in j

            sum = ( isBombArray[indexFromIJ( i,  j - 1)] + isBombArray[indexFromIJ( i,  j + 1)]
                    + isBombArray[indexFromIJ( i + 1 ,  j - 1 )] + isBombArray[indexFromIJ( i + 1 , j)]
                    + isBombArray[indexFromIJ( i + 1 ,  j + 1 )] );

        }


    }
    else if (i == nCols - 1){ //right border

        if(j == 0){//top

            sum = ( isBombArray[indexFromIJ( i - 1, j )] + isBombArray[indexFromIJ( i - 1, j + 1 )]
                    + isBombArray[indexFromIJ( i, j + 1 )] );

        }
        else if (j == nRows - 1){//bottom

            sum = ( isBombArray[indexFromIJ( i , j - 1 )] + isBombArray[indexFromIJ( i - 1, j - 1 )]
                    + isBombArray[indexFromIJ( i- 1, j )] );

        }
        else{//central in j

            sum = ( isBombArray[indexFromIJ( i, j + 1 )] + isBombArray[indexFromIJ(i, j - 1 )]
                    + isBombArray[indexFromIJ( i - 1, j + 1 )] + isBombArray[indexFromIJ( i - 1, j )]
                    + isBombArray[indexFromIJ( i - 1, j - 1 )] );

        }


    }
    else{//central in i

        if(j == 0){//top

            sum = ( isBombArray[indexFromIJ( i - 1 , j )] + isBombArray[indexFromIJ( i - 1, j + 1 )]
                    + isBombArray[indexFromIJ( i, j + 1 )] + isBombArray[indexFromIJ( i + 1, j )]
                    + isBombArray[indexFromIJ( i + 1, j + 1 )]);

        }
        else if (j == nRows - 1){//bottom

            sum = ( isBombArray[indexFromIJ( i - 1, j  )] + isBombArray[indexFromIJ( i - 1, j - 1 )]
                    + isBombArray[indexFromIJ( i, j - 1 )] + isBombArray[indexFromIJ( i + 1, j )]
                    + isBombArray[indexFromIJ( i + 1, j - 1 )]);

        }
        else{//central in i and j: all 9 cells - we don't subtract the central one because if it's a bomb we don't need that number anyway

            for(unsigned ii = i - 1; ii < i + 2; ii++){
                for(unsigned jj = j - 1; jj < j + 2; jj++){
                    sum+= isBombArray[indexFromIJ( ii, jj )];
                }
            }

            //sum -= isBombArray[index];

        }

    }

    return sum;
}

void GameLogic::assignBombs()
{
    srand(time(NULL));
    unsigned in = 0, im = 0;
    isBombArray = std::vector<bool> (total_size, false);
    bombIndex.clear();

    for (in = 0; in < total_size && im < nBombs; ++in) {
        unsigned rn = total_size - in;
        unsigned rm = nBombs - im;
        if ( rand() % rn < rm){ bombIndex.push_back(in); im++;}
    }

    std::set<unsigned> s( bombIndex.begin(), bombIndex.end() );
    assert(s.size() == nBombs); //assert uniqueness of random values
    //std::cout << "Sanity check! "<< s.size() << " should be equal to: "<< nBombs << std::endl;
    for(auto &i: bombIndex){ isBombArray[i] = true;}
}

void GameLogic::setGameState(bool tf){
    gameStarted = tf;
    emit gameStateChanged(gameStarted);
}

//void GameLogic::reset(){
//    nRevealed = 0;
//    emit gameReset();
//}

//void GameLogic::setup(){
//    nRevealed = 0;
//    emit gameSetup();
//}

void GameLogic::victoryCheck(){
    if(nRevealed == total_size - nBombs ){
        emit won();
    }
}

void GameLogic::startGame(){
    nRevealed = 0;
    total_size = nRows * nCols;
    assignBombs();
    //setup();
    emit gameSetup();
}

void GameLogic::setDifficulty(unsigned r, unsigned c, unsigned b, QString s){
    setNRows(r); //use set so this propagates through the program!
    setNCols(c);
    setNBombs(b);
    setDiff(s);
}


//bool GameLogic::gameState(){
//    return gameStarted;
//}
