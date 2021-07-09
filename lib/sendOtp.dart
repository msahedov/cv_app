import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;

onBackgroundMessage(SmsMessage message) async {
  debugPrint("onBackgroundMessage called $message");
  await Telephony.backgroundInstance.sendSmsByDefaultApp(to: message.address, message: "Ussa verification code: 123456"); //insatnce.sendSms(to: "123456789", message: "Message from background");
}

class SendOtp extends StatefulWidget {
  @override
  _SendOtpState createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  String _message = "";
  String _sender = "";
  final telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  sendMessageToBackend(String phonenumber, int smsCode, String time) async {
    final response = await http.post(Uri.http("192.168.1.106:5000", "/api/v1/auth/sendOtp"),
        body: jsonEncode(<String, dynamic>{"phoneNumber": phonenumber, "verification_code": "$smsCode", "time": time}),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        });
    print(response.body);
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
      _sender = message.address;
    });
    telephony.sendSms(to: message.address, message: "Ussa verification code: 1234");
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

  Future<void> initPlatformState() async {
    final bool result = await telephony.requestSmsPermissions;
    if (result != null && result) {
      telephony.listenIncomingSms(onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage, listenInBackground: true);
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor_1,
            title: Text('OTP Verification', style: TextStyle(color: kPrimaryColor, fontFamily: "PopPins_Regular")),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Latest received SMS: \n $_sender \n $_message ",
                style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsRegular),
              )),
              TextButton(
                  onPressed: () {
                    //telephony.sendSms(to: "+99362142340", message: "Ussa verification code: ");
                    //await telephony.openDialer("123413453");
                  },
                  child: Text('Open Dialer'))
            ],
          ),
        ));
  }
}
