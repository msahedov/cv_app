import 'package:flutter/material.dart';
import 'carStore/screens/home_page.dart';
import 'cvAppFlutter/screen/on_boarding/on_boarding_page.dart';

void main() => runApp(MyApp());
// SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: Colors.black, statusBarColor: Colors.blue //Color(0xFF344955),
//         ));
// runApp(App());

Future run() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
  runApp(MyApp());
  // });
}

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

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage() //MainPage(),
        );
  }
}
