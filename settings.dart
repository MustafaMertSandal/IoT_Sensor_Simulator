import 'package:flutter/material.dart';
import 'package:iot_sensor_simulator/widgets/dts_change.dart';
import 'package:iot_sensor_simulator/widgets/url_change.dart';

class Settings extends StatelessWidget {
  final Function changeURL;
  final Function changeDTS;
  Settings(this.changeURL, this.changeDTS);

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
              UrlChange(changeURL),
              DtsChange(changeDTS),
            ],
          ),
        ),
      ),
    );
  }
}
