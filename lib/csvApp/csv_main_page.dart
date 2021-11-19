import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'csv_create_page.dart';
import 'csv_edit_page.dart';
import 'csv_model.dart';
import 'csv_view_page.dart';
import 'db_helper.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Personal Details",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: "Bellota_Bold",
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light, statusBarColor: Colors.blue, systemNavigationBarColor: Colors.blue),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create",
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilPage())),
      ),
      body: FutureBuilder<List<Person>>(
          future: DatabaseHelper().PersonDetailTheClass(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 220,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          snapshot.data[index].photo == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(45.0),
                                  child: Image.asset(
                                    "assets/fonts/person.png",
                                    height: 90,
                                    width: 90,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: Image.memory(
                                    snapshot.data[index].photo,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  )),
                          Text(
                            snapshot.data[index].name,
                            style: TextStyle(fontFamily: "Bellota_Bold", fontSize: 18),
                          ),
                          Text(snapshot.data[index].email, style: TextStyle(fontSize: 18, fontFamily: "Bellota_Bold")),
                          Container(
                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FlatButton.icon(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CsvEditPage(
                                                    person: snapshot.data[index],
                                                  ))),
                                      label: Text(
                                        "Edit",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: "Bellota_Bold",
                                        ),
                                      )),
                                  FlatButton.icon(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: Text(
                                                    "Do you want to delete ?",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: "Bellota_Bold",
                                                    ),
                                                  ),
                                                  actions: [
                                                    FlatButton(
                                                        onPressed: () {
                                                          DatabaseHelper().DeletePerson(snapshot.data[index].id);
                                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                                                        },
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontFamily: "Bellota_Bold",
                                                          ),
                                                        )),
                                                    FlatButton(
                                                        onPressed: () => Navigator.pop(context),
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontFamily: "Bellota_Bold",
                                                          ),
                                                        ))
                                                  ],
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                  title: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: "Bellota_Bold",
                                                    ),
                                                  ),
                                                ));
                                      },
                                      label: Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: "Bellota_Bold",
                                        ),
                                      )),
                                  FlatButton.icon(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.white,
                                      ),
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CsvViewPage(person: snapshot.data[index]))),
                                      label: Text(
                                        "View",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontFamily: "Bellota_Bold",
                                        ),
                                      )),
                                ],
                              ))
                        ],
                      ),
                      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1.0)], borderRadius: BorderRadius.circular(10), color: Colors.white),
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
