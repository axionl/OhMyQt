#include "curlhelper.h"

Task::Task(const std::string& url, const std::string& file_name)
    : url(url)
    , file_name(file_name)
{
}

CurlHelper::CurlHelper(QObject* parent)
    : QObject(parent)
{
    curl_global_init(CURL_GLOBAL_DEFAULT);
}

CurlHelper::~CurlHelper()
{
    p_thread->quit();
    p_thread->wait();
    p_thread->deleteLater();

    delete p_thread;
    p_thread = nullptr;

    curl_global_cleanup();
}

void CurlHelper::download(const QString& url)
{
    p_thread = new QThread();
    auto worker = new Worker();

    worker->moveToThread(p_thread);

    connect(this, &CurlHelper::operate, worker, &Worker::run);
    connect(p_thread, &QThread::finished, worker, &QObject::deleteLater);
    connect(worker, &Worker::progressChanged, this, &CurlHelper::setProgress);
    connect(worker, &Worker::done, this, &CurlHelper::handleResults);

    p_thread->start();

    emit operate(url);
}

void CurlHelper::handleResults(const QString& msg)
{
    QFileInfo file(msg);
    if (file.exists()) {
        QUrl url = QUrl::fromLocalFile(file.absoluteFilePath());
        setResult(url.url());
    }
}

void Worker::run(const QString& msg)
{
    if (is_running == false) {
        is_running = true;
    } else {
        return;
    }

    CURL* handle = curl_easy_init();

    Task task = { msg.toStdString().c_str(), msg.split("/").takeLast().toStdString().c_str() };

    curl_easy_setopt(handle, CURLOPT_URL, task.url.c_str());

    curl_easy_setopt(handle, CURLOPT_XFERINFOFUNCTION, xferinfo);

    curl_easy_setopt(handle, CURLOPT_XFERINFODATA, this);

    curl_easy_setopt(handle, CURLOPT_NOPROGRESS, 0L);

    static std::ofstream file(task.file_name, std::ios::binary);

    curl_easy_setopt(
        handle, CURLOPT_WRITEFUNCTION, saveToFileCallback);

    curl_easy_setopt(
        handle, CURLOPT_WRITEDATA, reinterpret_cast<void*>(&file));

    curl_easy_perform(handle);

    curl_easy_cleanup(handle);

    file.close();

    emit done(QString::fromStdString(task.file_name));

    is_running = false;
}

size_t Worker::saveToFileCallback(void* contents, size_t size, size_t nmemb, void* p_ofstream)
{
    size_t real_size = size * nmemb;

    auto file = reinterpret_cast<std::ofstream*>(p_ofstream);
    file->write(reinterpret_cast<const char*>(contents), real_size);

    return real_size;
}

int Worker::xferinfo(void* p, curl_off_t dltotal, curl_off_t dlnow, curl_off_t ultotal, curl_off_t ulnow)
{
    auto worker = static_cast<Worker*>(p);

    if (!qFuzzyCompare(dltotal, 0.0)) {
        double result = (double)dlnow / dltotal;
        worker->setProgress(result);
    }

    return 0;
}

const QString& CurlHelper::result() const
{
    return m_result;
}

void CurlHelper::setResult(const QString& newResult)
{
    if (m_result == newResult)
        return;

    m_result = newResult;

    emit resultChanged(m_result);
}

double CurlHelper::progress() const
{
    return m_progress;
}

void CurlHelper::setProgress(double newProgress)
{
    if (qFuzzyCompare(m_progress, newProgress))
        return;

    m_progress = newProgress;

    emit progressChanged(m_progress);
}

double Worker::progress() const
{
    return m_progress;
}

void Worker::setProgress(double newProgress)
{
    if (qFuzzyCompare(m_progress, newProgress))
        return;

    m_progress = newProgress;

    emit progressChanged(m_progress);
}
