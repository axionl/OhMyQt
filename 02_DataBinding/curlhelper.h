#ifndef CURLHELPER_H
#define CURLHELPER_H

#include "curl/curl.h"
#include <QFileInfo>
#include <QObject>
#include <QThread>
#include <QUrl>
#include <fstream>
#include <string>

struct Task {
    std::string url;
    std::string file_name;

    Task(const std::string& url, const std::string& file_name = "download.tmp");
};

class Worker : public QObject {
    Q_OBJECT
    Q_PROPERTY(double progress READ progress WRITE setProgress NOTIFY progressChanged)
public:
    double progress() const;

public slots:
    void run(const QString& msg);

    void setProgress(double newProgress);

signals:
    void done(const QString& msg);

    void progressChanged(double progress);

private:
    static size_t
    saveToFileCallback(void* contents,
        size_t size,
        size_t nmemb,
        void* p_ofstream

    );

    static int xferinfo(void* p,
        curl_off_t dltotal, curl_off_t dlnow,
        curl_off_t ultotal, curl_off_t ulnow);

    double m_progress;
    bool is_running = false;
};

class CurlHelper : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString result READ result WRITE setResult NOTIFY resultChanged)
    Q_PROPERTY(double progress READ progress WRITE setProgress NOTIFY progressChanged)
public:
    CurlHelper(QObject* parent = nullptr);

    ~CurlHelper();

    Q_INVOKABLE void download(const QString& url);
    const QString& result() const;

    double progress() const;

public slots:
    void handleResults(const QString& msg);

    void setResult(const QString& newResult);

    void setProgress(double newProgress);

signals:
    void operate(const QString&);

    void resultChanged(const QString& result);

    void progressChanged(double progress);

private:
    QThread* p_thread;
    QString m_result;
    double m_progress;
};

#endif // CURLHELPER_H
