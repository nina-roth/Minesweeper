#include <QApplication>
#include <QQmlApplicationEngine>
#import "gamelogic.h"

int main(int argc, char *argv[])
{
    //QApplication::instance()->setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication::instance()->setAttribute(Qt::AA_DontUseNativeMenuBar);
    QApplication app(argc, argv);

    qmlRegisterType<GameLogic>("my.extensions", 1, 0, "GameLogic");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
