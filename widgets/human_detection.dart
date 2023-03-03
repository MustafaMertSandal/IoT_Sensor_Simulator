import 'package:flutter/material.dart';

class HumanDetection extends StatelessWidget {
  final bool detected;
  final VoidCallback changeStatus;

  HumanDetection(this.detected, this.changeStatus);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 6,
          fit: FlexFit.tight,
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20, left: 20),
            child: FittedBox(
              child: Text(
                'Human Detection:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Theme.of(context).primaryColor),
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
            child: TextButton(
              child: Text(
                detected ? 'True' : 'False',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.button?.color,
                ),
              ),
              onPressed: changeStatus,
            ),
          ),
        ),
      ],
    );
  }
}
