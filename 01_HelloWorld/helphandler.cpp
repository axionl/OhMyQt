#include "helphandler.h"

HelpHandler::HelpHandler(QObject *parent) : QObject(parent)
{

}

void HelpHandler::openUrl(const QUrl &url)
{
    bool err = QDesktopServices::openUrl(url);
    if (err) {
        qDebug() << "Failed to open url";
    }
}
