import 'package:flutter/material.dart';

class VarianceChange extends StatefulWidget {
  final Function changeVariance;
  final int variance;

  VarianceChange(this.changeVariance, this.variance);

  @override
  State<VarianceChange> createState() => _VarianceChangeState();
}

class _VarianceChangeState extends State<VarianceChange> {
  final _VarianceController = TextEditingController();

  @override
  void initState() {
    _VarianceController.text = widget.variance.toString();
    super.initState();
  }

  void _change() {
    if (_VarianceController.text.isEmpty) {
      _VarianceController.text = widget.variance.toString();
    }
    widget.changeVariance(int.parse(_VarianceController.text));
    FocusManager.instance.primaryFocus?.unfocus();
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
                'Variance:',
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 20, 20, 20),
                  elevation: 6,
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
                          child: Text(
                            '±',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.button?.color,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Container(
                            padding: EdgeInsets.only(right: 15),
                            child: TextField(
                              controller: _VarianceController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0.0),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              keyboardType: TextInputType.number,
                              cursorColor:
                                  Theme.of(context).textTheme.button?.color,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).textTheme.button?.color,
                              ),
                              onSubmitted: (_) => _change(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.only(right: 40),
                  child: ElevatedButton(
                    onPressed: _change,
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(right: 0.0),
                      shape: CircleBorder(),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor:
                          Theme.of(context).textTheme.button?.color,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
