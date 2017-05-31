#include "gamelogic.h"

GameLogic::GameLogic(QObject *parent) : QObject(parent){
    nRows = 9;
    nCols = 9;
    nBombs = 10;
    gameStarted = false;
    startGame();
}

GameLogic::~GameLogic(){}

bool GameLogic::isBomb(int index){
    return isBombArray[index];
}

unsigned GameLogic::getNRows(){
    return nRows;
}

unsigned GameLogic::getNCols(){
    return nCols;
}

void GameLogic::setRows(unsigned i){
    nRows = i;
    emit nRowsChanged(nRows);
}

void GameLogic::setCols(unsigned i){
    nCols = i;
    emit nColsChanged(nCols);
}

void GameLogic::setBombs(unsigned i){
    nBombs = i;
    emit nBombsChanged(nBombs);
}

unsigned GameLogic::indexFromIJ(unsigned i, unsigned j){
    return i * nCols + j;
}

unsigned GameLogic::bombNeighbors(unsigned index){ //can be simplified (by using ints)
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

void GameLogic::setgameState(bool i){
    gameStarted = i;
    emit gameStateChanged(gameStarted);
}

void GameLogic::reset(){
    nRevealed = 0;
    emit gameReset();
}

void GameLogic::setup(){
    nRevealed = 0;
    emit gameSetup();
}

//std::string GameLogic::getColor(unsigned i){
//    return color_array[i];
//}

bool GameLogic::gameOver(){
    emit lost();
    gameStarted = false;
    return true;
}

void GameLogic::incReveal(){
    nRevealed +=1;
    victoryCheck();
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
    setup();
    gameStarted = true;
}

void GameLogic::setDifficulty(unsigned n, unsigned m, unsigned b){
    setRows(n);
    setCols(m);
    setBombs(b);
}


bool GameLogic::gameState(){
    return gameStarted;
}
