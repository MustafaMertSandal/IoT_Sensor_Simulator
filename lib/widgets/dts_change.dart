import 'package:flutter/material.dart';

class DtsChange extends StatefulWidget {
  final Function _changeDTS;
  final int dts;

  const DtsChange(this._changeDTS, this.dts);

  @override
  State<DtsChange> createState() => _DtsChangeState();
}

class _DtsChangeState extends State<DtsChange> {
  final _DTSController = TextEditingController();

  @override
  void initState() {
    _DTSController.text = widget.dts.toString();
    super.initState();
  }

  void _change() {
    if (_DTSController.text.isEmpty) {
      return;
    }
    widget._changeDTS(int.parse(_DTSController.text));
    FocusManager.instance.primaryFocus?.unfocus();
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
