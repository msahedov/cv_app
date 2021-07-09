import 'package:e_commerce_app/Login%20Page/login_page.dart';
import 'package:e_commerce_app/Others/Models/authModel.dart';
import 'package:e_commerce_app/Others/l10n/locale_provider.dart';
import 'package:e_commerce_app/Profile%20Page/components/ProfileMenu.dart';
import 'package:e_commerce_app/Profile%20Page/screens/About_Us.dart';
import 'package:e_commerce_app/Profile%20Page/screens/NotificationsPage.dart';
import 'package:e_commerce_app/Profile%20Page/screens/OrdersPage.dart';
import 'package:e_commerce_app/Profile%20Page/screens/UserPage.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Others/Models/userModel.dart';
import '../../Others/constants/constants.dart';
import '../../Others/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> with TickerProviderStateMixin {
  bool _isLogin = false;
  int _uid;

  void getUserData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool isLogin = _prefs.getBool("isLoggedIn");
    int uid = _prefs.getInt('uid');
    setState(() {
      _uid = uid;
      _isLogin = isLogin == null ? false : isLogin;
    });
  }

  Animation<double> fadeAnimation;
  AnimationController fadeController;
  List<Widget> pages;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void dispose() {
    super.dispose();
    fadeController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    _initPackageInfo();
    fadeController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(fadeController);
    fadeController.forward();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  String languageFlag() {
    String image;
    String locale = AppLocalizations.of(context).localeName;
    switch (locale) {
      case 'tr':
        setState(() {
          image = "assets/images/diller/tm.png";
        });
        break;
      case 'ru':
        setState(() {
          image = "assets/images/diller/ru.png";
        });
        break;
      default:
        setState(() {
          image = "assets/images/diller/tm.png";
        });
        break;
    }

    return image;
  }

  Widget _languagePicker() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (BuildContext context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: borderRadius),
                title: Text(
                  AppLocalizations.of(context).select_lang,
                  style: buttonTextStyle,
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        final provider = Provider.of<LocaleProvider>(context, listen: false);
                        provider.setLocale(Locale('tr'));
                        Navigator.pop(context);
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/diller/tm.png',
                        ),
                        radius: 23,
                      ),
                      title: Text(
                        'Türkmen',
                        style: buttonTextStyle,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        final provider = Provider.of<LocaleProvider>(context, listen: false);
                        provider.setLocale(Locale('ru'));
                        Navigator.pop(context);
                      },
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/diller/ru.png',
                        ),
                        radius: 23,
                      ),
                      title: Text(
                        'Русский',
                        style: buttonTextStyle,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context).closeBtn, style: buttonTextStyle)),
                ],
              ),
            ),
          );
        },
        transitionDuration: kAnimationDuration,
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return null;
        });
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: FadeTransition(
        opacity: fadeAnimation,
        child: Text(
          AppLocalizations.of(context).profil,
          style: TextStyle(
            color: kPrimaryColor_1,
            fontWeight: FontWeight.bold,
            fontFamily: popPinsRegular,
            fontSize: 20,
          ),
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
    );

    final profileItems = <Map<String, dynamic>>[
      {"text": AppLocalizations.of(context).myaccount, "icon": "assets/icons/user.svg"},
      {'text': AppLocalizations.of(context).myorders, "icon": "assets/icons/cart.svg"},
      {'text': AppLocalizations.of(context).notifications, "icon": "assets/icons/bell.svg"},
      {'text': _isLogin ? AppLocalizations.of(context).logout : AppLocalizations.of(context).login, "icon": "assets/icons/Log out.svg"},
      {"text": AppLocalizations.of(context).aboutUs, "icon": "assets/icons/info.svg"},
    ];

    pages = <Widget>[
      UserPage(title: profileItems[0]["text"]),
      OrdersPage(title: profileItems[1]["text"]),
      NotificationsPage(
        title: profileItems[2]["text"],
      ),
      AboutUs(
        title: profileItems[4]["text"],
      )
    ];

    final divider = Divider(thickness: 0.6, color: Colors.grey[300], height: 0.2, indent: 10.0, endIndent: 10.0);

    //ignore: deprecated_member_use
    FlatButton primaryButton({String text, Function onPressed, Widget child, Radius topRadius, Radius bottomRadius}) => FlatButton(
          color: Colors.white,
          padding: buttonPadding,
          shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.only(topLeft: topRadius ?? Radius.zero, topRight: topRadius ?? Radius.zero, bottomLeft: bottomRadius ?? Radius.zero, bottomRight: bottomRadius ?? Radius.zero),
          ),
          onPressed: onPressed,
          child: Container(
            margin: buttonMargin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: buttonTextStyle,
                ),
                child ?? SizedBox(),
              ],
            ),
          ),
        );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: textFieldbackColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ProfileMenu(
                  text: profileItems[0]["text"],
                  icon: profileItems[0]["icon"],
                  press: () {
                    Navigator.push(
                        context, PageTransition(ctx: context, curve: curve, reverseDuration: kAnimationDuration, duration: kAnimationDuration, child: _isLogin ? pages[0] : LoginPage(), type: type));
                  }),
              ProfileMenu(
                text: profileItems[1]["text"],
                icon: profileItems[1]["icon"],
                press: () => Navigator.push(context, PageTransition(ctx: context, curve: curve, reverseDuration: kAnimationDuration, duration: kAnimationDuration, child: pages[1], type: type)),
              ),
              ProfileMenu(
                text: profileItems[2]["text"],
                icon: profileItems[2]["icon"],
                press: () => Navigator.push(context, PageTransition(ctx: context, curve: curve, reverseDuration: kAnimationDuration, duration: kAnimationDuration, child: pages[2], type: type)),
              ),
              ProfileMenu(
                text: profileItems[4]["text"],
                icon: profileItems[4]["icon"],
                press: () => Navigator.push(context, PageTransition(ctx: context, curve: curve, reverseDuration: kAnimationDuration, duration: kAnimationDuration, child: pages[3], type: type)),
              ),
              ProfileMenu(
                  text: profileItems[3]["text"],
                  icon: profileItems[3]["icon"],
                  press: () {
                    _isLogin
                        ? primaryDialog(
                            context: context,
                            positiveAnswertext: AppLocalizations.of(context).yes,
                            negativeAnswertext: AppLocalizations.of(context).no,
                            text: AppLocalizations.of(context).logoutQuiz,
                            positivePress: () {
                              UserModel().logOut().then((isSucces) {
                                if (isSucces) {
                                  Auth().logout();
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                        content: Text(AppLocalizations.of(context).logOutPos, style: TextStyle(fontFamily: popPinsRegular, fontSize: 13)),
                                        action: SnackBarAction(
                                          label: "OK",
                                          onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                                        )));
                                  RestartWidget.restartApp(context);
                                } else {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(SnackBar(
                                        content: Text(AppLocalizations.of(context).logOutNeg, style: TextStyle(fontFamily: popPinsRegular, fontSize: 13)),
                                        action: SnackBarAction(
                                          label: "OK",
                                          onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                                        )));
                                }
                              });
                            },
                            negativePress: () => Navigator.pop(context))
                        : Navigator.push(context, PageTransition(ctx: context, curve: curve, reverseDuration: kAnimationDuration, duration: kAnimationDuration, child: LoginPage(), type: type));
                  }),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(30, 30, 0, 10),
                child: Text(
                  AppLocalizations.of(context).settings,
                  style: buttonTextStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(border: Border.fromBorderSide(BorderSide.none), borderRadius: borderRadius, color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    primaryButton(
                      text: AppLocalizations.of(context).langBtn,
                      onPressed: () => _languagePicker(),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          languageFlag(),
                        ),
                        radius: 20,
                      ),
                      topRadius: buttonRadius,
                      bottomRadius: null,
                    ),
                    divider,
                    primaryButton(
                      text: AppLocalizations.of(context).version,
                      onPressed: null,
                      child: Text(
                        "${_packageInfo.version}",
                        style: TextStyle(color: kPrimaryColor, fontSize: 15, fontFamily: popPinsRegular, fontWeight: FontWeight.w500),
                      ),
                      topRadius: null,
                      bottomRadius: null,
                    ),
                    divider,
                    primaryButton(
                        text: AppLocalizations.of(context).rating_play_store,
                        onPressed: () => LaunchReview.launch(
                              androidAppId: "com.iyaffle.kural",
                              iOSAppId: "585027354",
                            ),
                        child: null,
                        topRadius: null,
                        bottomRadius: buttonRadius),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
