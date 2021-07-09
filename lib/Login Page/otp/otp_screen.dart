import 'package:e_commerce_app/Login%20Page/sign_in/components/default_button.dart';
import 'package:e_commerce_app/Others/Models/authModel.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/services.dart';
import 'package:telephony/telephony.dart';
import '../../Others/Models/userModel.dart';
import '../../Others/constants/constants.dart';
import '../../Others/constants/sizeconfig.dart';
import '../../Others/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final String name;
  final String password;
  const OtpScreen({@required this.phone, @required this.name, @required this.password});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  bool isEnd = false;
  TextEditingController verController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar(
        context: context,
        title: '',
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("OTP Werifikasiýa",
                      style: TextStyle(
                        fontFamily: popPinsRegular,
                        color: kPrimaryColor_1,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "Şu belgä sms arkaly \n kod ugradylar +993 ${widget.phone}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: popPinsRegular),
                  ),
                  isEnd ? SizedBox.shrink() : buildTimer,
                  SizedBox(height: 100),
                  SizedBox(
                    width: 150,
                    height: 60,
                    child: TextFormField(
                      controller: verController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                      style: TextStyle(fontFamily: popPinsRegular, color: kPrimaryColor_1, fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 20),
                      decoration: InputDecoration(),
                    ),
                  ),
                  SizedBox(height: 60),
                  DefaultButton(
                    text: AppLocalizations.of(context).signUpBtnName,
                    press: () {
                      UserModel().signUp(name: widget.name, phoneNumber: widget.phone, password: widget.password, verification_code: verController.text).then((result) {
                        if (result == "Too many request from this IP, please try again in 5 minutes later") {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("Bu IP-den nädogry synanşyklaryň köp bolany üçin,5 minutdan soňra gaýtadan synanşyň")));
                        } else if (result == "Invalid verification code") {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("Werifikasiýa kod nädogry")));
                        } else if (result == "Invalid credentials") {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("Telefon belgiňiz nädogry")));
                        } else if (result == "Verification time is up. Please try again!") {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("Werifikasiýa wagty doldy.Gaýtadan sms ugradyň")));
                        } else {
                          Auth().login(name: result.name, uid: result.id, phone: result.phoneNumber);
                          RestartWidget.restartApp(context);
                        }
                      });
                    },
                  ),
                  isEnd
                      ? TextButton(
                          onPressed: () {
                            Telephony.instance.sendSms(to: "+99362990344", message: "");
                            setState(() {
                              isEnd = false;
                            });
                          },
                          child: Text(
                            "Sms kod gelmedi",
                            style: TextStyle(color: kPrimaryColor_1, fontSize: 15, fontFamily: popPinsRegular, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Wrap get buildTimer => Wrap(
        children: [
          Text(
            isEnd ? "" : "Sms koduň wagty ",
            style: TextStyle(fontFamily: popPinsRegular, color: Colors.grey[500]),
          ),
          SizedBox(
            height: 30,
          ),
          TweenAnimationBuilder(
            onEnd: () {
              setState(() {
                isEnd = true;
              });
            },
            tween: Tween(begin: 60.0, end: 0.0),
            duration: Duration(seconds: 60),
            builder: (_, value, child) => Text(
              isEnd ? "" : "00:${value.toInt()}",
              style: TextStyle(color: kPrimaryColor, fontFamily: popPinsSemiBold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(isEnd ? "" : " sekuntdan tamamlanýar", style: TextStyle(fontFamily: popPinsRegular, color: Colors.grey[500])),
        ],
      );
}
