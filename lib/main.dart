import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iot_sensor_simulator/http_request/post_request.dart';
import 'package:iot_sensor_simulator/icons/my_flutter_app_icons.dart';
import 'package:iot_sensor_simulator/widgets/human_detection.dart';
import 'package:iot_sensor_simulator/widgets/settings.dart';
import 'package:iot_sensor_simulator/widgets/temperature.dart';
import 'package:iot_sensor_simulator/widgets/variance_change.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Sensor Simulator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(color: Colors.white),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int temp = 0;
  bool detected = false;
  String tempSensorAccessToken = '-';
  String detectionSensorAccessToken = '-';
  String tempUrl = '-';
  String detectionUrl = '-';
  int dts = 1; //Data Transmission Speed
  int variance = 2;
  bool _turnOnTempSensor = false;
  bool _turnOnDetectionSensor = false;
  Timer? timerPointerTemp;
  Timer? timerPointerDetection;

  void _turnTempSensor(bool val) {
    setState(() {
      _turnOnTempSensor = val;
      if (_turnOnTempSensor) {
        timerPointerTemp = Timer.periodic(
          Duration(seconds: dts),
          (_) {
            PostRequest().postTemperatureData(temp, tempUrl, variance);
          },
        );
      } else {
        timerPointerTemp!.cancel();
      }
    });
  }

  void _turnDetectionSensor(bool val) {
    setState(() {
      _turnOnDetectionSensor = val;
      if (_turnOnDetectionSensor) {
        timerPointerDetection = Timer.periodic(
          Duration(seconds: dts),
          (_) {
            PostRequest().postDetectionData(detected, detectionUrl);
          },
        );
      } else {
        timerPointerDetection!.cancel();
      }
    });
  }

  void _setTemperature(int newTemp) {
    setState(() {
      temp = newTemp;
    });
  }

  void _increaseTemperature() {
    setState(() {
      temp += 1;
    });
  }

  void _decreaseTemperature() {
    setState(() {
      temp -= 1;
    });
  }

  void _changeStatus() {
    setState(() {
      detected = detected == false ? true : false;
    });
  }

  void _changeTempSensorAccessToken(String newTempSensorAccessToken) {
    setState(() {
      tempSensorAccessToken = newTempSensorAccessToken;
      tempUrl =
          'https://demo.thingsboard.io/api/v1/$newTempSensorAccessToken/telemetry';
    });
  }

  void _changeDetectionSensorAccessToken(String newDetectionSensorAccessToken) {
    setState(() {
      detectionSensorAccessToken = newDetectionSensorAccessToken;
      detectionUrl =
          'https://demo.thingsboard.io/api/v1/$newDetectionSensorAccessToken/telemetry';
    });
  }

  void _changeDTS(int newDTS) {
    setState(
      () {
        dts = newDTS;

        if (timerPointerDetection != null) timerPointerDetection!.cancel();

        if (timerPointerTemp != null) timerPointerTemp!.cancel();

        if (_turnOnDetectionSensor) {
          timerPointerDetection = Timer.periodic(
            Duration(seconds: dts),
            (_) {
              PostRequest().postDetectionData(detected, detectionUrl);
            },
          );
        }
        if (_turnOnTempSensor) {
          timerPointerTemp = Timer.periodic(
            Duration(seconds: dts),
            (_) {
              PostRequest().postTemperatureData(temp, tempUrl, variance);
            },
          );
        }
      },
    );
  }

  void _changeVariance(int newVar) {
    setState(() {
      variance = newVar;
    });
  }

  void _settings(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Settings(
            _changeTempSensorAccessToken,
            _changeDetectionSensorAccessToken,
            _changeDTS,
            tempSensorAccessToken,
            detectionSensorAccessToken,
            dts,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('IoT Sensor Simulator'),
      bottom: TabBar(
        indicatorColor: Colors.lime,
        indicatorWeight: 4.0,
        labelColor: Colors.white,
        labelPadding: EdgeInsets.only(top: 10.0),
        unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(
            text: 'Temperature',
            icon: Icon(
              MyFlutterApp.thermometer,
              color: Colors.white,
            ),
            iconMargin: EdgeInsets.only(bottom: 10.0),
          ),
          Tab(
            text: 'Human Detection',
            icon: Icon(
              MyFlutterApp.security_camera,
              color: Colors.white,
            ),
            iconMargin: EdgeInsets.only(bottom: 10.0),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => _settings(context),
        ),
      ],
    );

    final bodyPortrait = TabBarView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
                child: Temperature(
                  _increaseTemperature,
                  _decreaseTemperature,
                  _setTemperature,
                  temp,
                  isLandScape,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.15,
                child: VarianceChange(_changeVariance, variance, isLandScape),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _turnOnTempSensor ? 'Turn On' : 'Turn Off',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Switch.adaptive(
                      value: _turnOnTempSensor,
                      onChanged: (val) {
                        _turnTempSensor(val);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.35,
              ),
              Container(
                alignment: Alignment.center,
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.05,
                child: Text('Temperature Sensor URL: $tempUrl'),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.05,
                alignment: Alignment.center,
                child: Text(
                  'Data Transmission Speed: $dts sec',
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
                child: HumanDetection(
                  detected,
                  _changeStatus,
                ),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _turnOnDetectionSensor ? 'Turn On' : 'Turn Off',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Switch.adaptive(
                      value: _turnOnDetectionSensor,
                      onChanged: (val) {
                        _turnDetectionSensor(val);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.5,
              ),
              Container(
                alignment: Alignment.center,
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.05,
                child: Text('Detection Sensor URL: $detectionUrl'),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.05,
                alignment: Alignment.center,
                child: Text(
                  'Data Transmission Speed: $dts sec',
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final bodyLandScape = TabBarView(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.5,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        child: Temperature(
                            _increaseTemperature,
                            _decreaseTemperature,
                            _setTemperature,
                            temp,
                            isLandScape),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.center,
                        child: VarianceChange(
                            _changeVariance, variance, isLandScape),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.1,
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _turnOnTempSensor ? 'Turn On' : 'Turn Off',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Switch.adaptive(
                      value: _turnOnTempSensor,
                      onChanged: (val) {
                        _turnTempSensor(val);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.1,
                child: Text('Temperature Sensor URL: $tempUrl'),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.1,
                alignment: Alignment.center,
                child: Text(
                  'Data Transmission Speed: $dts sec',
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.4,
                child: HumanDetection(
                  detected,
                  _changeStatus,
                ),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _turnOnDetectionSensor ? 'Turn On' : 'Turn Off',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Switch.adaptive(
                      value: _turnOnDetectionSensor,
                      onChanged: (val) {
                        _turnDetectionSensor(val);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.1,
                child: Text('Detection Sensor URL: $detectionUrl'),
              ),
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.1,
                alignment: Alignment.center,
                child: Text(
                  'Data Transmission Speed: $dts sec',
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: appBar,
        body: isLandScape ? bodyLandScape : bodyPortrait,
      ),
    );
  }
}
