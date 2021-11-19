import 'package:flutter/material.dart';
import 'carStore/screens/home_page.dart';
import 'carStore/screens/login_screen.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: Colors.black, statusBarColor: Colors.blue //Color(0xFF344955),
  //         ));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage() //MainPage(),
        );
  }
}
