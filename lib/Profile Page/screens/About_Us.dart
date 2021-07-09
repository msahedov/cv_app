import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:e_commerce_app/Others/constants/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  final String title;

  const AboutUs({Key key, this.title}) : super(key: key);
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Widget text(String name, name1) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: AutoSizeText(
            name,
            overflow: TextOverflow.ellipsis,
            presetFontSizes: [16, 14, 12, 10],
            style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsMedium),
          ),
        ),
        SizedBox(
          width: 20, //size.width / 16,
        ),
        Expanded(
          flex: 1,
          child: AutoSizeText(
            name1,
            textAlign: TextAlign.start,
            presetFontSizes: [16, 14, 12, 10],
            style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsMedium),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: textFieldbackColor,
        appBar: primaryAppBar(
          context: context,
          title: widget.title,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              text("Telefon belgimiz:", "62-63-64"),
              text("Telefon belgimiz:", "33-51-51"),
              text("E-mail:", "ussa@gmail.com"),
              SizedBox(
                height: 60,
              ),
              Expanded(
                child: AutoSizeText(
                  "Sizi Ussa onlaýn söwda platformasynda hoş gördük ! \n\n Biziň USSA onlaýn gurluşyk markedimiz 2021-nji ýylyň iyul aýynyň 1-den bäri hyzmat edip gelýär.Häzirki wagtda USSA onlaýn marketimizde ýüzlerçe market öz işini ýöredýär we öz gurluşyk harytlaryny aňsatlyk bilen satýarlar.",
                  presetFontSizes: [16, 14, 12, 10],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsMedium),
                ),
              ),
            ],
          ),
        ));
  }
}
