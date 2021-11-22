import 'package:e_commerce_app/carStore/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:stripe_payment/stripe_payment.dart';
import '../objects/car_item_object.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../constants/page_routs.dart';

class OrderScreen extends StatefulWidget {
  dynamic car;

  OrderScreen({this.car = "1"});

  @override
  State<StatefulWidget> createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  int currentPage = 0;
  final _pageViewController = PageController(initialPage: 0);
  bool hasOrder = false;
  Widget loadingWidget = SizedBox(
    height: 1,
  );
  bool _rememberMeCheckboxValue = false;

  _placeOrder() {
    if (hasOrder) {
      loadingWidget = LoadingIndicator(
        indicatorType: Indicator.ballPulse,
        color: Colors.white,
      );
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          loadingWidget = SizedBox(
            height: 1,
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Car succesfully ordered to the address",
            style: TextStyle(fontFamily: descFont, fontSize: 18, color: Colors.blue),
          )));
          Future.delayed(Duration(seconds: 5), () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          });
        });
      });
    } else {
      loadingWidget = SizedBox(
        height: 1,
      );
    }
    hasOrder = !hasOrder;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Making order",
            style: TextStyle(fontFamily: descFont, color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black //.fromRGBO(124, 131, 142, 1),
                  ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()))),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: Colors.black, statusBarColor: Colors.blue //Color(0xFF344955),
              )),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Colors.grey], stops: [0, 1]), color: Color.fromRGBO(220, 225, 231, 1)),
        height: double.infinity,
        width: double.infinity,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                // Text(
                //   "Making order",
                //   style: TextStyle(fontFamily: descFont, color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
                // ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20, fontFamily: descFont),
                          decoration: InputDecoration(labelText: "Name", labelStyle: TextStyle(fontSize: 20, color: Colors.white, fontFamily: descFont)),
                          validator: (input) => input.isEmpty ? "Please enter a valid email" : null,
                          onSaved: (input) => print(input),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20, fontFamily: descFont),
                          decoration: InputDecoration(labelText: "Delivery address", labelStyle: TextStyle(fontSize: 20, color: Colors.white, fontFamily: descFont)),
                          validator: (input) => input.isEmpty ? "Please enter a valid email" : null,
                          onSaved: (input) => print(input),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20, fontFamily: descFont),
                          decoration: InputDecoration(labelText: "Town", labelStyle: TextStyle(fontSize: 20, color: Colors.white, fontFamily: descFont)),
                          validator: (input) => input.isEmpty ? "Please enter a valid email" : null,
                          onSaved: (input) => print(input),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20, fontFamily: descFont),
                          decoration: InputDecoration(labelText: "Area code", labelStyle: TextStyle(fontSize: 20, color: Colors.white, fontFamily: descFont)),
                          validator: (input) => input.isEmpty ? "Please enter a valid email" : null,
                          onSaved: (input) => print(input),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  value: _rememberMeCheckboxValue,
                                  onChanged: (value) {
                                    _rememberMeCheckboxValue = value;
                                    setState(() {});
                                  }),
                              Text(
                                "Remember me",
                                style: TextStyle(fontFamily: descFont, fontSize: 20),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: Container(
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, fontFamily: descFont),
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "0000-0000-0000-0000", hintStyle: TextStyle(fontFamily: descFont, fontSize: 20), labelStyle: TextStyle(color: Colors.grey)),
                      validator: (input) => input.isEmpty ? "Please enter a valid email" : null,
                      onSaved: (input) => print(input),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20, fontFamily: descFont),
                      decoration:
                          InputDecoration(border: InputBorder.none, hintText: "Name on the Card", hintStyle: TextStyle(fontFamily: descFont, fontSize: 20), labelStyle: TextStyle(color: Colors.grey)),
                      validator: (input) => input.isEmpty ? "Please enter a valid email" : null,
                      onSaved: (input) => print(input),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 40, maxWidth: 70),
                    child: loadingWidget,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () => _placeOrder(),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Color.fromRGBO(109, 130, 159, 1), borderRadius: BorderRadius.circular(25)),
                            child: Center(
                                child: Text(
                              "Place order",
                              style: TextStyle(
                                fontFamily: descFont,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
