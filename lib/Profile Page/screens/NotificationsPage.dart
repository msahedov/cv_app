import '../../Others/constants/constants.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final String title;
  const NotificationsPage({Key key, @required this.title}) : super(key: key);
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: kPrimaryColor_1,
        ),
      ),
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(
          color: kPrimaryColor_1,
          fontFamily: 'Poppins Regular',
        ),
      ),
      backgroundColor: Colors.white,
    );
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Container(
          height: size.height,
          width: size.width,
        ),
      ),
    );
  }
}
