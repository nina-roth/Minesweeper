#include <QApplication>
#include <QQmlApplicationEngine>
#include "gamelogic.h"

int main(int argc, char *argv[])
{
    //QApplication::instance()->setAttribute(Qt::AA_EnableHighDpiScaling);
    //QApplication::instance()->setAttribute(Qt::AA_DontUseNativeMenuBar);
    QApplication app(argc, argv);

    qmlRegisterType<GameLogic>("my.extensions", 1, 0, "GameLogic");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    //to explicitely set the path where the (Highscore) database is stored:
    engine.setOfflineStoragePath(QString("/Users/nroth/Projects/Qt_folder/Minesweeper/"));
    return app.exec();
}
