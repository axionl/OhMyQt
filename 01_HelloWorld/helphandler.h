#ifndef HELPHANDLER_H
#define HELPHANDLER_H

#include <QObject>
#include <QUrl>
#include <QString>
#include <QDesktopServices>
#include <QDebug>

class HelpHandler : public QObject
{
    Q_OBJECT
public:
    explicit HelpHandler(QObject *parent = nullptr);

public slots:
    void openUrl(const QUrl& url);

signals:

};

#endif // HELPHANDLER_H
