import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/NoConnection.dart';
import 'package:e_commerce_app/Others/l10n/language_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Others/constants/constants.dart';
import '../Others/constants/sizeconfig.dart';
import 'sign_in/components/sign_form.dart';
import 'sign_up/components/sign_up_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int selectedPage = 0;
  PageController _pageController = new PageController();
  String _connectionStatus = 'Unknown';

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
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

  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> tabItems = <int, Widget>{
      0: Text(AppLocalizations.of(context).signInBtnName, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, color: kPrimaryColor_1, fontFamily: "Poppins_SemiBold")),
      1: Text(AppLocalizations.of(context).signUpBtnName, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, color: kPrimaryColor_1, fontFamily: "Poppins_SemiBold")),
    };

    return _connectionStatus == "ConnectivityResult.none"
        ? NoConnnectionPage()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: textFieldbackColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: textFieldbackColor,
              elevation: 0.0,
              actions: [
                LanguagePickerWidget(),
              ],
            ),
            body: Center(
              child: Container(
                decoration: BoxDecoration(borderRadius: borderRadius15),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
                child: ClipRRect(
                  borderRadius: borderRadius15,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: AnimatedContainer(
                      decoration: BoxDecoration(borderRadius: borderRadius15),
                      curve: Curves.decelerate,
                      duration: Duration(milliseconds: 300),
                      height: 600,
                      width: 400,
                      child: Center(
                        child: PageView(
                          onPageChanged: (index) {
                            setState(() {
                              selectedPage = index;
                            });
                          },
                          controller: _pageController,
                          children: [SignForm(), SignUpForm()],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
              color: textFieldbackColor,
              height: 60,
              alignment: Alignment.center,
              child: CupertinoSlidingSegmentedControl(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                groupValue: selectedPage,
                thumbColor: kPrimaryColor,
                onValueChanged: (value) {
                  _pageController.animateToPage(value, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
                },
                children: tabItems,
              ),
            ),
          );
  }
}
