import 'package:flutter/material.dart';
import 'package:iot_sensor_simulator/widgets/dts_change.dart';
import 'package:iot_sensor_simulator/widgets/temp_access_token_change.dart';

import 'detection_access_token_change.dart';

class Settings extends StatelessWidget {
  final Function changeTempSensorAccessToken;
  final Function changeDetectionSensorAccessToken;
  final Function changeDTS;
  final String tempSensorAccessToken;
  final String detectionSensorAccessToken;
  final int dts;

  Settings(
    this.changeTempSensorAccessToken,
    this.changeDetectionSensorAccessToken,
    this.changeDTS,
    this.tempSensorAccessToken,
    this.detectionSensorAccessToken,
    this.dts,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TempAccessTokenChange(
                  changeTempSensorAccessToken, tempSensorAccessToken),
              DetectionAccessTokenChange(
                  changeDetectionSensorAccessToken, detectionSensorAccessToken),
              DtsChange(changeDTS, dts),
            ],
          ),
        ),
      ),
    );
  }
}
