import 'package:flutter/material.dart';
import 'carStore/screens/home_page.dart';
import 'cvAppFlutter/screen/on_boarding/on_boarding_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ResumePad',
      theme: ThemeData.light(),
      home: OnBoardingPage(),
    );
  }
}

