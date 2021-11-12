import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'csv_model.dart';

class CsvViewPage extends StatefulWidget {
  final Person person;

  const CsvViewPage({
    this.person,
  });
  @override
  _CsvViewPageState createState() => _CsvViewPageState();
}

class _CsvViewPageState extends State<CsvViewPage> {
  void savePdfFile() async {
    final pdf = pw.Document();
    final output = await getExternalStorageDirectory();
    final image = pw.MemoryImage(widget.person.photo);
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Image(image, height: 120, width: 120, fit: pw.BoxFit.cover),
            pw.SizedBox(width: 30),
            pw.Expanded(
                child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(widget.person.name, style: pw.TextStyle(fontSize: 20)),
                pw.Text(widget.person.address, style: pw.TextStyle(fontSize: 20)),
                pw.Text(widget.person.email, style: pw.TextStyle(fontSize: 20)),
                pw.Text(widget.person.phone, style: pw.TextStyle(fontSize: 20)),
              ],
            )),
          ]);
          // Center
        })); //

    final file = File("${output.path}/${widget.person.name}.pdf");
    await file.create();
    await file.writeAsBytes(await pdf.save());
    file.exists();
  }

  var image;
  @override
  void initState() {
    setState(() {
      image = widget.person.photo;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                readOnly: true,
                initialValue: widget.person.name,
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
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Bellota_Bold",
                ),
                initialValue: widget.person.address,
                readOnly: true,
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
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Bellota_Bold",
                ),
                initialValue: widget.person.email,
                readOnly: true,
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
                initialValue: widget.person.phone,
                readOnly: true,
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
              SizedBox(
                height: 20,
              ),
              Center(
                child: FlatButton.icon(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    icon: Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: () => savePdfFile(),
                    label: Text(
                      "Download PDF",
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
