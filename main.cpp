#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<QTimer>("myTimer", 1, 0, "QTimer");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
