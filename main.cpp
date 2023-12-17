#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <Spix/QtQmlBot.h>
#include <Spix/Events/SwipeDirection.h>
#include <iostream>

#include <QtQml/qqmlengine.h>
#include <QtQml/qqmlproperty.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

class MyTests : public spix::TestServer {
protected:
    void executeTest() override

    {
        spix::Point p1(1200,450);
        spix::Point p2(1000,250);
        spix::Point p3(1300, 550);
        spix::Point p4(1500, 750);
        std::tuple<spix::Point,spix::Point> finger1(p1,p2);
        std::tuple<spix::Point,spix::Point> finger2(p4,p3);
        std::vector touchpoints {
            finger1,
            finger2
        };
     /*   wait(std::chrono::milliseconds(2000));
        pinch("mainWindow/firstPage/img", touchpoints);*/
        wait(std::chrono::milliseconds(20000));
        rotate(spix::ItemPath("mainWindow/firstPage/img"), 90);
        /*wait(std::chrono::milliseconds(2000));
        tap("mainWindow/firstPage/button", 0);
        tap("mainWindow/firstPage/button", 5000);
        wait(std::chrono::milliseconds(2000));
        tap("mainWindow/firstPage/check", 0);
        wait(std::chrono::milliseconds(2000));
        swipe(spix::ItemPath("mainWindow/firstPage/slider"), spix::SwipeDirection::RIGHT);
        wait(std::chrono::milliseconds(2000));*/
    }
};




int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    //// SPIX initialisation
    MyTests tests;
    //spix::AnyRpcServer server(8085);
    auto bot = new spix::QtQmlBot();
    bot->runTestServer(tests);


    int rc = app.exec();

    delete bot;
    return rc;
}
