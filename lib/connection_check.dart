import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'BottomNavBar.dart';

class ConnectionCheck extends StatefulWidget {
  @override
  _ConnectionCheckState createState() => _ConnectionCheckState();
}

class _ConnectionCheckState extends State<ConnectionCheck> {
  ConnectivityResult _connectivityResult;

  void checkConnection() {
    try {
      InternetAddress.lookup('google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Future.delayed(Duration(milliseconds: 2000), () {
            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => BottomNavBar()));
          });
          print('i came 1');
        } else {
          _showDialog();
        }
      }).catchError((error) {
        _showDialog();
      });
    } on SocketException catch (_) {
      _showDialog();
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult connrresult) {
      if (connrresult == ConnectivityResult.none) {
        print('i came 2');
      } else if (_connectivityResult == ConnectivityResult.none) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => BottomNavBar()));
        print("yes connection Fouunkmlkmd");
      }
      _connectivityResult = connrresult;
    });
  }

  void initState() {
    super.initState();
    checkConnection();
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: borderRadius20),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Container(
                      padding: EdgeInsets.only(top: 100),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Aragatnaşyk ýok',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: kPrimaryColor_1,
                              fontFamily: popPinsSemiBold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            child: Text(
                              'Internede baglanyp bolmady.Internet sazlamalryňyzy barlap gaýtadan synanşyň !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: popPinsMedium,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          RaisedButton(
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Future.delayed(Duration(milliseconds: 1000), () {
                                checkConnection();
                              });
                            },
                            child: AutoSizeText(
                              "Täzeden barla",
                              presetFontSizes: [22, 20, 18, 16, 14, 12, 10],
                              style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 70,
                      minRadius: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          child: Image.asset(
                            "assets/icons/noconnection.gif",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
                child: Image.asset(
              'assets/icons/logo.jpg',
              fit: BoxFit.fill,
              width: size.width / 2,
            )),
            Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(8),
                child: LinearProgressIndicator(
                  // color: kPrimaryColor,
                  backgroundColor: kPrimaryColor_1,
                ))
          ],
        ),
      ),
    );
  }
}
