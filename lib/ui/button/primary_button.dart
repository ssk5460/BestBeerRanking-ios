import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  PrimaryButton({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48,
        width: 240,
        child: RaisedButton(
          onPressed: onPressed,
          color: Colors.lightBlue,
          elevation: 8,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ));
  }
}
