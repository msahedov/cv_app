import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/NoConnection.dart';
import 'package:e_commerce_app/Others/Routes/route_names.dart';
import 'package:e_commerce_app/Others/l10n/language_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Others/Widgets/Listview.dart';
import '../Others/Widgets/Listview_discount.dart';
import '../Others/constants/constants.dart';
import 'Markets/MarketsHomePage.dart';
import 'components/Banners.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {}
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  AppBar appBar() => AppBar(
        leading: LanguagePickerWidget(),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Image.asset(
            "assets/icons/logo.jpg",
            height: 60,
            width: 200,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, searchpage),
            icon: Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: SvgPicture.asset(
                'assets/icons/search.svg',
                color: kPrimaryColor_1,
                height: 50,
                width: 50,
              ),
            ),
          ),
        ],
      );

  Widget build(BuildContext context) {
    return SafeArea(
        child: _connectionStatus == "ConnectivityResult.none"
            ? NoConnnectionPage()
            : Scaffold(
                backgroundColor: textFieldbackColor,
                appBar: appBar(),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Banners(),
                    MarketsHomePage(),
                    Listview(),
                    ListviewDiscount(),
                  ]),
                ),
              ));
  }
}
