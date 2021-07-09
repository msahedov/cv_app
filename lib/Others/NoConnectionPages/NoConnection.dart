import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:flutter/material.dart';

class NoConnnectionPage extends StatefulWidget {
  @override
  _NoConnnectionPageState createState() => _NoConnnectionPageState();
}

class _NoConnnectionPageState extends State<NoConnnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 250),
            child: SizedBox(
              height: 200,
              width: 300,
              child: Image.asset(
                'assets/images/emptyState/Error.png',
                fit: BoxFit.fitWidth,
                height: 200,
                width: 300,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Нет соединения с интернетом',
              style: TextStyle(color: kPrimaryColor_1, fontSize: 18, fontFamily: popPinsBold, fontWeight: FontWeight.bold, shadows: [Shadow(color: kPrimaryColor_1, blurRadius: 1)]),
            ),
          ),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              'Повторить попытку',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor, fontFamily: popPinsSemiBold),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    action: SnackBarAction(
                      textColor: kPrimaryColor,
                      label: 'OK',
                      onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    elevation: 5.0,
                    backgroundColor: kPrimaryColor_1,
                    content: Text(
                      'Не удалось. Попробуйте еще раз',
                      style: TextStyle(color: kPrimaryColor, fontSize: 16.0, fontStyle: FontStyle.italic, fontFamily: popPinsRegular),
                    ),
                  ),
                );
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: kPrimaryColor_1,
          )
        ],
      ),
    ));
  }
}
