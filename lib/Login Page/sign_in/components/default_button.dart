import '../../../Others/constants/constants.dart';

import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    this.text,
    this.press,
  });
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: popPinsRegular,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: kPrimaryColor_1,
          ),
        ),
      ),
    );
  }
}
