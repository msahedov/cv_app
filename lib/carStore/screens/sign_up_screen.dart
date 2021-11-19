import 'package:e_commerce_app/carStore/constants/page_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => MyHomePage(
                    title: "Car store",
                  )));
    }
  }

  _logIn() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark, systemNavigationBarColor: Colors.black, statusBarColor: Colors.white //Color(0xFF344955),
            ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 1,
                ),
                Image(
                  image: AssetImage(
                    "assets/images/app_logo.jpg",
                  ),
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 3, bottom: 3),
                                child: TextFormField(
                                  style: TextStyle(fontFamily: descFont, fontSize: 20),
                                  decoration: InputDecoration(labelText: "Email", labelStyle: TextStyle(fontSize: 20, fontFamily: descFont, color: Colors.grey)),
                                  validator: (input) => !input.contains("@") ? "Please enter a valid email" : null,
                                  onSaved: (input) => print(input),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 3, bottom: 3),
                                child: TextFormField(
                                  style: TextStyle(fontFamily: descFont, fontSize: 20),
                                  decoration: InputDecoration(labelText: "Password", labelStyle: TextStyle(fontSize: 20, fontFamily: descFont, color: Colors.grey)),
                                  validator: (input) => input.isEmpty ? "Please enter a valid password" : null,
                                  onSaved: (input) => print(input),
                                  obscureText: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 3, bottom: 3),
                                child: TextFormField(
                                  style: TextStyle(fontFamily: descFont, fontSize: 20),
                                  decoration: InputDecoration(labelText: "Repeat password", labelStyle: TextStyle(fontFamily: descFont, fontSize: 20, color: Colors.grey)),
                                  validator: (input) => input.isEmpty ? "Please enter a valid password" : null,
                                  onSaved: (input) => print(input),
                                  obscureText: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Container(
                              child: InkWell(
                                onTap: () => _submit(),
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: double.infinity,
                                  height: 70,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.green),
                                  child: Center(
                                      child: Text(
                                    "Sign Up",
                                    style: TextStyle(fontFamily: descFont, fontSize: 20, color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () => _logIn(),
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  width: double.infinity,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(fontFamily: descFont, fontSize: 20, color: Colors.grey, decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
