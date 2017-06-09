#include <QString>
#include <QtTest>
#include <QCoreApplication>
#include "/Users/nroth/Projects/Qt_folder/Minesweeper/gamelogic.h"


class Minesweeper_Test : public QObject
{
    Q_OBJECT

public:
    Minesweeper_Test();
    GameLogic logic;

private Q_SLOTS:
    void initTestCase();
    void cleanupTestCase();
    void testCase1();
    void testCase2();
    void testCase3();
    void testCase3_data();
};

Minesweeper_Test::Minesweeper_Test()
{
}

void Minesweeper_Test::initTestCase()
{
    //for example test data creation
}

void Minesweeper_Test::cleanupTestCase()
{
    //for example test data deletion
}

void Minesweeper_Test::testCase1()
{
    QVERIFY2(true, "Failure");
}

void Minesweeper_Test::testCase2()
{
    logic.setDifficulty(16, 20, 10);
    QVERIFY2(logic.getNRows() == 16, "Number of rows is wrong");
    QVERIFY2(logic.getNCols() == 20, "Number of columns is wrong");

}

void Minesweeper_Test::testCase3()
{
    QFETCH(unsigned int, rows);
    QFETCH(unsigned int, cols);
    QFETCH(unsigned int, bombs);

    logic.setDifficulty(rows, cols, bombs);
    QVERIFY2(logic.getNRows() == rows, "Number of rows is wrong");
    QVERIFY2(logic.getNCols() == cols, "Number of columns is wrong");

}

void Minesweeper_Test::testCase3_data()
{
    QTest::addColumn<unsigned int>("rows");
    QTest::addColumn<unsigned int>("cols");
    QTest::addColumn<unsigned int>("bombs");

    QTest::newRow("easy") << 9u << 9u << 10u;
    QTest::newRow("interm") << 16u << 16u << 40u;
    QTest::newRow("hard") << 16u << 30u << 99u;

}

QTEST_MAIN(Minesweeper_Test)

#include "tst_minesweeper_test.moc"
