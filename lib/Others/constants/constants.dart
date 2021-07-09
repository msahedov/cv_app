import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

////Colors
const Color kPrimaryColor = Color(0xfffdc501); //fdc501
const Color textFieldbackColor = Color(0xFFFafafa);
const Color kPrimaryColor_1 = Color(0xff421e75); //421e75
const Color kTextColor = Color(0xFF757575);
const Color kPrimaryLightColor = Color(0xFFFFECDF);

// Form Error
final RegExp emailValidatorRegExp = RegExp(r'(^(?:[6])?[1-5]{1}?[0-9]{6}$)');

///BorderRadius
final radius = BorderRadius.all(Radius.circular(30.0));
final padding = const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0);
final textFieldPadding = EdgeInsets.only(left: 30);
final TextStyle labelStyle = TextStyle(fontFamily: popPinsRegular, color: kPrimaryColor);
final TextStyle hintStyle = TextStyle(fontFamily: popPinsRegular, fontSize: 15);
final TextStyle style = TextStyle(fontFamily: popPinsRegular, fontSize: 15, color: kPrimaryColor_1);
final sizedBox = SizedBox(height: 20);
final errorTextStyle = TextStyle(fontFamily: popPinsRegular);
final BorderRadius borderRadius = BorderRadius.circular(20.0);
final BorderRadius borderRadius10 = BorderRadius.all(Radius.circular(10));
final BorderRadius borderRadius15 = BorderRadius.all(Radius.circular(15));
final BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(20));
final BorderRadius borderRadius30 = BorderRadius.all(Radius.circular(30));
final buttonPadding = EdgeInsets.symmetric(vertical: 5.0);
final buttonRadius = Radius.circular(20.0);
final buttonMargin = EdgeInsets.all(10.0);
final curve = Curves.decelerate;
final type = PageTransitionType.rightToLeft;

///Duration
const Duration kAnimationDuration = Duration(milliseconds: 300);

///Padding
final EdgeInsets symmetricPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 10.0);

//Fonts
final String popPinsRegular = "Poppins_Regular";
final String popPinsBold = "Poppins_Bold";
final String popPinsSemiBold = "Poppins_SemiBold";
final String popPinsMedium = "Poppins_Medium";

//Icons sizen
final double icon_size = 30.0;

//fonts
final TextStyle textStyle = TextStyle(
  fontSize: 17,
  color: kPrimaryColor_1,
  fontFamily: popPinsSemiBold,
);

const String serverUrl = "http://ussalar.xyz";
