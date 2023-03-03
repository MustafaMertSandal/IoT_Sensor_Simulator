import 'package:flutter/material.dart';

class UrlChange extends StatefulWidget {
  final Function changeURL;
  UrlChange(this.changeURL);

  @override
  State<UrlChange> createState() => _UrlChangeState();
}

class _UrlChangeState extends State<UrlChange> {
  final _URLController = TextEditingController();

  void _change() {
    if (_URLController.text.isEmpty) {
      return;
    }
    widget.changeURL(_URLController.text.toString());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'URL',
          ),
          controller: _URLController,
          onSubmitted: (_) => _change(),
        ),
        ElevatedButton(
          child: Text('Change URL'),
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
