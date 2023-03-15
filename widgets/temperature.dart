import 'package:flutter/material.dart';

class Temperature extends StatefulWidget {
  final VoidCallback increaseTemp;
  final VoidCallback decreaseTemp;
  final Function _setTemperature;
  final int temp;

  Temperature(
    this.increaseTemp,
    this.decreaseTemp,
    this._setTemperature,
    this.temp,
  );

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  TextEditingController _tempArea = TextEditingController();

  @override
  void initState() {
    _tempArea.text = widget.temp.toString();
    super.initState();
  }

  void _change() {
    if (_tempArea.text.isEmpty) {
      setState(() {
        _tempArea.text = widget.temp.toString();
      });
    }
    widget._setTemperature(int.parse(_tempArea.text));
  }

  void _decrease() {
    setState(() {
      _tempArea.text = (int.parse(_tempArea.text) - 1).toString();
    });
    widget.decreaseTemp();
  }

  void _increase() {
    setState(() {
      _tempArea.text = (int.parse(_tempArea.text) + 1).toString();
    });
    widget.increaseTemp();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 6,
          fit: FlexFit.tight,
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: FittedBox(
              child: Text(
                'Temperature:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          fit: FlexFit.tight,
          child: Card(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.fromLTRB(0, 20, 40, 20),
            elevation: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 3,
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: TextField(
                              controller: _tempArea,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0.0),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              keyboardType: TextInputType.number,
                              cursorColor:
                                  Theme.of(context).textTheme.button?.color,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).textTheme.button?.color,
                              ),
                              onSubmitted: (_) => _change(),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                '°C',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).textTheme.button?.color,
                                ),
                              )),
                        ]),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).textTheme.button?.color),
                          child: IconButton(
                            onPressed: _decrease,
                            icon: Icon(
                              Icons.remove,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).textTheme.button?.color,
                          ),
                          child: IconButton(
                            onPressed: _increase,
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
