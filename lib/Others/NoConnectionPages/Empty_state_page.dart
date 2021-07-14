import 'package:auto_size_text/auto_size_text.dart';
import '../constants/constants.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final int selectedIndex;
  final VoidCallback onTap;

  EmptyPage({Key key, this.selectedIndex, this.onTap}) : super(key: key);

  final List<Map<String, String>> page = [
    {
      "text": "Sebediňiz boş",
      "description": "Sargyt etmek üçin sebediňize haryt goşuň",
      "buttonText": "",
      "image": "assets/images/emptyState/NoItemsCart.png",
    },
    {
      "text": "Sebet",
      "description": "Sebediňize haryt goşmak üçin ulgama giriň",
      "buttonText": "Ulgama girmek",
      "image": "assets/images/emptyState/NoItemsCart.png",
    },
    {
      "text": "Halanlarym",
      "description": "Harytlary halananlaryňyza goşmak üçin ulgama giriň",
      "buttonText": "Ulgama girmek",
      "image": "assets/images/emptyState/NoItemsCart.png",
    },
    {
      "text": "Halanlaryňyz boş!",
      "description": "Harytlary soň görmek üçin halanlaryňyza goşuň",
      "buttonText": "",
      "image": "assets/images/emptyState/Done.png",
    },
    {
      "text": "Haryt tapylmady!",
      "description": "Şu wagtlykça şu kategoriýada harytlar ýok",
      "buttonText": "",
      "image": "assets/images/emptyState/NoDocuments.png",
    },
    {
      "text": "Haryt ýok",
      "description": "Hiç hili haryt tapylmady",
      "buttonText": "",
      "image": "assets/images/emptyState/NoDocuments.png",
    },
    {
      "text": "Sargytlarym",
      "description": "Sargyt etmek üçin ulgama giriň we sebediňize haryt goşuň",
      "buttonText": "Ulgama girmek",
      "image": "assets/images/emptyState/NoItemsCart.png",
    },
  ];

  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 100),
            Image.asset(
              page[selectedIndex]["image"],
            ),
            Column(
              children: [
                AutoSizeText(page[selectedIndex]["text"],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    presetFontSizes: [22, 20, 18, 16, 14, 12, 10, 8],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold)),
                AutoSizeText(page[selectedIndex]["description"],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    presetFontSizes: [18, 16, 14, 12, 10, 8],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[400], fontFamily: popPinsRegular)),
              ],
            ),
            page[selectedIndex]["buttonText"].length > 1
                ? RaisedButton(
                    onPressed: onTap,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    elevation: 1.0,
                    disabledColor: kPrimaryColor_1,
                    color: kPrimaryColor_1,
                    hoverColor: kPrimaryColor_1,
                    child: AutoSizeText(page[selectedIndex]["buttonText"],
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        presetFontSizes: [22, 20, 18, 16, 14, 12, 10, 8],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: kPrimaryColor, fontFamily: popPinsMedium)),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 100),
          ],
        ),
      ),
    ));
  }
}
