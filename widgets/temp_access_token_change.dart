import 'package:flutter/material.dart';

class TempAccessTokenChange extends StatefulWidget {
  final Function changeTempSensorAccessToken;
  final String tempSensorAccessToken;
  TempAccessTokenChange(
      this.changeTempSensorAccessToken, this.tempSensorAccessToken);

  @override
  State<TempAccessTokenChange> createState() => _TempAccessTokenChangeState();
}

class _TempAccessTokenChangeState extends State<TempAccessTokenChange> {
  final _ATController = TextEditingController();

  @override
  void initState() {
    _ATController.text = widget.tempSensorAccessToken.toString();
    super.initState();
  }

  void _change() {
    if (_ATController.text.isEmpty) {
      return;
    }
    widget.changeTempSensorAccessToken(_ATController.text.toString());
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Temperature Sensor Access Token',
          ),
          controller: _ATController,
          onSubmitted: (_) => _change(),
        ),
        ElevatedButton(
          child: Text('Change Access Token'),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color?>(
                  Theme.of(context).textTheme.button?.color),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor)),
          onPressed: _change,
        ),
      ],
    );
  }
}
