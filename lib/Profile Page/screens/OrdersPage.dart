import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:e_commerce_app/Login%20Page/login_page.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/NoConnection.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/Empty_state_page.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Others/Models/common.dart';
import '../../Others/constants/constants.dart';
import '../../Others/constants/sizeconfig.dart';
import '../../Others/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersPage extends StatefulWidget {
  final String title;

  OrdersPage({@required this.title});
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
  bool _isLogin = false;
  int _uid;

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

  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool isLogin = _prefs.getBool("isLoggedIn");
    int uid = _prefs.getInt('uid');
    setState(() {
      _uid = uid;
      _isLogin = isLogin == null ? false : isLogin;
    });
  }

  void initState() {
    super.initState();
    getUserData();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Column adress({String name, String adress, String payment}) {
    final TextStyle style = TextStyle(fontFamily: popPinsRegular, color: Colors.grey);
    final margin = EdgeInsets.only(left: 15);
    return Column(
      children: [
        Container(
          margin: margin,
          child: Text(
            '${AppLocalizations.of(context).orderAdress}: $adress',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Container(
          margin: margin,
          child: Text(
            '${AppLocalizations.of(context).paymentMethod}: $payment',
            style: style,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget product({OrderItem item}) {
    TextStyle style(double size, Color color, bool weight) => TextStyle(fontWeight: weight ? FontWeight.bold : null, fontSize: size, fontFamily: popPinsRegular, color: color);
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              maxRadius: 50,
              minRadius: 45,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage("$serverUrl${item.images[0]}"), // AssetImage('assets/images/items/${index + 1}.png'),
            ),
            Positioned(
                right: 0.0,
                child: CircleAvatar(
                    maxRadius: 17,
                    minRadius: 15,
                    backgroundColor: kPrimaryColor,
                    child: Text(
                      '+${item.quantity}',
                      style: style(12, Colors.white, false),
                    ))),
          ],
        ),
        Text(
          '${item.name_tm}',
          style: style(16, kPrimaryColor_1, true),
        ),
        Text(
          '${item.price} man',
          style: style(12, kPrimaryColor_1, false),
        ),
        Text(
          '${item.totalPrice} man',
          style: style(12, kPrimaryColor_1, false),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 10, vertical: 5.0);
    final subtitleStyle = TextStyle(fontFamily: popPinsRegular, color: kPrimaryColor, fontSize: 14);

    return _connectionStatus == "ConnectivityResult.none"
        ? NoConnnectionPage()
        : Scaffold(
            backgroundColor: textFieldbackColor,
            appBar: primaryAppBar(
              context: context,
              title: widget.title,
            ),
            body: _isLogin
                ? SizedBox(
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    child: FutureBuilder<List<Order>>(
                        future: Order().getAllOrders(userId: _uid).then((value) {
                          return value;
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasError)
                            return NoDataErrorPage(onTap: () {
                              setState(() {});
                            });
                          else if (snapshot.hasData)
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: padding,
                                    child: ClipRRect(
                                      borderRadius: borderRadius,
                                      child: ExpansionTile(
                                        backgroundColor: Colors.white,
                                        collapsedBackgroundColor: Colors.white,
                                        title: snapshot.data[index].isDelivered
                                            ? Text(AppLocalizations.of(context).orderIsDelivired, style: TextStyle(fontFamily: popPinsMedium, color: Colors.green, fontSize: 18))
                                            : Text(AppLocalizations.of(context).orderIsNotDelivired, style: TextStyle(fontFamily: popPinsMedium, color: kPrimaryColor, fontSize: 18)),
                                        subtitle: Text(
                                          snapshot.data[index].shippingAddress,
                                          style: subtitleStyle,
                                        ),
                                        children: [
                                          SizedBox(
                                            height: 170,
                                            child: FutureBuilder<Order>(
                                                future: Order().getOrderById(userId: _uid, orderId: snapshot.data[index].id).then((value) {
                                                  return value;
                                                }),
                                                builder: (context, _snapshot) {
                                                  if (_snapshot.hasError)
                                                    return IconButton(
                                                        icon: Icon(Icons.refresh),
                                                        onPressed: () {
                                                          setState(() {});
                                                        });
                                                  else if (_snapshot.hasData)
                                                    return ListView.builder(
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: _snapshot.data.orderedItems.length,
                                                        itemBuilder: (context, _index) {
                                                          //print(_snapshot.data.totalPrice);
                                                          return Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                                                            child: product(item: _snapshot.data.orderedItems[_index]),
                                                          );
                                                        });
                                                  else
                                                    return Center(child: spinKit());
                                                }),
                                          ),
                                          adress(name: snapshot.data[index].customerId.toString(), adress: snapshot.data[index].shippingAddress, payment: snapshot.data[index].paymentMethod),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${AppLocalizations.of(context).totalPrice} ${snapshot.data[index].totalPrice} TMT",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: Colors.black, letterSpacing: 0, fontFamily: popPinsSemiBold, fontSize: 20),
                                                ),
                                              ),
                                              Tooltip(
                                                textStyle: TextStyle(
                                                  fontFamily: popPinsRegular,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.fromBorderSide(BorderSide.none),
                                                  borderRadius: borderRadius,
                                                ),
                                                message: AppLocalizations.of(context).deleteOrder, //'Sargydy pozmak',
                                                // ignore: deprecated_member_use
                                                child: FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: borderRadius,
                                                  ),
                                                  color: kPrimaryColor,
                                                  onPressed: () => primaryDialog(
                                                      context: context,
                                                      positiveAnswertext: AppLocalizations.of(context).yes,
                                                      negativeAnswertext: AppLocalizations.of(context).no,
                                                      text: AppLocalizations.of(context).deleteOrderQuiz, //'Siz hakykatdan hem sargydy pozmak isleýärsiňizmi?',
                                                      positivePress: () async {
                                                        await Order().deleteOrderById(orderId: snapshot.data[index].id, userId: _uid).then((value) {
                                                          Navigator.pop(context);
                                                          Future.delayed(Duration(milliseconds: 500), () {
                                                            ScaffoldMessenger.of(context)
                                                              ..removeCurrentSnackBar()
                                                              ..showSnackBar(SnackBar(
                                                                  content: Text(AppLocalizations.of(context).deleteOrderSuccesSnak, style: TextStyle(fontFamily: popPinsRegular, fontSize: 13)),
                                                                  action: SnackBarAction(
                                                                    label: "OK",
                                                                    onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                                                                  )));
                                                            setState(() {});
                                                          });
                                                        }).onError((error, stackTrace) {
                                                          Navigator.pop(context);
                                                          Future.delayed(Duration(milliseconds: 500), () {
                                                            ScaffoldMessenger.of(context)
                                                              ..removeCurrentSnackBar()
                                                              ..showSnackBar(SnackBar(
                                                                  content: Text(AppLocalizations.of(context).deleteOrderNotSuccesSnak, style: TextStyle(fontFamily: popPinsRegular, fontSize: 13)),
                                                                  action: SnackBarAction(
                                                                    label: "OK",
                                                                    onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                                                                  )));
                                                            setState(() {});
                                                          });
                                                        });
                                                      },
                                                      negativePress: () => Navigator.pop(context)),
                                                  child: SvgPicture.asset("assets/icons/trash.svg", fit: BoxFit.contain, color: kPrimaryColor_1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          return Center(child: spinKit());
                        }),
                  )
                : EmptyPage(
                    selectedIndex: 6,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                  ),
          );
  }
}
