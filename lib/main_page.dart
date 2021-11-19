import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendSmsPage extends StatefulWidget {
  @override
  _SendSmsPageState createState() => _SendSmsPageState();
}

//FF2400
class _SendSmsPageState extends State<SendSmsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menýu",
          style: TextStyle(fontFamily: "Bellota_Bold"),
        ),
        backgroundColor: Color(0xFF344955),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Pul ugratmak",
                style: TextStyle(fontFamily: "Bellota_Bold", color: Color(0xFF344955), fontSize: 20),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(spreadRadius: 10, blurRadius: 10, color: Colors.grey[300], offset: Offset(5.0, 5.0))],
              ),
              height: 250,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(8), FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(fontSize: 20, color: Color(0xFF344955), fontFamily: "Bellota_Bold"),
                      decoration: InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF344955)))),
                      cursorColor: Color(0xFF344955),
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "TMT",
                          style: TextStyle(fontSize: 16, color: Color(0xFF344955), fontFamily: "Bellota_Bold"),
                        ),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            inputFormatters: [LengthLimitingTextInputFormatter(2), FilteringTextInputFormatter.digitsOnly],
                            style: TextStyle(fontSize: 20, color: Color(0xFF344955), fontFamily: "Bellota_Bold"),
                            decoration: InputDecoration(border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF344955)))),
                            cursorColor: Color(0xFF344955),
                          ),
                        ),
                        FlatButton(
                            color: Color(0xFF344955),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            onPressed: () {},
                            child: Text("Ugratmak", style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: "Bellota_Bold")))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
