import 'package:flutter/material.dart';
import 'csv_main_page.dart';
import 'csv_model.dart';
import 'db_helper.dart';

class CsvEditPage extends StatefulWidget {
  final Person person;

  const CsvEditPage({
    this.person,
  });
  @override
  _CsvViewPageState createState() => _CsvViewPageState();
}

class _CsvViewPageState extends State<CsvEditPage> {
  var image;
  @override
  void initState() {
    setState(() {
      image = widget.person.photo;
      _name.text = widget.person.name;
      _address.text = widget.person.address;
      _email.text = widget.person.email;
      _phone.text = widget.person.phone;
    });
    super.initState();
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage())),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          "Resume",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: "Bellota_Bold",
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        widget.person.photo,
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/fonts/person.png")), borderRadius: BorderRadius.circular(15.0)),
                      height: 120,
                      width: 120,
                    ),
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
                controller: _name,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Bellota_Bold",
                ),
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
                controller: _address,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Bellota_Bold",
                ),
                minLines: 4,
                maxLines: 4,
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
                controller: _email,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Bellota_Bold",
                ),
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
                controller: _phone,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Bellota_Bold",
                ),
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
                height: 40,
              ),
              Center(
                child: FlatButton.icon(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    icon: Icon(
                      Icons.update,
                      color: Colors.white,
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      DatabaseHelper()
                          .UpdatePerson(Person(_name.text, _address.text, _email.text, _phone.text, widget.person.photo), widget.person.id)
                          .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage())))
                          .onError((error, stackTrace) => print("Errorr"));
                    },
                    label: Text(
                      "Update",
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
    );
  }
}
