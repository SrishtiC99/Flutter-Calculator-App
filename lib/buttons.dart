import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/main.dart';

class MyButton extends StatelessWidget{
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
  MyButton({this.color, this.textColor,  required this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 20,
      width: 20,
      child: InkWell(
        highlightColor: Colors.grey.shade400,
        splashColor: Colors.grey.shade400,
        onTap: buttonTapped,
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: Text(buttonText,
              style: TextStyle(color: textColor,
                  fontSize: Constants.isAllButtons ? 18 : 25,
                  fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
    final buttons = GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRect(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 0.3,
              ),
              color: color
            ),
            child: Center(
              child: Text(buttonText,
              style: TextStyle(color: textColor,
                  fontSize: Constants.isAllButtons ? 18 : 25,
                  fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ),
      ),
    );
  }
}