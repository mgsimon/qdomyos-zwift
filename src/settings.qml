import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

    ScrollView {
        focus: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        id: settingsPane

        Settings {
            id: settings
            property bool bike_heartrate_service: false
            property int bike_resistance_offset: 4
            property int bike_resistance_gain: 1
            property real weight: 75.0
            property real ftp: 200.0
            property bool miles_unit: false
            property bool pause_on_start: false
            property bool bike_cadence_sensor: false
            property string heart_rate_belt_name: "Disabled"

            property bool top_bar_enabled: true

            property bool tile_speed_enabled: true
            property bool tile_inclination_enabled: true
            property bool tile_cadence_enabled: true
            property bool tile_elevation_enabled: true
            property bool tile_calories_enabled: true
            property bool tile_odometer_enabled: true
            property bool tile_pace_enabled: true
            property bool tile_resistance_enabled: true
            property bool tile_watt_enabled: true
            property bool tile_avgwatt_enabled: true
            property bool tile_ftp_enabled: true
            property bool tile_heart_enabled: true
            property bool tile_fan_enabled: true
            property bool tile_jouls_enabled: true
            property bool tile_elapsed_enabled: true
            property bool tile_peloton_resistance_enabled: true

            property bool domyos_treadmill_buttons: false
            property bool domyos_treadmill_distance_display: true

            property real proform_wheel_ratio: 0.33

            property bool toorx_3_0: false
            property bool trx_route_key: false

            property bool bluetooth_relaxed: false
            property bool battery_service: false
            property bool service_changed: false
            property bool virtual_device_enabled: true
            property bool ios_peloton_workaround: true
            property bool android_wakelock: true
        }

        ColumnLayout {
            id: column
            spacing: 0
            anchors.fill: parent

            Label {
                Layout.preferredWidth: parent.width
                id: rebootLabel
                text: qsTr("Reboot the app in order to apply the settings")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Red)                
            }

            Label {
                id: generalLabel
                text: qsTr("General Options")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Grey)
            }

            RowLayout {
                spacing: 10
                Label {
                    id: labelWeight
                    text: qsTr("Player Weight (kg):")
                    Layout.fillWidth: true
                }
                TextField {
                    id: weightTextField
                    text: settings.weight
                    horizontalAlignment: Text.AlignRight
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    onAccepted: settings.weight = text
                }
                Button {
                    id: okWeightButton
                    text: "OK"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: settings.weight = weightTextField.text
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    id: labelFTP
                    text: qsTr("FTP value:")
                    Layout.fillWidth: true
                }
                TextField {
                    id: ftpTextField
                    text: settings.ftp
                    horizontalAlignment: Text.AlignRight
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    onAccepted: settings.ftp = text
                }
                Button {
                    id: okFTPButton
                    text: "OK"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: settings.ftp = ftpTextField.text
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    id: labelHeartRateBelt
                    text: qsTr("Heart Belt Name:")
                    Layout.fillWidth: true
                }
                ComboBox {
                    id: heartBeltNameTextField
                    model: rootItem.bluetoothDevices
                    displayText: settings.heart_rate_belt_name
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onActivated: {
                        console.log("combomodel activated" + heartBeltNameTextField.currentIndex)
                        displayText = heartBeltNameTextField.currentValue
                     }

                }
                Button {
                    id: okHeartBeltNameButton
                    text: "OK"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: settings.heart_rate_belt_name = heartBeltNameTextField.displayText
                }
            }

            Label {
                id: appleWatchLabel
                text: qsTr("Apple Watch users: leave it disabled! Just open the app on your watch")
                font.bold: yes
                font.italic: yes
                font.pixelSize: 8
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Red)
            }

            Button {
                id: refreshHeartBeltNameButton
                text: "Refresh Devices List"
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                onClicked: refresh_bluetooth_devices_clicked();
            }


            SwitchDelegate {
                id: unitDelegate
                text: qsTr("Use Miles unit in UI")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.miles_unit
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.miles_unit = checked
            }

            SwitchDelegate {
                id: pauseOnStartDelegate
                text: qsTr("Pause when App Starts")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.pause_on_start
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.pause_on_start = checked
            }

            Label {
                id: bikeBridgeLabel
                text: qsTr("Bike Bridge Options")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Grey)
            }

            SwitchDelegate {
                id: cadenceSensorDelegate
                text: qsTr("Cadence Sensor (Peloton compatibility)")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.bike_cadence_sensor
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.bike_cadence_sensor = checked
            }

            Label {
                id: zwiftInfoLabel
                text: qsTr("Zwift users: keep this setting off")
                font.bold: yes
                font.italic: yes
                font.pixelSize: 8
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Red)
            }

            SwitchDelegate {
                id: switchDelegate
                text: qsTr("Heart Rate service outside FTMS")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.bike_heartrate_service
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.bike_heartrate_service = checked
            }

            RowLayout {
                spacing: 10
                Label {
                    id: labelBikeResistanceOffset
                    text: qsTr("Zwift Resistance Offset:")
                    Layout.fillWidth: true
                }
                TextField {
                    id: bikeResistanceOffsetTextField
                    text: settings.bike_resistance_offset
                    horizontalAlignment: Text.AlignRight
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    onAccepted: settings.bike_resistance_offset = text
                }
                Button {
                    id: okBikeResistanceOffsetButton
                    text: "OK"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: settings.bike_resistance_offset = bikeResistanceOffsetTextField.text
                }
            }

            RowLayout {
                spacing: 10
                Label {
                    id: labelBikeResistanceGain
                    text: qsTr("Zwift Resistance Gain:")
                    Layout.fillWidth: true
                }
                TextField {
                    id: bikeResistanceGainTextField
                    text: settings.bike_resistance_gain
                    horizontalAlignment: Text.AlignRight
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    onAccepted: settings.bike_resistance_gain = text
                }
                Button {
                    id: okBikeResistanceGainButton
                    text: "OK"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: settings.bike_resistance_gain = bikeResistanceGainTextField.text
                }
            }

            Label {
                id: uiGeneralOptionsLabel
                text: qsTr("General UI Options")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Grey)
            }

            SwitchDelegate {
                id: topBarEnabledDelegate
                text: qsTr("Top Bar Enabled")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.top_bar_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.top_bar_enabled = checked
            }

            Label {
                id: tileOptionsLabel
                text: qsTr("Tiles Options")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Grey)
            }

            SwitchDelegate {
                id: speedEnabledDelegate
                text: qsTr("Speed")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_speed_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_speed_enabled = checked
            }

            SwitchDelegate {
                id: inclinationEnabledDelegate
                text: qsTr("Inclination")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_inclination_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_inclination_enabled = checked
            }

            SwitchDelegate {
                id: cadenceEnabledDelegate
                text: qsTr("Cadence")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_cadence_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_cadence_enabled = checked
            }

            SwitchDelegate {
                id: elevationEnabledDelegate
                text: qsTr("Elevation")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_elevation_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_elevation_enabled = checked
            }

            SwitchDelegate {
                id: caloriesEnabledDelegate
                text: qsTr("Calories")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_calories_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_calories_enabled = checked
            }

            SwitchDelegate {
                id: odometerEnabledDelegate
                text: qsTr("Odometer")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_odometer_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_odometer_enabled = checked
            }

            SwitchDelegate {
                id: paceEnabledDelegate
                text: qsTr("Pace")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_pace_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_pace_enabled = checked
            }

            SwitchDelegate {
                id: resistanceEnabledDelegate
                text: qsTr("Resistance")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_resistance_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_resistance_enabled = checked
            }

            SwitchDelegate {
                id: wattEnabledDelegate
                text: qsTr("Watt")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_watt_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_watt_enabled = checked
            }

            SwitchDelegate {
                id: avgwattEnabledDelegate
                text: qsTr("AVG Watt")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_avgwatt_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_avgwatt_enabled = checked
            }

            SwitchDelegate {
                id: ftpEnabledDelegate
                text: qsTr("FTP %")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_ftp_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_ftp_enabled = checked
            }

            SwitchDelegate {
                id: heartEnabledDelegate
                text: qsTr("Heart")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_heart_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_heart_enabled = checked
            }

            SwitchDelegate {
                id: fanEnabledDelegate
                text: qsTr("Fan")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_fan_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_fan_enabled = checked
            }

            SwitchDelegate {
                id: joulsEnabledDelegate
                text: qsTr("Jouls")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_jouls_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_jouls_enabled = checked
            }

            SwitchDelegate {
                id: elapsedEnabledDelegate
                text: qsTr("Elapsed")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_elapsed_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_elapsed_enabled = checked
            }

            SwitchDelegate {
                id: pelotonResistanceEnabledDelegate
                text: qsTr("Peloton Resistance")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.tile_peloton_resistance_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.tile_peloton_resistance_enabled = checked
            }

            Label {
                id: domyosTreadmillLabel
                text: qsTr("Domyos Treadmill Options")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Grey)
            }

            SwitchDelegate {
                id: domyosTreadmillButtonsDelegate
                text: qsTr("Speed/Inclination Buttons")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.domyos_treadmill_buttons
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.domyos_treadmill_buttons = checked
            }

            SwitchDelegate {
                id: domyosTreadmillDistanceDisplayDelegate
                text: qsTr("Distance on Console")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.domyos_treadmill_distance_display
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.domyos_treadmill_distance_display = checked
            }

            Label {
                id: toorxTreadmillLabel
                text: qsTr("Toorx Treadmill Options")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Grey)
            }

            SwitchDelegate {
                id: toorxRouteKeyDelegate
                text: qsTr("TRX ROUTE KEY Compatibility")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.trx_route_key
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.trx_route_key = checked
            }

            SwitchDelegate {
                id: toorxTreadmill30Delegate
                text: qsTr("Toorx 3.0 Compatibility")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.toorx_3_0
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.toorx_3_0 = checked
            }

            Label {
                id: proformBikeLabel
                text: qsTr("Proform Bike Options")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Grey)
            }

            RowLayout {
                spacing: 10
                Label {
                    id: labelproformBikeWheelRatio
                    text: qsTr("Wheel Ratio:")
                    Layout.fillWidth: true
                }
                TextField {
                    id: proformBikeWheelRatioTextField
                    text: settings.proform_wheel_ratio
                    horizontalAlignment: Text.AlignRight
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    inputMethodHints: Qt.ImhDigitsOnly
                    onAccepted: settings.proform_wheel_ratio = text
                }
                Button {
                    id: okproformBikeWheelRatioButton
                    text: "OK"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    onClicked: settings.proform_wheel_ratio = proformBikeWheelRatioTextField.text
                }
            }

            Label {
                id: experimentalFeatureLabel
                text: qsTr("Experimental Features")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                color: Material.color(Material.Grey)
            }

            SwitchDelegate {
                id: bluetoothRelaxedDelegate
                text: qsTr("Relaxed Bluetooth for mad devices")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.bluetooth_relaxed
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.bluetooth_relaxed = checked
            }

            SwitchDelegate {
                id: batteryServiceDelegate
                text: qsTr("Simulate Battery Service")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.battery_service
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.battery_service = checked
            }

            SwitchDelegate {
                id: serviceChangedDelegate
                text: qsTr("Service Changed Service")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.service_changed
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.service_changed = checked
            }

            SwitchDelegate {
                id: virtualDeviceEnabledDelegate
                text: qsTr("Virtual Device")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.virtual_device_enabled
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.virtual_device_enabled = checked
            }

            SwitchDelegate {
                id: iosPelotonWorkaroundDelegate
                text: qsTr("iOS Peloton Workaround")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.ios_peloton_workaround
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.ios_peloton_workaround = checked
            }

            SwitchDelegate {
                id: androidWakeLockDelegate
                text: qsTr("Android WakeLock")
                spacing: 0
                bottomPadding: 0
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                clip: false
                checked: settings.android_wakelock
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillWidth: true
                onClicked: settings.android_wakelock = checked
            }
        }
    }

/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
