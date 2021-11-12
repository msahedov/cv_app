import 'dart:io';
import 'dart:typed_data';
import 'package:e_commerce_app/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'csv_main_page.dart';
import 'csv_model.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  Future<Uint8List> _image;
  Uint8List image;
  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker.platform.pickImage(source: source);
    if (pickedFile != null) {
      try {
        setState(() {
          _image = File(pickedFile.path).readAsBytes();
        });
      } catch (Exception) {
        throw Exception("Exception");
      }
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage())),
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "New Resume",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: "Bellota_Bold",
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Bellota_Bold",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Bellota_Bold",
                  ),
                  controller: _name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    hintText: "Your name",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: "Bellota_Bold",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Bellota_Bold",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Bellota_Bold",
                  ),
                  minLines: 4,
                  maxLines: 4,
                  controller: _address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    hintText: "Address",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: "Bellota_Bold",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Bellota_Bold",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Bellota_Bold",
                  ),
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    hintText: "example@gmail.com",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: "Bellota_Bold",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Bellota_Bold",
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Bellota_Bold",
                  ),
                  controller: _phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    hintText: "+9936123456",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontFamily: "Bellota_Bold",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FutureBuilder(future: _image.then((value) {
                                setState(() {
                                  image = value;
                                });
                                return value;
                              }), builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.memory(snapshot.data, fit: BoxFit.cover, height: 120, width: 120);
                                } else
                                  return CircularProgressIndicator();
                              }),
                            )
                          : Container(
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/fonts/person.png")), borderRadius: BorderRadius.circular(15.0)),
                              height: 120,
                              width: 120,
                            ),
                      Container(
                        height: 120,
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                onPressed: () => getImage(ImageSource.gallery),
                                child: Text(
                                  "Change",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: "Bellota_Bold",
                                  ),
                                )),
                            FlatButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                child: Text(
                                  "Remove",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: "Bellota_Bold",
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: FlatButton.icon(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Person person = Person(_name.text, _address.text, _email.text, _phone.text, image);
                        DatabaseHelper().AddPerson(person).then((value) {
                          _formKey.currentState.reset();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              action: SnackBarAction(label: "Go", onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()))),
                              content: Text(
                                "Succesfully added!",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: "Bellota_Bold",
                                ),
                              )));
                        });
                      },
                      label: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Bellota_Bold",
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
