import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoDataErrorPage extends StatelessWidget {
  NoDataErrorPage({this.onTap});
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: textFieldbackColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            "Maglumat alynmady.\nTäzeden synanşyň",
            textAlign: TextAlign.center,
            maxLines: 3,
            presetFontSizes: [20, 18, 16, 14],
            style: TextStyle(
              fontFamily: popPinsRegular,
              color: kPrimaryColor_1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton.icon(
              shape: RoundedRectangleBorder(borderRadius: borderRadius10),
              padding: EdgeInsets.all(10),
              icon: Icon(
                Icons.refresh,
                color: kPrimaryColor,
              ),
              onPressed: onTap,
              color: kPrimaryColor_1,
              label: AutoSizeText(
                "Täzeden synanyş",
                maxLines: 1,
                presetFontSizes: [18, 16, 14],
                style: TextStyle(fontFamily: popPinsSemiBold, color: kPrimaryColor),
              ))
        ],
      ),
    );
  }
}