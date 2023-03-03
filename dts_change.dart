import 'package:flutter/material.dart';

class DtsChange extends StatefulWidget {
  final Function _changeDTS;
  const DtsChange(this._changeDTS);

  @override
  State<DtsChange> createState() => _DtsChangeState();
}

class _DtsChangeState extends State<DtsChange> {
  final _DTSController = TextEditingController();

  void _change() {
    if (_DTSController.text.isEmpty) {
      return;
    }
    widget._changeDTS(double.parse(_DTSController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Data Transmission Speed',
          ),
          controller: _DTSController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => _change(),
        ),
        ElevatedButton(
          child: Text('Change DTS'),
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
