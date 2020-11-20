#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QDialog>
#include <QTimer>
#include <QTime>
#include <QDebug>
#include <QTableWidgetItem>
#include "trainprogram.h"
#include "domyostreadmill.h"
#include "sessionline.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QDialog
{
    Q_OBJECT

public:
    QList<SessionLine> Session;
    explicit MainWindow(bluetooth* t);
    explicit MainWindow(bluetooth* t, QString trainProgram);
    ~MainWindow();

private:
    void addEmptyRow();
    void load(bluetooth* device);
    void loadTrainProgram(QString fileName);
    void createTrainProgram(QList<trainrow> rows);    
    bool editing = false;
    trainprogram* trainProgram = 0;

    Ui::MainWindow *ui;
    QTimer *timer;

    bluetooth* bluetoothManager;

private slots:
    void update();
    void on_tableWidget_cellChanged(int row, int column);
    void on_tableWidget_currentItemChanged(QTableWidgetItem *current, QTableWidgetItem *previous);
    void on_save_clicked();
    void on_load_clicked();
    void on_reset_clicked();
    void on_stop_clicked();
    void on_start_clicked();
    void on_groupTrain_clicked();
    void on_fanSpeedMinus_clicked();
    void on_fanSpeedPlus_clicked();
    void on_difficulty_valueChanged(int value);
    void trainProgramSignals();
    void on_speedMinus_clicked();
    void on_speedPlus_clicked();
    void on_inclinationMinus_clicked();
    void on_inclinationPlus_clicked();
    void on_resistanceMinus_clicked();
    void on_resistancePlus_clicked();
    void on_chart_clicked();
};

#endif // MAINWINDOW_H
