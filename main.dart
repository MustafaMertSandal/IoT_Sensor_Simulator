import 'package:flutter/material.dart';
import 'package:iot_sensor_simulator/widgets/human_detection.dart';
import 'package:iot_sensor_simulator/widgets/settings.dart';
import 'package:iot_sensor_simulator/widgets/temperature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  double temp = 0;
  bool detected = false;
  String url = '-';
  double dts = 1; //Data Transmission Speed

  void _increaseTemperature() {
    setState(() {
      temp += 2;
    });
  }

  void _decreaseTemperature() {
    setState(() {
      temp -= 2;
    });
  }

  void _changeStatus() {
    setState(() {
      detected = detected == false ? true : false;
    });
  }

  void _changeURL(String newURL) {
    setState(() {
      url = newURL;
    });
  }

  void _changeDTS(double newDTS) {
    setState(() {
      dts = newDTS;
    });
  }

  void _settings(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Settings(
            _changeURL,
            _changeDTS,
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
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => _settings(context),
        ),
      ],
    );

    final bodyLandScape = SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.5,
            child: Temperature(
              _increaseTemperature,
              _decreaseTemperature,
              temp,
            ),
          ),
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
            alignment: Alignment.center,
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.05,
            child: Text('URL: $url'),
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
    );

    final bodyPortrait = SingleChildScrollView(
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
              temp,
            ),
          ),
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
                0.5,
          ),
          Container(
            alignment: Alignment.center,
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.05,
            child: Text('URL: $url'),
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
    );

    return Scaffold(
      appBar: appBar,
      body: isLandScape ? bodyLandScape : bodyPortrait,
    );
  }
}
