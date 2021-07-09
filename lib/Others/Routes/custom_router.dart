import 'package:e_commerce_app/Home%20Page/HomePage.dart';
import 'package:e_commerce_app/Others/Widgets/SearchPage.dart';
import '../../BottomNavBar.dart';
import '../../connection_check.dart';
import 'route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case bottomnavbar:
        return CupertinoPageRoute(builder: (_) => BottomNavBar());
        break;
      case connectionCheck:
        return CupertinoPageRoute(builder: (_) => ConnectionCheck());
        break;
      case homepage:
        return CupertinoPageRoute(builder: (_) => HomePage());
        break;
      case searchpage:
        return CupertinoPageRoute(builder: (_) => SearchPage());
        break;
      default:
        return CupertinoPageRoute(builder: (_) => BottomNavBar());
        break;
    }
  }
}
