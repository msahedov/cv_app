import '../../Others/constants/constants.dart';
import '../../Others/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  ProfileMenu({
    @required this.text,
    @required this.icon,
    this.press,
  });

  final String icon;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
    const EdgeInsets btnPadding = EdgeInsets.all(20);

    return Padding(
      padding: padding,
      child: FlatButton(
        padding: btnPadding,
        shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: borderRadius),
        color: Colors.white,
        onPressed: press,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                icon,
                color: kPrimaryColor_1,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
                flex: 10,
                child: Text(
                  text,
                  style: buttonTextStyle,
                )),
          ],
        ),
      ),
    );
  }
}
